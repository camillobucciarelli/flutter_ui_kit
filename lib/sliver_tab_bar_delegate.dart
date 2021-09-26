import 'package:flutter/material.dart';
import 'theme/core_theme.dart';

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  SliverTabBarDelegate(this.child);

  @override
  double get minExtent => Dimens.persistentHeaderHeight;

  @override
  double get maxExtent => Dimens.persistentHeaderHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) => false;
}
