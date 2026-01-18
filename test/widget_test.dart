import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:futly_prime/app.dart';
import 'package:futly_prime/core/auth/auth_controller.dart';
import 'package:futly_prime/data/storage/prefs_store.dart';

void main() {
  testWidgets('App should load login on first launch',
      (WidgetTester tester) async {
    // Setup SharedPreferences mock
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final prefsStore = PrefsStore(prefs);
    final authController = AuthController(prefsStore);

    // Build app
    await tester.pumpWidget(
      FutlyPrimeApp(
        seenOnboarding: false,
        prefsStore: prefsStore,
        authController: authController,
      ),
    );

    // Verify login screen is displayed
    expect(find.text('Futly Prime'), findsOneWidget);
    expect(find.text('Entrar'), findsWidgets);
  });

  testWidgets('App should load home screen after login',
      (WidgetTester tester) async {
    // Setup SharedPreferences with onboarding completed
    SharedPreferences.setMockInitialValues({
      'seenOnboarding': true,
      'authMode': 'user',
      'isLoggedIn': true,
    });
    final prefs = await SharedPreferences.getInstance();
    final prefsStore = PrefsStore(prefs);
    final authController = AuthController(prefsStore);

    // Build app
    await tester.pumpWidget(
      FutlyPrimeApp(
        seenOnboarding: true,
        prefsStore: prefsStore,
        authController: authController,
      ),
    );
    await tester.pumpAndSettle();

    // Verify home screen is displayed
    expect(find.text('Futly Prime'), findsOneWidget);
    expect(find.text('Áreas de apoio'), findsOneWidget);
  });
}
