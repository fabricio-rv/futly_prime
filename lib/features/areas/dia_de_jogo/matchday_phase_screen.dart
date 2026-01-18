import 'package:flutter/material.dart';

class MatchdayPhaseScreen extends StatelessWidget {
  final String phaseId;
  const MatchdayPhaseScreen({Key? key, required this.phaseId})
      : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Fase')),
      body: Center(child: Text('Fase: $phaseId')));
}
