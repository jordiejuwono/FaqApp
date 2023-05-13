import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  var selectedIndex = 0;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
