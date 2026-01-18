import 'package:flutter/material.dart';

class RoutineDetailScreen extends StatelessWidget {
  final String routineId;
  const RoutineDetailScreen({Key? key, required this.routineId})
      : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Rotina')),
      body: Center(child: Text('Rotina: $routineId')));
}
