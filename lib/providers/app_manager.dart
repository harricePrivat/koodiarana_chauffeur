import 'package:flutter/material.dart';
import 'package:koodiarana_chauffeur/models/user.dart';
import 'package:koodiarana_chauffeur/services/app_security_cache.dart';

class AppManager extends ChangeNotifier {
  Users? users;
  bool? firstLogin;

  bool get getLogin => firstLogin!;

  void setFirstLogin(bool firstLogin) {
    this.firstLogin = firstLogin;
    notifyListeners();
  }

  void initializeApp() async {
    firstLogin = await AppSecurityCache().getFirstLogin();
    users = await AppSecurityCache().readConnection();
    notifyListeners();
  }

  Users? get getUsers => users;

  void connected(Users user) async {
    users = user;
    await AppSecurityCache().addConnection(user);
    notifyListeners();
  }

  void disconnected() async {
    users = null;
    await AppSecurityCache().removeConnection();
    notifyListeners();
  }

  void firstLoginDone() async {
    firstLogin = false;
    AppSecurityCache().setFirstLogin(false);
    notifyListeners();
  }

  void reFirstLogin() {
    firstLogin = true;
    AppSecurityCache().setFirstLogin(true);
    notifyListeners();
  }
}
