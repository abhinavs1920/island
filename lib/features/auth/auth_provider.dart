import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      final res = await apiClient.dio.post('/refresh_session', data: {'refresh_token': refreshToken});
      if (res.statusCode == 200 || res.statusCode == 201) {
        final token = res.data['token'];
        final newRefresh = res.data['refresh_token'];
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

    _phoneNumber = cleaned;

    if (_testNumbers.contains(cleaned)) {
      // Skip Firebase, go straight through
      await Future.delayed(const Duration(milliseconds: 400));
      state = state.copyWith(isLoading: false);
      return true;
    }

    try {
      // Real Firebase Auth SDK call goes here
      await Future.delayed(const Duration(seconds: 1));
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

    // ── TEST MODE bypass ──
    if (_isTestNumber && otp == _testOtp) {
      await storage.saveTokens(token: _testJwt, refreshToken: _testRefresh);
      state = state.copyWith(isLoading: false);
      return true;
    }

    try {
      const String mockIdToken = 'mock_firebase_id_token';

      final res = await apiClient.dio.post('/verify_and_create_session', data: {
        'id_token': mockIdToken,
        'phone': _phoneNumber,
      });

      final token = res.data['token'];
      final refreshToken = res.data['refresh_token'];
      await storage.saveTokens(token: token, refreshToken: refreshToken);

      try {
        await apiClient.dio.post('/register_device_token', data: {
          'device_token': 'mock_device_token_for_push',
        });
      } catch (_) {}

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Incorrect code, try again');
      return false;
    }
  }
}
