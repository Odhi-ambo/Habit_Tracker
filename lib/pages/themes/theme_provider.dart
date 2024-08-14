import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/themes/dark_mode.dart';
import 'package:habit_tracker/pages/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  //initially starts as darkmode

  ThemeData _themeData = darkMode;

  //get current theme
  ThemeData get themeData => _themeData;

  //is current theme lightmode
  bool get isLightMode => _themeData == lightMode;

  //set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
