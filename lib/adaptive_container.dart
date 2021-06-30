import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';

class AdaptiveContainer extends StatelessWidget {
  final Widget child;
  final Alignment? alignment;
  final double widthFactor;

  const AdaptiveContainer({
    required this.child,
    this.alignment,
    this.widthFactor = 1,
  }) : assert(widthFactor >= 0 && widthFactor <= 1);

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).isA(MediaQueryBreakPoints.LARGE_SCREEN);
    return Container(
      alignment: alignment ?? (isLargeScreen ? Alignment.center : Alignment.topCenter),
      width: isLargeScreen ? MediaQuery.of(context).size.width * widthFactor : MediaQuery.of(context).size.width,
      child: child,
    );
  }
}
