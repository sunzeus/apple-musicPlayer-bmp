import 'package:bmp_music/features/bpm/services/read_bpm.dart';
import 'package:bmp_music/features/bpm/services/save_bpm.dart';
import 'package:flutter/material.dart';

class BPMNotifier extends ChangeNotifier {
  int _value = 0;

  int get value => _value;

  Future<void> init() async {
    _value = await readBPM() ?? 100;
    notifyListeners();
  }

  Future<void> updateValue(int newValue) async {
    _value = newValue;
    await saveBPM(newValue);
    notifyListeners();
  }

  bool _checked = true;

  bool get checked => _checked;

  void updateChecked() {
    _checked = !_checked;
    notifyListeners();
  }
}
