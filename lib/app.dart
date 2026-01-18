import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/auth/auth_controller.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'data/storage/prefs_store.dart';

class FutlyPrimeApp extends StatelessWidget {
  final bool seenOnboarding;
  final PrefsStore prefsStore;
  final AuthController authController;

  const FutlyPrimeApp({
    Key? key,
    required this.seenOnboarding,
    required this.prefsStore,
    required this.authController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(
      seenOnboarding: seenOnboarding,
      authController: authController,
    ).router;

    return MultiProvider(
      providers: [
        Provider<PrefsStore>.value(value: prefsStore),
        ChangeNotifierProvider.value(value: authController),
        ChangeNotifierProvider(create: (_) => ThemeController(prefsStore)),
      ],
      child: Consumer<ThemeController>(
        builder: (context, themeController, _) {
          return MaterialApp.router(
            title: 'Futly Prime',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeController.getThemeMode(context),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
