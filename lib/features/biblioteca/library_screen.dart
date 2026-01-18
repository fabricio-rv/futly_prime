import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_section_header.dart';
import '../../core/widgets/app_top_bar.dart';
import '../../core/widgets/disclaimer_footer.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/safety_exit_line.dart';
import '../../core/widgets/standard_content_card.dart';
import '../../core/utils/auth_guard.dart';
import '../../data/models/injury.dart';
import '../../data/models/education_card.dart';
import '../../data/repositories/content_repository.dart';
import '../../data/storage/prefs_store.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late Future<List<Injury>> _injuriesFuture;
  late Future<List<EducationCard>> _educationFuture;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _injuriesFuture = ContentRepository().getInjuries();
    _educationFuture = ContentRepository().getEducationCards();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildAppBar(
          context,
          'Biblioteca',
          showBack: true,
          onBack: () => context.go('/shell'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Lesões comuns'),
              Tab(text: 'Educação do atleta'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildInjuriesTab(context),
            _buildEducationTab(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInjuriesTab(BuildContext context) {
    return FutureBuilder<List<Injury>>(
      future: _injuriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final injuries = snapshot.data ?? [];
        final filtered = injuries
            .where((i) => i.name.toLowerCase().contains(_search))
            .toList();

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Buscar lesão',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) => setState(() {
                    _search = value.toLowerCase();
                  }),
                ),
              ),
              const SectionHeader(
                title: 'Prevenção e contexto',
                subtitle: 'Conteúdos educativos sem diagnóstico',
              ),
              if (filtered.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Nenhuma lesão encontrada.'),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: filtered.map((injury) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: StandardContentCard(
                        title: injury.name,
                        subtitle: injury.whatIs,
                        leadingIcon: Icons.health_and_safety_outlined,
                        onTap: () => context.go('/library/injury/${injury.id}'),
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
    );
  }

  Widget _buildEducationTab(BuildContext context) {
    return FutureBuilder<List<EducationCard>>(
      future: _educationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final cards = snapshot.data ?? [];
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Educação do atleta',
                subtitle: 'Mini-cards para leitura rápida',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: cards.map((card) {
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
              ),
              const SizedBox(height: 16),
              const DisclaimerFooter(),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

class InjuryDetailScreen extends StatelessWidget {
  final String injuryId;
  const InjuryDetailScreen({Key? key, required this.injuryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefsStore = context.watch<PrefsStore>();
    final isPremium = prefsStore.isPremium();
    final maxKit = isPremium ? 12 : 6;

    return Scaffold(
      appBar: buildAppBar(context, 'Lesão', showBack: true),
      body: FutureBuilder<Injury?>(
        future: ContentRepository().getInjury(injuryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final injury = snapshot.data;
          if (injury == null) {
            return EmptyState(
              title: 'Lesão não encontrada',
              subtitle: 'Não foi possível carregar este conteúdo.',
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
                  child: Text(
                    injury.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SafetyExitLine(),
                _section(context, 'O que é', injury.whatIs),
                _section(context, 'Por que acontece', injury.whyHappens),
                _listSection(context, 'Sinais de alerta', injury.redFlags),
                _section(context, 'Cuidados comuns', injury.commonCare),
                _section(context, 'Prevenção', injury.prevention),
                _section(
                    context, 'Retorno progressivo', injury.progressiveReturn),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: OutlinedButton(
                    onPressed: () async {
                      if (!ensureAccountAccess(context)) return;
                      await prefsStore.addToKit(injury.id, maxSize: maxKit);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Adicionado ao Meu Kit.')),
                      );
                    },
                    child: const Text('Adicionar ao Meu Kit'),
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

  Widget _section(BuildContext context, String title, String body) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(body, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _listSection(BuildContext context, String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text('• $item'),
                )),
          ],
        ),
      ),
    );
  }
}

class EducationDetailScreen extends StatelessWidget {
  final String eduId;
  const EducationDetailScreen({Key? key, required this.eduId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefsStore = context.watch<PrefsStore>();
    final isPremium = prefsStore.isPremium();
    final maxKit = isPremium ? 12 : 6;

    return Scaffold(
      appBar: buildAppBar(context, 'Educação', showBack: true),
      body: FutureBuilder<EducationCard?>(
        future: ContentRepository().getEducationCard(eduId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final card = snapshot.data;
          if (card == null) {
            return EmptyState(
              title: 'Card não encontrado',
              subtitle: 'Não foi possível carregar este conteúdo.',
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
                        card.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        card.summary,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppCard(
                    child: Text(
                      card.body,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.5,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: OutlinedButton(
                    onPressed: () async {
                      if (!ensureAccountAccess(context)) return;
                      await prefsStore.addToKit(card.id, maxSize: maxKit);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Adicionado ao Meu Kit.')),
                      );
                    },
                    child: const Text('Adicionar ao Meu Kit'),
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
