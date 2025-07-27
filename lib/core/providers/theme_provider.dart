import 'package:flutter/material.dart';
import 'package:fedis_mockup_demo/themes/theme.dart';
import 'package:fedis_mockup_demo/core/storage/cache_helper.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  String? _userId;

  ThemeProvider(String? userId) {
    _userId = userId;
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode;
  ThemeData get currentTheme => _isDarkMode ? darkMode : lightMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    if (_userId != null) {
      CacheHelper.saveData('isDarkMode_$_userId', _isDarkMode);
    }
    notifyListeners();
  }

  void updateUser(String? userId) {
    _userId = userId;
    _loadTheme();
    notifyListeners();
  }

  void _loadTheme() {
    if (_userId != null) {
      _isDarkMode = CacheHelper.getData('isDarkMode_$_userId') ?? false;
    } else {
      _isDarkMode = false; // Default theme before login
    }
  }
}