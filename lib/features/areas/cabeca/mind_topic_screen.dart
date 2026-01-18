import 'package:flutter/material.dart';

class MindTopicScreen extends StatelessWidget {
  final String topicId;
  const MindTopicScreen({Key? key, required this.topicId}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Tópico')),
      body: Center(child: Text('Tópico: $topicId')));
}
