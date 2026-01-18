import 'package:flutter/material.dart';

class EducationDetailScreen extends StatelessWidget {
  final String eduId;
  const EducationDetailScreen({Key? key, required this.eduId})
      : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Educação')),
      body: Center(child: Text('Educação: $eduId')));
}
