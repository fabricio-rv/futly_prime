import 'package:flutter/material.dart';

class Responsive {
  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static bool isSmallPhone(BuildContext context) => width(context) <= 360;
  static bool isPhone(BuildContext context) => width(context) <= 480;
  static bool isLargePhone(BuildContext context) => width(context) >= 480;

  static double horizontalPadding(BuildContext context) {
    if (isSmallPhone(context)) return 12;
    if (isLargePhone(context)) return 20;
    return 16;
  }

  static double cardSpacing(BuildContext context) {
    if (isSmallPhone(context)) return 8;
    if (isLargePhone(context)) return 16;
    return 12;
  }

  static double sectionSpacing(BuildContext context) {
    if (isSmallPhone(context)) return 12;
    if (isLargePhone(context)) return 20;
    return 16;
  }

  static double cardMinHeight(BuildContext context) {
    if (isSmallPhone(context)) return 80;
    if (isLargePhone(context)) return 96;
    return 88;
  }

  static EdgeInsets cardPadding(BuildContext context) {
    if (isSmallPhone(context)) return const EdgeInsets.all(12);
    if (isLargePhone(context)) return const EdgeInsets.all(18);
    return const EdgeInsets.all(16);
  }

  static double iconBoxSize(BuildContext context) {
    if (isSmallPhone(context)) return 40;
    return 44;
  }

  static double iconSize(BuildContext context) {
    if (isSmallPhone(context)) return 20;
    return 22;
  }

  static int gridCrossAxisCount(BuildContext context) {
    return isLargePhone(context) ? 3 : 2;
  }

  static double gridChildAspectRatio(BuildContext context) {
    if (isSmallPhone(context)) return 1.1;
    return 1.2;
  }

  static TextStyle? scaleTextStyle(
    BuildContext context,
    TextStyle? style, {
    double smallScale = 0.94,
  }) {
    if (style == null) return null;
    if (!isSmallPhone(context)) return style;
    final size = style.fontSize;
    if (size == null) return style;
    return style.copyWith(fontSize: size * smallScale);
  }
}
