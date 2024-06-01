import 'package:flutter/material.dart';

class BPMNotifier extends ChangeNotifier {
  int _value = 110;

  int get value => _value;

  void updateValue(int newValue) {
    _value = newValue;
    notifyListeners();
  }

  bool _checked = true;

  bool get checked => _checked;

  void updateChecked() {
    _checked = !_checked;
    notifyListeners();
  }
}
