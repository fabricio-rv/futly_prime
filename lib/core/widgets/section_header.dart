import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.horizontalPadding(context);
    final titleStyle = Responsive.scaleTextStyle(
      context,
      Theme.of(context).textTheme.headlineSmall,
    );
    final subtitleStyle = Responsive.scaleTextStyle(
      context,
      Theme.of(context).textTheme.bodySmall,
      smallScale: 0.96,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: Responsive.sectionSpacing(context) / 1.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              maxLines: Responsive.isSmallPhone(context) ? 3 : 4,
              overflow: TextOverflow.ellipsis,
              style: subtitleStyle,
            ),
          ],
        ],
      ),
    );
  }
}
