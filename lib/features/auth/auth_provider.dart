import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api/api_client.dart';
import '../../core/storage/secure_storage.dart';

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
  
  Future<bool> checkSession() async {
    final refreshToken = await storage.getRefreshToken();
    if (refreshToken == null) return false;
    
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
    try {
      // Mock Firebase Auth SDK integration
      await Future.delayed(const Duration(seconds: 1));
      if (phone.isEmpty || phone.length < 10) {
        state = state.copyWith(isLoading: false, error: 'Invalid phone number');
        return false;
      }
      _phoneNumber = phone;
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
  
  Future<bool> verifyOtp(String otp) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      // Mock Firebase ID token retrieval
      await Future.delayed(const Duration(seconds: 1));
      if (otp.length < 6) {
         state = state.copyWith(isLoading: false, error: 'Incorrect code, try again');
         return false;
      }
      
      final String mockIdToken = 'mock_firebase_id_token';
      
      // Call backend verify_and_create_session
      final res = await apiClient.dio.post('/verify_and_create_session', data: {
        'id_token': mockIdToken,
        'phone': _phoneNumber,
      });
      
      final token = res.data['token'];
      final refreshToken = res.data['refresh_token'];
      
      await storage.saveTokens(token: token, refreshToken: refreshToken);
      
      // Register device token
      try {
        await apiClient.dio.post('/register_device_token', data: {
          'device_token': 'mock_device_token_for_push',
        });
      } catch (_) {
        // Ignore device token errors for now
      }
      
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Incorrect code, try again');
      return false;
    }
  }
}
