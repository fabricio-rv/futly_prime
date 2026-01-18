import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_section_header.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../core/widgets/disclaimer_footer.dart';
import '../../../core/widgets/standard_content_card.dart';

class MatchdayHomeScreen extends StatelessWidget {
  const MatchdayHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(
          context,
          'Dia de Jogo',
          showBack: true,
          onBack: () => context.go('/shell'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Fases do jogo',
                subtitle: 'Apoios simples para cada momento',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    StandardContentCard(
                      title: 'Antes do jogo',
                      subtitle: 'Mental, foco e hidratação leve',
                      leadingIcon: Icons.play_circle_outline,
                      onTap: () => context.go('/matchday/antes'),
                    ),
                    const SizedBox(height: 12),
                    StandardContentCard(
                      title: 'Intervalo',
                      subtitle: 'Recuperação rápida e reset mental',
                      leadingIcon: Icons.pause_circle_outline,
                      onTap: () => context.go('/matchday/intervalo'),
                    ),
                    const SizedBox(height: 12),
                    StandardContentCard(
                      title: 'Depois do jogo',
                      subtitle: 'Rotina curta de recuperação',
                      leadingIcon: Icons.stop_circle_outlined,
                      onTap: () => context.go('/matchday/depois'),
                    ),
                  ],
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

class _PhaseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _PhaseCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 32),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right),
      ],
    );
  }
}

class MatchdayPhaseScreen extends StatelessWidget {
  final String phaseId;
  const MatchdayPhaseScreen({Key? key, required this.phaseId})
      : super(key: key);

  static final Map<String, String> _titles = {
    'antes': 'Antes do jogo',
    'intervalo': 'Intervalo',
    'depois': 'Depois do jogo',
  };

  List<Map<String, String>> _blocks(String phase) {
    return [
      {
        'title': 'Mental',
        'body':
            'Alguns jogadores costumam focar em uma ideia simples: presença no próximo lance, sem tentar controlar o jogo inteiro.'
      },
      {
        'title': 'Hidratação',
        'body':
            'Alguns jogadores costumam beber pequenos goles com frequência, evitando exageros de uma vez.'
      },
      {
        'title': 'Alimentação simples',
        'body':
            'Alguns jogadores costumam preferir algo leve e fácil de digerir, sem excesso de gordura ou peso.'
      },
      {
        'title': 'Recuperação',
        'body':
            'Alguns jogadores costumam fazer uma volta à calma curta e deixar o corpo desacelerar pouco a pouco.'
      },
      {
        'title': 'Comportamento pós-jogo',
        'body':
            'Alguns jogadores costumam reconhecer o resultado e, depois, voltar para o que controlam: rotina, descanso e próximos passos.'
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final title = _titles[phaseId] ?? 'Fase do jogo';
    final blocks = _blocks(phaseId);

    return Scaffold(
      appBar: buildAppBar(context, title, showBack: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Sugestões rápidas',
              subtitle: 'Ideias simples sem promessa de resultado',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: blocks.map((block) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: StandardContentCard(
                      title: block['title']!,
                      subtitle: block['body']!,
                      leadingIcon: Icons.bolt_outlined,
                      showChevron: false,
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
      ),
    );
  }
}
