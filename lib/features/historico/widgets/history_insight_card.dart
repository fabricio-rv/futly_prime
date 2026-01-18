import 'package:flutter/material.dart';

class HistoryInsightCard extends StatelessWidget {
  final String message;
  const HistoryInsightCard({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) => Card(
      child: Padding(padding: const EdgeInsets.all(16), child: Text(message)));
}
