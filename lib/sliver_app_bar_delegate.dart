import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';


class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double safeAreaTop;

  SliverAppBarDelegate({required this.child, required this.safeAreaTop});

  @override
  double get minExtent => Dimens.APP_BAR_HEIGHT + safeAreaTop;

  @override
  double get maxExtent => Dimens.APP_BAR_HEIGHT + safeAreaTop;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) => false;
}
