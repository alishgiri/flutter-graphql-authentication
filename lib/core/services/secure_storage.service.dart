import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:auth_app/core/models/auth.model.dart';
import 'package:auth_app/core/models/auth_data.model.dart';

const accessToken = "access_token";
const refreshToken = "refresh_token";

class SecureStorageService {
  final _storage = FlutterSecureStorage(
    iOptions: _getIOSOptions(),
    aOptions: _getAndroidOptions(),
  );

  static IOSOptions _getIOSOptions() => const IOSOptions();

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> storeAuthData(Auth auth) async {
    await _storage.write(key: accessToken, value: auth.accessToken);
    await _storage.write(key: refreshToken, value: auth.refreshToken);
  }

  Future<AuthData> getAuthData() async {
    final map = await _storage.readAll();
    return AuthData(accessToken: map[accessToken], refreshToken: map[refreshToken]);
  }

  Future<void> updateAccessToken(String token) async {
    await _storage.delete(key: accessToken);
    await _storage.write(key: accessToken, value: token);
  }

  Future<void> updateRefreshToken(String token) async {
    await _storage.write(key: refreshToken, value: token);
  }

  Future<void> clearAuthData() async {
    await _storage.deleteAll();
  }
}
