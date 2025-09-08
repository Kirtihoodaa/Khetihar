import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  static const _kAccess = 'access_token';
  static const _storage = FlutterSecureStorage();

  static Future<void> saveTokens(String access) async {
    await _storage.write(key: _kAccess, value: access);
  }

  static Future<String?> get access async => _storage.read(key: _kAccess);

  static Future<void> clear() async {
    await _storage.delete(key: _kAccess);
  }
}
