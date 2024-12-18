import 'package:flutter/material.dart';
import 'package:koodiarana_chauffeur/services/app_cache.dart';

class AppManager extends ChangeNotifier {
  int userId = -1;
  bool? firstLogin;

  bool get getLogin => firstLogin!;

  void setFirstLogin(bool firstLogin) {
    this.firstLogin = firstLogin;
    notifyListeners();
  }

  void initializeApp() async {
    print("J'initialise App Koodiarana");
    firstLogin = await AppCache().getFirstLogin();
    print("Voici mon firstLogin $firstLogin");
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
