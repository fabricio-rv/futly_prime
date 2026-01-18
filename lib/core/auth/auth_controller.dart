import 'package:flutter/foundation.dart';
import '../../data/storage/prefs_store.dart';

class AuthController extends ChangeNotifier {
  final PrefsStore prefsStore;
  String _authMode = 'none'; // none | guest | user
  bool _isLoggedIn = false;

  AuthController(this.prefsStore) {
    _authMode = prefsStore.getAuthMode();
    _isLoggedIn = prefsStore.getIsLoggedIn();
  }

  String get authMode => _authMode;
  bool get isLoggedIn => _isLoggedIn;
  bool get isGuest => _authMode == 'guest';
  bool get isUser => _authMode == 'user';

  Future<void> loginUser() async {
    _authMode = 'user';
    _isLoggedIn = true;
    await prefsStore.setAuthMode(_authMode);
    await prefsStore.setIsLoggedIn(_isLoggedIn);
    notifyListeners();
  }

  Future<void> loginGuest() async {
    _authMode = 'guest';
    _isLoggedIn = true;
    await prefsStore.setAuthMode(_authMode);
    await prefsStore.setIsLoggedIn(_isLoggedIn);
    notifyListeners();
  }

  Future<void> logout() async {
    _authMode = 'none';
    _isLoggedIn = false;
    await prefsStore.setAuthMode(_authMode);
    await prefsStore.setIsLoggedIn(_isLoggedIn);
    notifyListeners();
  }
}
