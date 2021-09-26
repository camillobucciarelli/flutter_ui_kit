import 'package:flutter/material.dart';
import 'theme/core_theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final Widget child;

  const ShimmerContainer({Key? key, required this.child}) : super(key: key);

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
