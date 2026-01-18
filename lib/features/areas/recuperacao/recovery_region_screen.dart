import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/accordion.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../core/widgets/disclaimer_footer.dart';
import '../../../core/widgets/safety_exit_line.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/utils/auth_guard.dart';
import '../../../data/models/recovery_region.dart';
import '../../../data/repositories/content_repository.dart';
import '../../../data/repositories/history_repository.dart';
import '../../../data/storage/prefs_store.dart';

class RecoveryRegionScreen extends StatefulWidget {
  final String regionId;
  const RecoveryRegionScreen({Key? key, required this.regionId})
      : super(key: key);

  @override
  State<RecoveryRegionScreen> createState() => _RecoveryRegionScreenState();
}

class _RecoveryRegionScreenState extends State<RecoveryRegionScreen> {
  late Future<RecoveryRegion?> _regionFuture;

  @override
  void initState() {
    super.initState();
    _regionFuture = ContentRepository().getRecoveryRegion(widget.regionId);
  }

  @override
  Widget build(BuildContext context) {
    final prefsStore = context.watch<PrefsStore>();
    final isHistoryEnabled = prefsStore.isHistoryModeEnabled();
    final isPremium = prefsStore.isPremium();
    final maxKit = isPremium ? 12 : 6;

    return Scaffold(
      appBar: buildAppBar(context, 'Região', showBack: true),
      body: FutureBuilder<RecoveryRegion?>(
        future: _regionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final region = snapshot.data;
          if (region == null) {
            return EmptyState(
              title: 'Região não encontrada',
              subtitle: 'Não foi possível carregar o conteúdo desta região.',
              icon: Icons.error_outline,
              actionLabel: 'Voltar',
              actionCallback: () => Navigator.of(context).pop(),
            );
          }

          final accordionItems = region.sections
              .map(
                (section) => AccordionItem(
                  title: section.title,
                  items: section.items,
                ),
              )
              .toList();

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
                        region.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Leituras rápidas sobre o que costuma acontecer com essa região.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SafetyExitLine(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sinais de alerta',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        ...region.redFlags.map(
                          (flag) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text('• $flag'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                AccordionSection(items: accordionItems),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            if (!ensureAccountAccess(context)) return;
                            await prefsStore.addToKit(region.id,
                                maxSize: maxKit);
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Adicionado ao Meu Kit.'),
                              ),
                            );
                          },
                          child: const Text('Adicionar ao Meu Kit'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isHistoryEnabled
                              ? () async {
                                  if (!ensureAccountAccess(context)) return;
                                  await const HistoryRepository().addEntry(
                                    type: 'pain',
                                    regionId: region.id,
                                    intensity: 3,
                                    notes:
                                        'Registro breve para acompanhar tendência.',
                                  );
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Registrado no histórico (opcional).'),
                                    ),
                                  );
                                }
                              : null,
                          child: const Text('Registrar no histórico'),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isHistoryEnabled)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Text(
                      'Histórico local está desativado. Se fizer sentido, dá para ativar em Ajustes.',
                      style: Theme.of(context).textTheme.bodySmall,
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
