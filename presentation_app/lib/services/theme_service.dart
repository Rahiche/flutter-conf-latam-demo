import 'package:flutter/material.dart';

class ThemeService extends ChangeNotifier {
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();

  final ThemeMode _themeMode = ThemeMode.dark;
  String _currentThemeName = 'Ocean Blue';

  ThemeMode get themeMode => _themeMode;
  String get currentThemeName => _currentThemeName;

  static const Map<String, List<Color>> themes = {
    'Ocean Blue': [
      Color(0xFF0D47A1), // Colors.blue.shade900
      Color(0xFF1976D2), // Colors.blue.shade700
      Color(0xFF42A5F5), // Colors.blue.shade400
    ],
    'Deep Purple': [
      Color(0xFF311B92), // Colors.deepPurple.shade900
      Color(0xFF512DA8), // Colors.deepPurple.shade700
      Color(0xFF9575CD), // Colors.deepPurple.shade400
    ],
    'Midnight': [
      Color(0xFF000051), // Very dark blue
      Color(0xFF1A237E), // Indigo 900
      Color(0xFF3949AB), // Indigo 600
    ],
    'Cyberpunk': [
      Color(0xFF1A0033), // Deep purple black
      Color(0xFF6A1B9A), // Purple 800
      Color(0xFFE91E63), // Pink
    ],
    'Forest': [
      Color(0xFF1B5E20), // Green 900
      Color(0xFF2E7D32), // Green 800
      Color(0xFF66BB6A), // Green 400
    ],
  };

  List<Color> get currentGradient =>
      themes[_currentThemeName] ?? themes['Ocean Blue']!;

  void setTheme(String themeName) {
    if (themes.containsKey(themeName)) {
      _currentThemeName = themeName;
      notifyListeners();
    }
  }

  LinearGradient getGradient({bool reverse = false}) {
    final colors = reverse
        ? currentGradient.reversed.toList()
        : currentGradient;
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors,
    );
  }

  LinearGradient getSlideGradient(int slideIndex) {
    // You can customize gradients per slide if needed
    // For now, using the same gradient for all slides
    return getGradient();
  }

  Color get primaryColor => currentGradient[1];
  Color get accentColor => currentGradient[2];
  Color get backgroundColor => currentGradient[0];
}
