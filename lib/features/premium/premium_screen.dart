import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_section_header.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/disclaimer_footer.dart';
import '../../core/utils/auth_guard.dart';
import '../../data/models/education_card.dart';
import '../../data/models/injury.dart';
import '../../data/models/routine.dart';
import '../../data/models/recovery_region.dart';
import '../../data/repositories/content_repository.dart';
import '../../data/storage/prefs_store.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  late Future<List<EducationCard>> _educationFuture;
  late Future<List<Routine>> _routinesFuture;
  late Future<List<Injury>> _injuriesFuture;
  late Future<List<RecoveryRegion>> _regionsFuture;

  @override
  void initState() {
    super.initState();
    final repo = ContentRepository();
    _educationFuture = repo.getEducationCards();
    _routinesFuture = repo.getRoutines();
    _injuriesFuture = repo.getInjuries();
    _regionsFuture = repo.getRecoveryRegions();
  }

  @override
  Widget build(BuildContext context) {
    final prefsStore = context.watch<PrefsStore>();
    final isPremium = prefsStore.isPremium();
    final maxKit = isPremium ? 12 : 6;
    final kit = prefsStore.getKit();

    return Scaffold(
      appBar: buildAppBar(
        context,
        'Meu Kit',
        showBack: true,
        onBack: () => context.go('/shell'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Meu Kit',
              subtitle: isPremium
                  ? 'Até 12 itens organizados por você'
                  : 'Até 6 itens no modo gratuito',
            ),
            if (kit.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Meu Kit',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Nada adicionado ainda. Você pode salvar rotinas, cards e conteúdos na Biblioteca.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            if (kit.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppCard(
                  child: ReorderableListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    onReorder: (oldIndex, newIndex) async {
                      if (!ensureAccountAccess(context)) return;
                      if (newIndex > oldIndex) newIndex -= 1;
                      final ordered = List<String>.from(kit);
                      final item = ordered.removeAt(oldIndex);
                      ordered.insert(newIndex, item);
                      await prefsStore.reorderKit(ordered);
                      setState(() {});
                    },
                    children: [
                      for (final itemId in kit)
                        ListTile(
                          key: ValueKey(itemId),
                          title: Text(_resolveTitle(itemId)),
                          subtitle: Text(itemId),
                          trailing: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () async {
                              if (!ensureAccountAccess(context)) return;
                              await prefsStore.removeFromKit(itemId);
                              setState(() {});
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),
            const SectionHeader(
              title: 'Sugestões para adicionar',
              subtitle: 'Algumas ideias rápidas para iniciar seu Kit',
            ),
            FutureBuilder(
              future: Future.wait([
                _educationFuture,
                _routinesFuture,
                _injuriesFuture,
                _regionsFuture,
              ]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  );
                }
                final edu = snapshot.data![0] as List<EducationCard>;
                final routines = snapshot.data![1] as List<Routine>;
                final injuries = snapshot.data![2] as List<Injury>;
                final regions = snapshot.data![3] as List<RecoveryRegion>;

                final suggestions = [
                  ...edu.take(2).map((e) => _SuggestionItem(
                      id: e.id,
                      title: e.title,
                      route: '/library/education/${e.id}')),
                  ...routines.take(2).map((r) => _SuggestionItem(
                      id: r.id, title: r.title, route: '/routines/${r.id}')),
                  ...injuries.take(1).map((i) => _SuggestionItem(
                      id: i.id,
                      title: i.name,
                      route: '/library/injury/${i.id}')),
                  ...regions.take(1).map((r) => _SuggestionItem(
                      id: r.id,
                      title: r.name,
                      route: '/recovery/region/${r.id}')),
                ];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: suggestions.map((s) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AppCard(
                          onTap: () => context.go(s.route),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  s.title,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () async {
                                  if (!ensureAccountAccess(context)) return;
                                  await prefsStore.addToKit(s.id,
                                      maxSize: maxKit);
                                  if (!mounted) return;
                                  setState(() {});
                                },
                                child: const Text('Adicionar'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            const DisclaimerFooter(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _resolveTitle(String id) {
    if (id.startsWith('edu_')) return 'Card educativo';
    if (id.startsWith('routine_')) return 'Rotina';
    if (id.startsWith('inj_')) return 'Lesão';
    if (id.startsWith('region_')) return 'Região';
    if (id.startsWith('mind_')) return 'Tópico mental';
    return 'Conteúdo';
  }
}

class _SuggestionItem {
  final String id;
  final String title;
  final String route;

  _SuggestionItem({required this.id, required this.title, required this.route});
}

class BodyMapScreen extends StatelessWidget {
  const BodyMapScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Mapa do Corpo')),
      body: const Center(child: Text('Body Map')));
}

class PositionsHomeScreen extends StatelessWidget {
  const PositionsHomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Posições')),
      body: const Center(child: Text('Posições')));
}

class PositionTrailScreen extends StatelessWidget {
  final String positionId;
  const PositionTrailScreen({Key? key, required this.positionId})
      : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Posição')),
      body: Center(child: Text('Posição: $positionId')));
}
