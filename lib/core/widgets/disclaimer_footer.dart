import 'package:flutter/material.dart';
import '../utils/copy_bank.dart';
import '../utils/responsive.dart';

class DisclaimerFooter extends StatelessWidget {
  final bool includePrivacy;

  const DisclaimerFooter({Key? key, this.includePrivacy = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white70 : Colors.black54;
    final baseStyle = Responsive.scaleTextStyle(
      context,
      Theme.of(context).textTheme.bodySmall,
      smallScale: 0.96,
    );
    final textStyle = (baseStyle ?? const TextStyle(fontSize: 12)).copyWith(
      color: textColor,
      height: 1.5,
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
        vertical: Responsive.sectionSpacing(context) / 1.5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CopyBank.disclaimerText,
            style: textStyle,
          ),
          if (includePrivacy) ...[
            const SizedBox(height: 12),
            Text(
              CopyBank.privacyText,
              style: textStyle,
            ),
          ],
        ],
      ),
    );
  }
}
