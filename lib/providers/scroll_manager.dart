import 'package:flutter/material.dart';
class ScrollManager extends ChangeNotifier {
  bool visibleBottomBar = true;

  void hideBottomBar() {
    visibleBottomBar = false;
    notifyListeners();
  }

  void showBottomBar() {
    visibleBottomBar = true;
    notifyListeners();
  }

  bool get isVisibleBottomBar => visibleBottomBar;
}