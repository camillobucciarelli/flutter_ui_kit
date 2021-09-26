import 'package:flutter/material.dart';

import 'theme/core_theme.dart';

class AdaptiveContainer extends StatelessWidget {
  final Widget child;
  final Alignment? alignment;
  final double widthFactor;

  const AdaptiveContainer({
    required this.child,
    Key? key,
    this.alignment,
    this.widthFactor = 1,
  })  : assert(widthFactor >= 0 && widthFactor <= 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).isA(MediaQueryBreakPoints.largeScreen);
    return Container(
      alignment: alignment ?? (isLargeScreen ? Alignment.center : Alignment.topCenter),
      width: isLargeScreen ? MediaQuery.of(context).size.width * widthFactor : MediaQuery.of(context).size.width,
      child: child,
    );
  }
}
