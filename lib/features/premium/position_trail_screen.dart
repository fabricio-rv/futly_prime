import 'package:flutter/material.dart';

class PositionTrailScreen extends StatelessWidget {
  final String positionId;
  const PositionTrailScreen({Key? key, required this.positionId})
      : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Posição')),
      body: Center(child: Text('Posição: $positionId')));
}
