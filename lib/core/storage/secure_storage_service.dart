import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provider for [SecureStorageService]
final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return const SecureStorageService(FlutterSecureStorage(
    aOptions: AndroidOptions(resetOnError: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  ));
});

/// Service for persisting sensitive credentials and authentication tokens
class SecureStorageService {
  final FlutterSecureStorage _storage;

  const SecureStorageService(this._storage);

  static const String _accessTokenKey = 'auth_access_token';
  static const String _refreshTokenKey = 'auth_refresh_token';
  static const String _userIdKey = 'auth_user_id';

  /// Read access token
  Future<String?> getAccessToken() => _storage.read(key: _accessTokenKey);

  /// Save access token
  Future<void> setAccessToken(String token) =>
      _storage.write(key: _accessTokenKey, value: token);

  /// Read refresh token
  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);

  /// Save refresh token
  Future<void> setRefreshToken(String token) =>
      _storage.write(key: _refreshTokenKey, value: token);

  /// Read current user ID
  Future<String?> getUserId() => _storage.read(key: _userIdKey);

  /// Save current user ID
  Future<void> setUserId(String userId) =>
      _storage.write(key: _userIdKey, value: userId);

  /// Clear all stored secure credentials (e.g. on logout)
  Future<void> clearAuthData() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _userIdKey);
  }

  /// Delete all keys in secure storage
  Future<void> deleteAll() => _storage.deleteAll();
}
