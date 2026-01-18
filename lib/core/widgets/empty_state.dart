import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? actionCallback;
  final String? actionLabel;

  const EmptyState({
    Key? key,
    required this.title,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.actionCallback,
    this.actionLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
            if (actionCallback != null && actionLabel != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: actionCallback,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
