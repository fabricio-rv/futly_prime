import 'package:shared_preferences/shared_preferences.dart';

class PrefsStore {
  static const String _seenOnboardingKey = 'seenOnboarding';
  static const String _themeModeKey = 'themeMode';
  static const String _premiumKey = 'isPremium';
  static const String _historyModeKey = 'historyModeEnabled';
  static const String _favoritesKey = 'favorites';
  static const String _kitKey = 'myKit';
  static const String _authModeKey = 'authMode';
  static const String _isLoggedInKey = 'isLoggedIn';

  final SharedPreferences _prefs;

  PrefsStore(this._prefs);

  // Onboarding
  Future<void> setSeenOnboarding(bool seen) =>
      _prefs.setBool(_seenOnboardingKey, seen);

  bool getSeenOnboarding() => _prefs.getBool(_seenOnboardingKey) ?? false;

  // Theme
  Future<void> setThemeMode(String mode) =>
      _prefs.setString(_themeModeKey, mode);

  String getThemeMode() => _prefs.getString(_themeModeKey) ?? 'system';

  // Premium
  Future<void> setPremium(bool value) => _prefs.setBool(_premiumKey, value);

  bool isPremium() => _prefs.getBool(_premiumKey) ?? false;

  // History mode
  Future<void> setHistoryModeEnabled(bool enabled) =>
      _prefs.setBool(_historyModeKey, enabled);

  bool isHistoryModeEnabled() => _prefs.getBool(_historyModeKey) ?? false;

  // Auth
  Future<void> setAuthMode(String mode) => _prefs.setString(_authModeKey, mode);

  String getAuthMode() => _prefs.getString(_authModeKey) ?? 'none';

  Future<void> setIsLoggedIn(bool value) =>
      _prefs.setBool(_isLoggedInKey, value);

  bool getIsLoggedIn() => _prefs.getBool(_isLoggedInKey) ?? false;

  // Favorites (stored as JSON array string)
  Future<void> setFavorites(List<String> favorites) =>
      _prefs.setString(_favoritesKey, favorites.join(','));

  List<String> getFavorites() {
    final str = _prefs.getString(_favoritesKey) ?? '';
    return str.isEmpty ? [] : str.split(',');
  }

  // My Kit (stored as JSON array string)
  Future<void> setKit(List<String> kit) =>
      _prefs.setString(_kitKey, kit.join(','));

  List<String> getKit() {
    final str = _prefs.getString(_kitKey) ?? '';
    return str.isEmpty ? [] : str.split(',');
  }

  Future<void> addFavorite(String id) async {
    final favorites = getFavorites();
    if (!favorites.contains(id)) {
      favorites.add(id);
      await setFavorites(favorites);
    }
  }

  Future<void> removeFavorite(String id) async {
    final favorites = getFavorites();
    favorites.remove(id);
    await setFavorites(favorites);
  }

  Future<void> addToKit(String id, {required int maxSize}) async {
    final kit = getKit();
    if (!kit.contains(id) && kit.length < maxSize) {
      kit.add(id);
      await setKit(kit);
    }
  }

  Future<void> removeFromKit(String id) async {
    final kit = getKit();
    kit.remove(id);
    await setKit(kit);
  }

  Future<void> reorderKit(List<String> orderedKit) => setKit(orderedKit);

  bool isFavorite(String id) => getFavorites().contains(id);

  bool isInKit(String id) => getKit().contains(id);
}
