import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';


class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  SliverTabBarDelegate(this.child);

  @override
  double get minExtent => Dimens.PERSISTENT_HEADER_HEIGHT;

  @override
  double get maxExtent => Dimens.PERSISTENT_HEADER_HEIGHT;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) => false;
}
