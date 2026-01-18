import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/app_card.dart';
import '../../../data/storage/prefs_store.dart';

class MyKitPreview extends StatelessWidget {
  const MyKitPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefsStore = context.watch<PrefsStore>();
    final kit = prefsStore.getKit();

    if (kit.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AppCard(
          onTap: () => context.go('/premium'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meu Kit',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Nada adicionado ainda. Visite a biblioteca e salve seus favoritos.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Meu Kit',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Seus favoritos acessíveis',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppCard(
            child: Column(
              children: [
                Text(
                  '${kit.length} item${kit.length > 1 ? 's' : ''} salvo${kit.length > 1 ? 's' : ''}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.go('/premium'),
                    child: const Text('Gerenciar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
