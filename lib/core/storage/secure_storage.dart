import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());

class SecureStorage {
  final FlutterSecureStorage _storage;
  SecureStorage(this._storage);

  static const _tokenKey = 'jwt_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> saveTokens({required String token, required String refreshToken}) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getToken() => _storage.read(key: _tokenKey);
  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);
  
  Future<void> clearTokens() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}

final storageServiceProvider = Provider((ref) => SecureStorage(ref.watch(secureStorageProvider)));
