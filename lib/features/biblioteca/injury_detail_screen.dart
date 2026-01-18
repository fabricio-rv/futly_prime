import 'package:flutter/material.dart';

class InjuryDetailScreen extends StatelessWidget {
  final String injuryId;
  const InjuryDetailScreen({Key? key, required this.injuryId})
      : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Lesão')),
      body: Center(child: Text('Lesão: $injuryId')));
}
