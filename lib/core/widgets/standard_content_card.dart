import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import 'app_card.dart';

class StandardContentCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final bool showChevron;
  final VoidCallback? onTap;
  final double minHeight;

  const StandardContentCard({
    Key? key,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.showChevron = true,
    this.onTap,
    this.minHeight = 88,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconBox = Responsive.iconBoxSize(context);
    final iconSize = Responsive.iconSize(context);
    final titleStyle = Responsive.scaleTextStyle(
      context,
      Theme.of(context).textTheme.titleMedium,
    );
    final subtitleStyle = Responsive.scaleTextStyle(
      context,
      Theme.of(context).textTheme.bodySmall,
      smallScale: 0.96,
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight:
            minHeight == 88 ? Responsive.cardMinHeight(context) : minHeight,
      ),
      child: AppCard(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leadingIcon != null)
              Container(
                width: iconBox,
                height: iconBox,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF333333)
                      : const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(leadingIcon, size: iconSize),
              ),
            if (leadingIcon != null) const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: titleStyle,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: subtitleStyle,
                    ),
                  ],
                ],
              ),
            ),
            if (showChevron) const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
