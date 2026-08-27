import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/secure_storage.dart';
import '../router/app_router.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final storage = ref.watch(storageServiceProvider);
  final router = ref.watch(routerProvider);
  return ApiClient(storage, router);
});

class ApiClient {
  final SecureStorage _storage;
  final dynamic _router;
  late Dio _dio;

  ApiClient(this._storage, this._router) {
    const baseUrl = String.fromEnvironment('BASE_URL', defaultValue: 'http://10.0.2.2:8000');
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // Attempt refresh
          final refreshToken = await _storage.getRefreshToken();
          if (refreshToken != null) {
            try {
              final response = await Dio().post(
                '$baseUrl/auth/refresh',
                data: {'refresh_token': refreshToken},
              );
              final newToken = response.data['token'];
              final newRefresh = response.data['refresh_token'];
              await _storage.saveTokens(token: newToken, refreshToken: newRefresh);
              
              // Retry original request
              e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
              final cloneReq = await _dio.fetch(e.requestOptions);
              return handler.resolve(cloneReq);
            } catch (_) {
              await _storage.clearTokens();
              _router.go('/phone');
            }
          } else {
            _router.go('/phone');
          }
        }
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;
}
