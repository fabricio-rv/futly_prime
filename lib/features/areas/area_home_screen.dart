import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/app_section_header.dart';
import '../../core/widgets/disclaimer_footer.dart';
import '../../core/widgets/skeleton.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/standard_content_card.dart';
import '../../data/repositories/content_repository.dart';
import '../../data/models/area.dart';
import '../../data/models/routine.dart';
import '../../data/models/education_card.dart';

class AreaHomeScreen extends StatefulWidget {
  final String areaId;

  const AreaHomeScreen({Key? key, required this.areaId}) : super(key: key);

  @override
  State<AreaHomeScreen> createState() => _AreaHomeScreenState();
}

class _AreaHomeScreenState extends State<AreaHomeScreen> {
  late Future<Area?> _areaFuture;
  late Future<List<Routine>> _routinesFuture;
  late Future<List<EducationCard>> _educationFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final repo = ContentRepository();
    _areaFuture = _getArea();
    _routinesFuture = repo.getRoutines();
    _educationFuture = repo.getEducationCards();
  }

  Future<Area?> _getArea() async {
    final areas = await ContentRepository().getAreas();
    try {
      return areas.firstWhere((a) => a.id == widget.areaId);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Area?>(
          future: _areaFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Text(snapshot.data!.title.split(' ').skip(1).join(' '));
            }
            return const Text('Carregando...');
          },
        ),
        elevation: 0,
      ),
      body: FutureBuilder<Area?>(
        future: _areaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return EmptyState(
              title: 'Área não encontrada',
              subtitle: 'O conteúdo que você procura não está disponível.',
              icon: Icons.error_outline,
              actionLabel: 'Voltar para Início',
              actionCallback: () => context.go('/shell'),
            );
          }

          final area = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Intro section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        area.title.split(' ')[0], // Emoji
                        style: const TextStyle(fontSize: 48),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        area.intro,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              height: 1.5,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Quick trails section
                const SectionHeader(
                  title: 'Trilhas Rápidas',
                  subtitle: 'Rotinas estruturadas para você',
                ),
                FutureBuilder<List<Routine>>(
                  future: _routinesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SkeletonList(itemCount: 3, itemHeight: 80),
                      );
                    }

                    final routines = snapshot.data ?? [];
                    // Show first 3 routines
                    final displayRoutines = routines.take(3).toList();

                    if (displayRoutines.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Nenhuma rotina disponível no momento.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: displayRoutines.map((routine) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: StandardContentCard(
                              title: routine.title,
                              subtitle: '${routine.steps.length} passos',
                              leadingIcon: Icons.playlist_play,
                              onTap: () =>
                                  context.go('/routines/${routine.id}'),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Recommended cards section
                const SectionHeader(
                  title: 'Cards Recomendados',
                  subtitle: 'Conteúdo educacional para você',
                ),
                FutureBuilder<List<EducationCard>>(
                  future: _educationFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SkeletonList(itemCount: 4, itemHeight: 100),
                      );
                    }

                    final cards = snapshot.data ?? [];
                    // Show first 6 cards
                    final displayCards = cards.take(6).toList();

                    if (displayCards.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Nenhum card disponível no momento.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: displayCards.map((card) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: StandardContentCard(
                              title: card.title,
                              subtitle: card.summary,
                              leadingIcon: Icons.menu_book_outlined,
                              onTap: () =>
                                  context.go('/library/education/${card.id}'),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Disclaimer footer
                const DisclaimerFooter(includePrivacy: false),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
