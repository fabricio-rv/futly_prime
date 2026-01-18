import 'package:flutter/material.dart';
import '../utils/responsive.dart';

PreferredSizeWidget buildAppBar(
  BuildContext context,
  String title, {
  bool showBack = true,
  PreferredSizeWidget? bottom,
  List<Widget>? actions,
  VoidCallback? onBack,
}) {
  return AppBar(
    title: Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Responsive.scaleTextStyle(
        context,
        Theme.of(context).appBarTheme.titleTextStyle,
      ),
    ),
    automaticallyImplyLeading: showBack && onBack == null,
    leading: showBack && onBack != null ? BackButton(onPressed: onBack) : null,
    bottom: bottom,
    actions: actions,
  );
}
