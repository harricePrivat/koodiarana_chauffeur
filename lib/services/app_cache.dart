import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  String firstLogin = "firstLogin";

  void setFirstLogin(bool login) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(firstLogin, login);
  }

  Future<bool> getFirstLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(firstLogin) ?? true;
  }
}
