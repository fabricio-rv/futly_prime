import 'package:flutter/material.dart';
import '../../../data/storage/prefs_store.dart';

class ThemeController extends ChangeNotifier {
  final PrefsStore prefsStore;
  late String _themeMode; // 'system', 'light', 'dark'

  ThemeController(this.prefsStore) {
    _themeMode = prefsStore.getThemeMode();
  }

  String get themeMode => _themeMode;

  bool get isLight => _themeMode == 'light';
  bool get isDark => _themeMode == 'dark';
  bool get isSystem => _themeMode == 'system';

  Future<void> setThemeMode(String mode) async {
    if (_themeMode != mode) {
      _themeMode = mode;
      await prefsStore.setThemeMode(mode);
      notifyListeners();
    }
  }

  ThemeMode getThemeMode(BuildContext context) {
    if (_themeMode == 'light') return ThemeMode.light;
    if (_themeMode == 'dark') return ThemeMode.dark;
    return ThemeMode.system;
  }
}
