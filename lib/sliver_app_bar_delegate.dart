import 'package:flutter/material.dart';
import 'theme/core_theme.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double safeAreaTop;

  SliverAppBarDelegate({required this.child, required this.safeAreaTop});

  @override
  double get minExtent => Dimens.appBarHeight + safeAreaTop;

  @override
  double get maxExtent => Dimens.appBarHeight + safeAreaTop;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) => false;
}
