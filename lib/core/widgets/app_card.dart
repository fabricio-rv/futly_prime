import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class AppCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  const AppCard({
    Key? key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? BorderRadius.circular(12);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) {
        if (widget.onTap != null) {
          setState(() => _pressed = true);
        }
      },
      onTapUp: (_) {
        if (widget.onTap != null) {
          setState(() => _pressed = false);
          widget.onTap?.call();
        }
      },
      onTapCancel: () {
        if (widget.onTap != null) {
          setState(() => _pressed = false);
        }
      },
      child: AnimatedOpacity(
        opacity: _pressed ? 0.7 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: isDark ? const Color(0xFF333333) : const Color(0xFFEEEEEE),
              width: 1,
            ),
            color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF5F5F5),
          ),
          child: Padding(
            padding: widget.padding ?? Responsive.cardPadding(context),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
