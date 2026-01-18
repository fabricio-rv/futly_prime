import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String label;
  final Color? bgColor;
  final Color? textColor;

  const TagChip({
    Key? key,
    required this.label,
    this.bgColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg =
        bgColor ?? (isDark ? const Color(0xFF333333) : const Color(0xFFEEEEEE));
    final text = textColor ?? (isDark ? Colors.white : Colors.black);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: text,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
