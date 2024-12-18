import 'package:flutter/material.dart';

class NavigationManager extends ChangeNotifier {
  int tabValue = 0;

  void changeTab(int tabValue) {
    this.tabValue = tabValue;
    notifyListeners();
  }

  void goToFirst() {
    tabValue = 0;
    notifyListeners();
  }
}
