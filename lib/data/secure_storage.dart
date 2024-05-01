import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  hasKey(String key) {
    return storage.containsKey(key: key);
  }

  getSecureData(String key) async {
    String? val = await storage.read(key: key) ?? null;
    return val.toString();
  }

  getAllSecureData() async {
    return await storage.readAll();
  }

  deleteSecureData(String key) async {
    await storage.delete(key: key);
  }

  deleteAllSecureData() async {
    return await storage.deleteAll();
  }
}
