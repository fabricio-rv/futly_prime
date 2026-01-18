import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/copy_bank.dart';
import '../../data/storage/prefs_store.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _enableHistory = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 32),
                // App name and tagline
                Text(
                  'Futly Prime',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  CopyBank.onboardingTagline,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.mediumGrey,
                      ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  CopyBank.onboardingSubtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 13,
                        color: AppTheme.mediumGrey,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Disclaimer card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF444444)
                          : const Color(0xFFDDDDDD),
                      width: 1.5,
                    ),
                    color: isDark
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFFAFAFA),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 24,
                        color: AppTheme.accentGrey,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Importante',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        CopyBank.disclaimerText,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              height: 1.5,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // History mode toggle
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF333333)
                          : const Color(0xFFEEEEEE),
                      width: 1,
                    ),
                    color: isDark
                        ? const Color(0xFF1A1A1A)
                        : const Color(0xFFF5F5F5),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _enableHistory,
                        onChanged: (value) {
                          setState(() => _enableHistory = value ?? false);
                        },
                        fillColor: WidgetStateProperty.all(AppTheme.accentGrey),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          CopyBank.historyModeToggleLabel,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Primary button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final prefsStore = PrefsStore(prefs);

                      await prefsStore.setSeenOnboarding(true);
                      await prefsStore.setHistoryModeEnabled(_enableHistory);

                      if (!mounted) return;
                      context.go('/shell');
                    },
                    child: const Text(
                      'Entrar no app',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
