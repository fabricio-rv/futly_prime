import 'package:flutter/material.dart';

class HistoryPastInjuriesScreen extends StatelessWidget {
  const HistoryPastInjuriesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Lesões Passadas')),
      body: const Center(child: Text('Lesões')));
}
