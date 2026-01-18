import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_section_header.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../core/widgets/disclaimer_footer.dart';
import '../../../core/utils/auth_guard.dart';
import '../../../data/repositories/history_repository.dart';
import '../../../data/storage/prefs_store.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({Key? key}) : super(key: key);

  Future<void> _saveSleep(BuildContext context, String quality) async {
    if (!ensureAccountAccess(context)) return;
    await const HistoryRepository().addEntry(
      type: 'sleep',
      sleepQuality: quality,
      notes: 'Check-in simples de sono.',
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registro de sono salvo.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prefsStore = context.watch<PrefsStore>();
    final historyEnabled = prefsStore.isHistoryModeEnabled();

    return Scaffold(
      appBar: buildAppBar(
        context,
        'Sono',
        showBack: true,
        onBack: () => context.go('/shell'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Por que ajuda',
              subtitle: 'Sono tende a apoiar recuperação e foco',
            ),
            _infoCard(
              context,
              'Muita gente relata que dormir bem melhora decisão, energia e tolerância ao esforço no treino.',
            ),
            const SectionHeader(
              title: 'Rotina pré-sono (ideias simples)',
              subtitle: 'Alguns atletas fazem pequenos ajustes no fim do dia',
            ),
            _infoCard(
              context,
              'Alguns atletas costumam reduzir luz forte, manter horário parecido e priorizar um ritual curto de desaceleração.',
            ),
            const SectionHeader(
              title: 'O que evitar antes de jogo',
              subtitle: 'Sem regras rígidas, só alertas gentis',
            ),
            _infoCard(
              context,
              'Alguns atletas evitam treinos muito pesados tarde da noite e refeições grandes muito perto de dormir.',
            ),
            const SizedBox(height: 8),
            const SectionHeader(
              title: 'Check-in simples',
              subtitle: 'Se fizer sentido, dá para registrar localmente',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: historyEnabled
                  ? Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _saveSleep(context, 'mal'),
                            child: const Text('Dormi mal'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _saveSleep(context, 'ok'),
                            child: const Text('Dormi ok'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _saveSleep(context, 'bem'),
                            child: const Text('Dormi bem'),
                          ),
                        ),
                      ],
                    )
                  : AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Histórico local desativado',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Se fizer sentido, dá para ativar o histórico local e guardar check-ins no aparelho.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () async {
                              await prefsStore.setHistoryModeEnabled(true);
                            },
                            child: const Text('Ativar histórico local'),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            const DisclaimerFooter(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppCard(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
      ),
    );
  }
}
