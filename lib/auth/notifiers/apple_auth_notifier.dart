import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isRunning = false;

  bool get isRunning => _isRunning;
}
