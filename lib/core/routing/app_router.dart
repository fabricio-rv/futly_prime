import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../auth/auth_controller.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/signup_screen.dart';
import '../../features/auth/forgot_password_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/areas/area_home_screen.dart';
import '../../features/areas/recuperacao/recovery_home_screen.dart';
import '../../features/areas/recuperacao/recovery_region_screen.dart';
import '../../features/biblioteca/library_screen.dart';
import '../../features/areas/cabeca/mind_home_screen.dart';
import '../../features/areas/dia_de_jogo/matchday_home_screen.dart';
import '../../features/areas/sono/sleep_screen.dart';
import '../../features/areas/alimentacao/nutrition_screen.dart';
import '../../features/rotinas/routines_home_screen.dart';
import '../../features/historico/history_gate_screen.dart';
import '../../features/premium/premium_screen.dart';
import '../../features/sobre/about_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../widgets/bottom_nav_shell.dart';
import 'routes.dart';

class AppRouter {
  final GoRouter router;

  AppRouter(
      {required bool seenOnboarding, required AuthController authController})
      : router = GoRouter(
          refreshListenable: authController,
          initialLocation:
              authController.isLoggedIn ? Routes.shell : Routes.login,
          redirect: (context, state) {
            final loggedIn = authController.isLoggedIn;
            final location = state.matchedLocation;
            final isAuthRoute = location == Routes.login ||
                location == Routes.signup ||
                location == Routes.forgotPassword ||
                location == Routes.onboarding;
            if (!loggedIn && !isAuthRoute) return Routes.login;
            if (loggedIn && isAuthRoute) return Routes.shell;
            return null;
          },
          errorBuilder: (context, state) => Scaffold(
            appBar: AppBar(title: const Text('Página Não Encontrada')),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'Ops! Página não encontrada.',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'O conteúdo que você procura não existe ou foi movido.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.go('/shell'),
                      icon: const Icon(Icons.home),
                      label: const Text('Voltar para Início'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          routes: [
            GoRoute(
              path: Routes.login,
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: Routes.signup,
              builder: (context, state) => const SignupScreen(),
            ),
            GoRoute(
              path: Routes.forgotPassword,
              builder: (context, state) => const ForgotPasswordScreen(),
            ),
            GoRoute(
              path: Routes.onboarding,
              builder: (context, state) => const OnboardingScreen(),
            ),
            ShellRoute(
              builder: (context, state, child) => BottomNavShell(child: child),
              routes: [
                GoRoute(
                  path: Routes.shell,
                  name: 'home',
                  builder: (context, state) => const HomeScreen(),
                  routes: [
                    GoRoute(
                      path: 'area/:areaId',
                      name: 'area',
                      builder: (context, state) {
                        final areaId = state.pathParameters['areaId']!;
                        return AreaHomeScreen(areaId: areaId);
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: Routes.recovery,
                  name: 'recovery',
                  builder: (context, state) => const RecoveryHomeScreen(),
                  routes: [
                    GoRoute(
                      path: 'region/:regionId',
                      name: 'recovery_region',
                      builder: (context, state) {
                        final regionId = state.pathParameters['regionId']!;
                        return RecoveryRegionScreen(regionId: regionId);
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: Routes.library,
                  name: 'library',
                  builder: (context, state) => const LibraryScreen(),
                  routes: [
                    GoRoute(
                      path: 'injury/:injuryId',
                      name: 'injury_detail',
                      builder: (context, state) {
                        final injuryId = state.pathParameters['injuryId']!;
                        return InjuryDetailScreen(injuryId: injuryId);
                      },
                    ),
                    GoRoute(
                      path: 'education/:eduId',
                      name: 'education_detail',
                      builder: (context, state) {
                        final eduId = state.pathParameters['eduId']!;
                        return EducationDetailScreen(eduId: eduId);
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: Routes.mind,
                  name: 'mind',
                  builder: (context, state) => const MindHomeScreen(),
                  routes: [
                    GoRoute(
                      path: 'topic/:topicId',
                      name: 'mind_topic',
                      builder: (context, state) {
                        final topicId = state.pathParameters['topicId']!;
                        return MindTopicScreen(topicId: topicId);
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: Routes.matchday,
                  name: 'matchday',
                  builder: (context, state) => const MatchdayHomeScreen(),
                  routes: [
                    GoRoute(
                      path: ':phaseId',
                      name: 'matchday_phase',
                      builder: (context, state) {
                        final phaseId = state.pathParameters['phaseId']!;
                        return MatchdayPhaseScreen(phaseId: phaseId);
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: Routes.sleep,
                  name: 'sleep',
                  builder: (context, state) => const SleepScreen(),
                ),
                GoRoute(
                  path: Routes.nutrition,
                  name: 'nutrition',
                  builder: (context, state) => const NutritionScreen(),
                ),
                GoRoute(
                  path: Routes.routines,
                  name: 'routines',
                  builder: (context, state) => const RoutinesHomeScreen(),
                  routes: [
                    GoRoute(
                      path: ':routineId',
                      name: 'routine_detail',
                      builder: (context, state) {
                        final routineId = state.pathParameters['routineId']!;
                        return RoutineDetailScreen(routineId: routineId);
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: Routes.history,
                  name: 'history',
                  builder: (context, state) => const HistoryGateScreen(),
                  routes: [
                    GoRoute(
                      path: 'records',
                      name: 'history_records',
                      builder: (context, state) => const HistoryRecordsScreen(),
                    ),
                    GoRoute(
                      path: 'sensitive',
                      name: 'history_sensitive',
                      builder: (context, state) =>
                          const HistorySensitiveRegionsScreen(),
                    ),
                    GoRoute(
                      path: 'past_injuries',
                      name: 'history_past_injuries',
                      builder: (context, state) =>
                          const HistoryPastInjuriesScreen(),
                    ),
                  ],
                ),
                GoRoute(
                  path: Routes.premium,
                  name: 'premium',
                  builder: (context, state) => const PremiumScreen(),
                  routes: [
                    GoRoute(
                      path: 'bodymap',
                      name: 'bodymap',
                      builder: (context, state) => const BodyMapScreen(),
                    ),
                    GoRoute(
                      path: 'positions',
                      name: 'positions',
                      builder: (context, state) => const PositionsHomeScreen(),
                    ),
                    GoRoute(
                      path: 'positions/:positionId',
                      name: 'position_trail',
                      builder: (context, state) {
                        final posId = state.pathParameters['positionId']!;
                        return PositionTrailScreen(positionId: posId);
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: Routes.about,
                  name: 'about',
                  builder: (context, state) => const AboutScreen(),
                ),
                GoRoute(
                  path: Routes.settings,
                  name: 'settings',
                  builder: (context, state) => const SettingsScreen(),
                ),
              ],
            ),
          ],
        );
}
