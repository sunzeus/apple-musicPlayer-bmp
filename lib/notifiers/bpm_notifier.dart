import 'package:flutter/material.dart';

class BPMNotifier extends ChangeNotifier {
  int _value = 50;

  int get value => _value;

  void updateValue(int newValue) {
    _value = newValue;
    notifyListeners();
  }
}
