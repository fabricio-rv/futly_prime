import 'package:flutter/material.dart';

class HistorySensitiveRegionsScreen extends StatelessWidget {
  const HistorySensitiveRegionsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Regiões Sensíveis')),
      body: const Center(child: Text('Regiões')));
}
