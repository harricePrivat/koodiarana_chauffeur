import 'package:flutter/material.dart';
import 'package:koodiarana_chauffeur/models/user.dart';
import 'package:koodiarana_chauffeur/services/app_cache.dart';
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
    firstLogin = await AppCache().getFirstLogin();
    users = await AppSecurityCache().readConnection();
    notifyListeners();
  }

  Users? get getUsers => users;

  void connected(Users user) async {
    this.users = user;
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
    AppCache().setFirstLogin(false);
    notifyListeners();
  }

  void reFirstLogin() {
    firstLogin = true;
    AppCache().setFirstLogin(true);
    notifyListeners();
  }
}
