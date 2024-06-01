import 'package:flutter/material.dart';

class CategoryNotifier extends ChangeNotifier {
  String _activeCategory = "曲";

  String get activeCategory => _activeCategory;

  void updateCategory(String newCategory) {
    _activeCategory = newCategory;
    notifyListeners();
  }
}
