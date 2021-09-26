import 'package:flutter/material.dart';
import '../theme/core_theme.dart';

import 'list_item.dart';

class ListItemGroup extends StatelessWidget {
  final List<ListItem> items;
  final Color? background;

  const ListItemGroup(this.items, {Key? key, this.background}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.radiusL),
        color: background ?? ThemeColors.of(context).primaryLight,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildList,
      ),
    );
  }

  List<Widget> get _buildList => items
      .asMap()
      .map((key, value) {
        return MapEntry(key, [value, if (key < items.length - 1) const Divider(height: 1, indent: Dimens.spacingL)]);
      })
      .values
      .reduce((a, b) => [...a, ...b])
      .toList();
}
