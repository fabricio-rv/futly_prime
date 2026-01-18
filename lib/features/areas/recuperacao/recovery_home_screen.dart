import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_section_header.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../core/widgets/disclaimer_footer.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/standard_content_card.dart';
import '../../../data/models/recovery_region.dart';
import '../../../data/repositories/content_repository.dart';

class RecoveryHomeScreen extends StatefulWidget {
  const RecoveryHomeScreen({Key? key}) : super(key: key);

  @override
  State<RecoveryHomeScreen> createState() => _RecoveryHomeScreenState();
}

class _RecoveryHomeScreenState extends State<RecoveryHomeScreen> {
  late Future<List<RecoveryRegion>> _regionsFuture;

  @override
  void initState() {
    super.initState();
    _regionsFuture = ContentRepository().getRecoveryRegions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        'Recuperação',
        showBack: true,
        onBack: () => context.go('/shell'),
      ),
      body: FutureBuilder<List<RecoveryRegion>>(
        future: _regionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: SkeletonList(itemCount: 5, itemHeight: 86),
            );
          }

          final regions = snapshot.data ?? [];
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: 'Regiões em foco',
                  subtitle:
                      'Orientações gerais com linguagem segura e sem promessas',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: regions.map((region) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: StandardContentCard(
                          title: region.name,
                          subtitle:
                              'Toque para ver detalhes e sinais de alerta',
                          leadingIcon: Icons.healing_outlined,
                          onTap: () =>
                              context.go('/recovery/region/${region.id}'),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                const SectionHeader(
                  title: 'Prevenção de Lesões',
                  subtitle: 'Conteúdo educacional completo',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppCard(
                    onTap: () => context.go('/library'),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.library_books,
                          size: 32,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Abrir Biblioteca',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Lesões comuns e educação do atleta',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
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
