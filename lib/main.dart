import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'core/auth/auth_controller.dart';
import 'data/storage/prefs_store.dart';
import 'data/storage/hive_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and SharedPreferences
  await HiveStore.init();
  final prefs = await SharedPreferences.getInstance();
  final prefsStore = PrefsStore(prefs);

  final seenOnboarding = prefsStore.getSeenOnboarding();
  final authController = AuthController(prefsStore);

  runApp(
    FutlyPrimeApp(
      seenOnboarding: seenOnboarding,
      prefsStore: prefsStore,
      authController: authController,
    ),
  );
}
