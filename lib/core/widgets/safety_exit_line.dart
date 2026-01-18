import 'package:flutter/material.dart';
import '../utils/copy_bank.dart';

class SafetyExitLine extends StatelessWidget {
  const SafetyExitLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? const Color(0xFF444444) : const Color(0xFFDDDDDD),
          width: 1,
        ),
        color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFFAFAFA),
      ),
      child: Text(
        CopyBank.safetyExitText,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12,
              height: 1.4,
              fontStyle: FontStyle.italic,
            ),
      ),
    );
  }
}
