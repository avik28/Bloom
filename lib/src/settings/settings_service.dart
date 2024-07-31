import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SettingsService {
  static const _themeModeKey = 'theme_mode';

  Future<ThemeMode> themeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final modeIndex = prefs.getInt(_themeModeKey) ?? ThemeMode.system.index;
    return ThemeMode.values[modeIndex];
  }

  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, newThemeMode.index);
  }
}
