import 'package:flutter/material.dart';

class StepperNotifier extends ChangeNotifier {
  int currentStep = 0;

  void onChange(int i) {
    currentStep = i;
    notifyListeners();
  }
}
