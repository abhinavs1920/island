import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import '../../core/api/api_client.dart';
import '../../core/storage/secure_storage.dart';

// ─── TEST MODE ───────────────────────────────────────────────────────────────
// Any number in this set bypasses real Firebase OTP.
// Enter OTP "000000" on the verify screen to log in instantly.
const _testNumbers = {'9999999999', '1234567890'};
const _testOtp = '000000';
const _testJwt = 'test_jwt_token';
const _testRefresh = 'test_refresh_token';
// ─────────────────────────────────────────────────────────────────────────────

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    apiClient: ref.watch(apiClientProvider),
    storage: ref.watch(storageServiceProvider),
  );
});

class AuthState {
  final bool isLoading;
  final String? error;

  AuthState({this.isLoading = false, this.error});

  AuthState copyWith({bool? isLoading, String? error, bool clearError = false}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final ApiClient apiClient;
  final SecureStorage storage;
  String? _verificationId;

  AuthNotifier({required this.apiClient, required this.storage}) : super(AuthState());

  String? _phoneNumber;
  String? get phoneNumber => _phoneNumber;

  bool get _isTestNumber => _testNumbers.contains(_phoneNumber?.replaceAll(' ', ''));

  Future<bool> checkSession() async {
    final refreshToken = await storage.getRefreshToken();
    if (refreshToken == null) return false;

    // Test mode: treat the test tokens as always valid
    if (refreshToken == _testRefresh) return true;

    try {
      final res = await apiClient.dio.post('/auth/refresh', data: {'refresh_token': refreshToken});
      if (res.statusCode == 200 || res.statusCode == 201) {
        final token = res.data['access_token'];
        final newRefresh = res.data['refresh_token'] ?? refreshToken;
        await storage.saveTokens(token: token, refreshToken: newRefresh);
        return true;
      }
    } catch (_) {
      await storage.clearTokens();
    }
    return false;
  }

  Future<bool> sendOtp(String phone) async {
    state = state.copyWith(isLoading: true, clearError: true);
    final cleaned = phone.replaceAll(' ', '');

    if (cleaned.isEmpty || cleaned.length < 10) {
      state = state.copyWith(isLoading: false, error: 'Enter a valid 10-digit number');
      return false;
    }

    _phoneNumber = '+91$cleaned';
    
    final completer = Completer<bool>();
    String debugTrace = "1. Started sendOtp for $_phoneNumber\n";

    try {
      debugTrace += "2. Calling Firebase verifyPhoneNumber...\n";
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          debugTrace += "3. verificationCompleted triggered!\n";
          try {
            debugTrace += "4. Attempting signInWithCredential...\n";
            await FirebaseAuth.instance.signInWithCredential(credential);
            debugTrace += "5. signInWithCredential succeeded!\n";
            if (!completer.isCompleted) completer.complete(true);
          } catch (e) {
            debugTrace += "X. signInWithCredential failed: $e\n";
            state = state.copyWith(isLoading: false, error: debugTrace);
            if (!completer.isCompleted) completer.complete(false);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          debugTrace += "X. verificationFailed triggered!\n   Code: ${e.code}\n   Message: ${e.message}\n";
          state = state.copyWith(isLoading: false, error: debugTrace);
          if (!completer.isCompleted) completer.complete(false);
        },
        codeSent: (String verificationId, int? resendToken) {
          debugTrace += "3. codeSent triggered! verificationId received.\n";
          _verificationId = verificationId;
          state = state.copyWith(isLoading: false);
          if (!completer.isCompleted) completer.complete(true);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
      
      return await completer.future.timeout(
        const Duration(seconds: 15), 
        onTimeout: () {
          debugTrace += "X. Timed out waiting for Firebase callbacks.\n";
          state = state.copyWith(isLoading: false, error: debugTrace);
          return false;
        }
      );
    } catch (e) {
      debugTrace += "X. Outer try-catch failed: $e\n";
      state = state.copyWith(isLoading: false, error: debugTrace);
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    state = state.copyWith(isLoading: true, clearError: true);

    if (otp.length < 6) {
      state = state.copyWith(isLoading: false, error: 'Incorrect code, try again');
      return false;
    }

    String debugTrace = "1. Started verifyOtp\n";
    try {
      String? idToken;
      
      debugTrace += "2. Checking currentUser...\n";
      if (FirebaseAuth.instance.currentUser != null) {
        debugTrace += "3. currentUser found! Getting token...\n";
        idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
      }
      
      if (idToken == null && _verificationId != null) {
        debugTrace += "3. No currentUser. Using verificationId...\n";
        final credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: otp);
        debugTrace += "4. Attempting signInWithCredential...\n";
        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        debugTrace += "5. signIn succeeded! Getting token...\n";
        idToken = await userCredential.user?.getIdToken();
      }
      
      if (idToken == null) {
        debugTrace += "3. No currentUser AND no verificationId! Waiting 1s...\n";
        await Future.delayed(const Duration(seconds: 1));
        if (FirebaseAuth.instance.currentUser != null) {
           debugTrace += "4. currentUser appeared! Getting token...\n";
           idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
        } else {
           throw Exception("No verification ID or auto-resolution");
        }
      }
      debugTrace += "6. Token acquired! Sending to backend...\n";

      final res = await apiClient.dio.post('/auth/verify', data: {
        'firebase_id_token': idToken,
        'role': 'rider',
        'name': 'Rider',
        'device_name': 'Unknown',
        'fcm_token': 'mock_device_token_for_push',
        'platform': 'android',
        'os_version': '1.0',
        'app_version': '1.0.0',
      });

      final token = res.data['access_token'];
      final refreshToken = res.data['refresh_token'];
      await storage.saveTokens(token: token, refreshToken: refreshToken);

      state = state.copyWith(isLoading: false);
      return true;
    } on DioException catch (e) {
      debugTrace += "X. DioException: ${e.response?.data ?? e.message}\n";
      state = state.copyWith(isLoading: false, error: debugTrace);
      return false;
    } catch (e) {
      debugTrace += "X. Auth Error: ${e.toString()}\n";
      state = state.copyWith(isLoading: false, error: debugTrace);
      return false;
    }
  }
}
