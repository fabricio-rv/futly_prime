import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_section_header.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../core/widgets/disclaimer_footer.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/standard_content_card.dart';
import '../../../data/models/mental_topic.dart';
import '../../../data/repositories/content_repository.dart';
import 'widgets/breathing_tool.dart' as tools;
import 'widgets/reset_tool.dart';

class MindHomeScreen extends StatefulWidget {
  const MindHomeScreen({Key? key}) : super(key: key);

  @override
  State<MindHomeScreen> createState() => _MindHomeScreenState();
}

class _MindHomeScreenState extends State<MindHomeScreen> {
  late Future<List<MentalTopic>> _topicsFuture;

  @override
  void initState() {
    super.initState();
    _topicsFuture = ContentRepository().getMentalTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        'Cabeça',
        showBack: true,
        onBack: () => context.go('/shell'),
      ),
      body: FutureBuilder<List<MentalTopic>>(
        future: _topicsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final topics = snapshot.data ?? [];
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: 'Tópicos mentais',
                  subtitle:
                      'Apoios rápidos para lidar com pressão, foco e emoções',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: topics.map((topic) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: StandardContentCard(
                          title: topic.title,
                          subtitle: topic.intro,
                          leadingIcon: Icons.psychology_outlined,
                          onTap: () => context.go('/mind/topic/${topic.id}'),
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

class MindTopicScreen extends StatefulWidget {
  final String topicId;
  const MindTopicScreen({Key? key, required this.topicId}) : super(key: key);

  @override
  State<MindTopicScreen> createState() => _MindTopicScreenState();
}

class _MindTopicScreenState extends State<MindTopicScreen> {
  late Future<MentalTopic?> _topicFuture;

  @override
  void initState() {
    super.initState();
    _topicFuture = ContentRepository().getMentalTopic(widget.topicId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Tópico', showBack: true),
      body: FutureBuilder<MentalTopic?>(
        future: _topicFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final topic = snapshot.data;
          if (topic == null) {
            return EmptyState(
              title: 'Tópico não encontrado',
              subtitle: 'Não foi possível carregar este conteúdo.',
              icon: Icons.error_outline,
              actionLabel: 'Voltar',
              actionCallback: () => Navigator.of(context).pop(),
            );
          }

          final tool = topic.tool;
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
                        topic.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        topic.intro,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              height: 1.5,
                            ),
                      ),
                    ],
                  ),
                ),
                const SectionHeader(
                  title: 'Lembretes práticos',
                  subtitle: 'Algumas ideias que podem ajudar a recentrar',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: topic.reminders
                        .take(4)
                        .map(
                          (r) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text('• $r'),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),
                if (tool != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tool.type == 'breathing'
                                ? 'Respiração guiada'
                                : 'Reset mental',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sessão curta de ${tool.durationSeconds}s. Se fizer sentido, experimente sem pressa.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 12),
                          tool.type == 'breathing'
                              ? tools.BreathingTool(
                                  durationSeconds: tool.durationSeconds,
                                  steps: tool.scriptSteps,
                                )
                              : ResetTool(steps: tool.scriptSteps),
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
