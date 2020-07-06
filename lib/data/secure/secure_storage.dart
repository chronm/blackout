import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final databasePassword = "databasePassword";
  final storage = FlutterSecureStorage();

  Future<String> getDatabasePassword() async {
    return await storage.read(key: databasePassword);
  }

  Future<void> setDatabasePassword(String password) async {
    return await storage.write(key: databasePassword, value: password);
  }
}
