import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:koodiarana_chauffeur/models/user.dart';

class AppSecurityCache {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final String _connectedKey = "connect";
  final String _firstLogin = "firstLogin";

  //Cache about connection of user

  Future<void> addConnection(Users user) async {
    try {
      await storage.write(key: _connectedKey, value: jsonEncode(user.toJson()));
    } catch (e) {
      print("Error adding connection: $e");
    }
  }

  Future<Users?> readConnection() async {
    try {
      final users = await storage.read(key: _connectedKey);
      if (users == null || users.isEmpty) return null;
      return Users.fromJson(jsonDecode(users));
    } catch (e) {
      print("Error reading connection: $e");
      return null;
    }
  }

  Future<void> removeConnection() async {
    try {
      await storage.delete(key: _connectedKey);
    } catch (e) {
      print("Error removing connection: $e");
    }
  }

  //Cache about firstLogin or not
  Future<void> setFirstLogin(bool isFirst) async {
    try {
      if (isFirst) {
        await storage.write(key: _firstLogin, value: "isFirst");
      } else {
        await storage.write(key: _firstLogin, value: "isNotFirst");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> getFirstLogin() async {
    bool isFirst = false;
    try {
      final String value = await storage.read(key: _firstLogin) ?? "isNotFirst";
      if (value.compareTo("isFirst") == 0) {
        isFirst = true;
      }
    } catch (e) {
      print(e);
    }

    return isFirst;
  }
}
