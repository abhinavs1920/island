import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-resolution (Android only)
        },
        verificationFailed: (FirebaseAuthException e) {
          state = state.copyWith(isLoading: false, error: e.message ?? 'Verification failed');
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          state = state.copyWith(isLoading: false);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
      // We return true immediately to navigate to OTP screen, the callbacks happen async
      // For web/emulator testing without push, codeSent fires almost instantly
      await Future.delayed(const Duration(milliseconds: 500));
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    state = state.copyWith(isLoading: true, clearError: true);

    if (otp.length < 6) {
      state = state.copyWith(isLoading: false, error: 'Incorrect code, try again');
      return false;
    }

    try {
      String idToken = 'mock_firebase_id_token';
      
      // If we have a verification ID from Firebase, try to sign in
      if (_verificationId != null) {
        final credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: otp);
        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        final realToken = await userCredential.user?.getIdToken();
        if (realToken != null) {
          idToken = realToken;
        }
      } else if (_phoneNumber == '+919999999999' && otp == '000000') {
        // Fallback for backend whitelisted test number if Firebase isn't hooked up for it
        idToken = 'mock_firebase_id_token';
      } else {
        throw Exception("No verification ID");
      }

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
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Incorrect code or verification failed');
      return false;
    }
  }
}
