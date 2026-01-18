import 'package:flutter/material.dart';

class ResetTool extends StatelessWidget {
  final List<String> steps;

  const ResetTool({Key? key, required this.steps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...steps.map(
          (step) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text('• $step'),
          ),
        ),
      ],
    );
  }
}
