import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:koodiarana_chauffeur/models/user.dart';

class AppSecurityCache {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  static const String _connectedKey = "connect";

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
}
