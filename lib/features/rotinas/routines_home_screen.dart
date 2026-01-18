import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/app_section_header.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/disclaimer_footer.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/standard_content_card.dart';
import '../../core/utils/auth_guard.dart';
import '../../data/models/routine.dart';
import '../../data/repositories/content_repository.dart';
import '../../data/storage/prefs_store.dart';

class RoutinesHomeScreen extends StatefulWidget {
  const RoutinesHomeScreen({Key? key}) : super(key: key);

  @override
  State<RoutinesHomeScreen> createState() => _RoutinesHomeScreenState();
}

class _RoutinesHomeScreenState extends State<RoutinesHomeScreen> {
  late Future<List<Routine>> _routinesFuture;

  @override
  void initState() {
    super.initState();
    _routinesFuture = ContentRepository().getRoutines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Rotinas', showBack: false),
      body: FutureBuilder<List<Routine>>(
        future: _routinesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final routines = snapshot.data ?? [];
          if (routines.isEmpty) {
            return EmptyState(
              title: 'Nenhuma rotina disponível',
              subtitle: 'Não encontramos rotinas no momento.',
              icon: Icons.playlist_play,
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: 'Rotinas estruturadas',
                  subtitle: 'Passos curtos para diferentes momentos da semana',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: routines.map((routine) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: StandardContentCard(
                          title: routine.title,
                          subtitle:
                              '${routine.description} • ${routine.steps.length} passos',
                          leadingIcon: Icons.playlist_play,
                          onTap: () => context.go('/routines/${routine.id}'),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                const DisclaimerFooter(),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RoutineDetailScreen extends StatefulWidget {
  final String routineId;
  const RoutineDetailScreen({Key? key, required this.routineId})
      : super(key: key);

  @override
  State<RoutineDetailScreen> createState() => _RoutineDetailScreenState();
}

class _RoutineDetailScreenState extends State<RoutineDetailScreen> {
  late Future<Routine?> _routineFuture;
  final Set<String> _checked = {};

  @override
  void initState() {
    super.initState();
    _routineFuture = ContentRepository().getRoutine(widget.routineId);
  }

  @override
  Widget build(BuildContext context) {
    final prefsStore = context.watch<PrefsStore>();
    final isPremium = prefsStore.isPremium();
    final maxKit = isPremium ? 12 : 6;

    return Scaffold(
      appBar: buildAppBar(context, 'Rotina', showBack: true),
      body: FutureBuilder<Routine?>(
        future: _routineFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final routine = snapshot.data;
          if (routine == null) {
            return EmptyState(
              title: 'Rotina não encontrada',
              subtitle: 'Não foi possível carregar esta rotina.',
              icon: Icons.error_outline,
              actionLabel: 'Voltar',
              actionCallback: () => Navigator.of(context).pop(),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        routine.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        routine.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SectionHeader(
                  title: 'Checklist de passos',
                  subtitle: 'Marque o que fizer sentido hoje',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: routine.steps.map((step) {
                      final checked = _checked.contains(step.id);
                      return CheckboxListTile(
                        value: checked,
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              _checked.add(step.id);
                            } else {
                              _checked.remove(step.id);
                            }
                          });
                        },
                        title: Text(step.title),
                        subtitle: Text(step.body),
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            if (!ensureAccountAccess(context)) return;
                            await prefsStore.addToKit(routine.id,
                                maxSize: maxKit);
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Adicionado ao Meu Kit.')),
                            );
                          },
                          child: const Text('Salvar no Meu Kit'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _checked.isEmpty
                              ? null
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Rotina marcada como feita.'),
                                    ),
                                  );
                                },
                          child: const Text('Concluir'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const DisclaimerFooter(),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
