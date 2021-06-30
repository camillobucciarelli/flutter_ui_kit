import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final Widget child;

  const ShimmerContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ThemeColors.of(context).primary,
      highlightColor: ThemeColors.of(context).primaryLight,
      enabled: true,
      child: child,
    );
  }
}
