// lib/providers/bmi_provider.dart
import 'package:flutter/material.dart';

class BMIProvider with ChangeNotifier {
  double _bmi = 0.0;
  double get bmi => _bmi;

  String _category = '';
  String get category => _category;

  void calculateBMI({required double weight, required double height}) {
    // height in meters
    _bmi = weight / (height * height);
    _category = _getBMICategory(_bmi);
    notifyListeners();
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 24.9) return "Normal";
    if (bmi < 29.9) return "Overweight";
    return "Obese";
  }

  void reset() {
    _bmi = 0.0;
    _category = '';
    notifyListeners();
  }
}
