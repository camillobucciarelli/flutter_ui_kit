import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';

class ListItem extends StatefulWidget {
  final Widget title;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets padding;
  final bool? isShimmer;
  final double? height;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const ListItem(
      {required this.title,
      this.leading,
      this.trailing,
      this.isShimmer,
      this.height,
      this.backgroundColor,
      this.onTap,
      this.padding = const EdgeInsets.symmetric(horizontal: Dimens.SPACING_L)});

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  var _hover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: _onHover,
      onTap: widget.onTap?.call,
      child: AnimatedContainer(
        duration: Durations.ANIMATED_TAP,
        padding: widget.padding,
        height: widget.height ?? Dimens.LIST_ITEM_HEIGHT,
        alignment: Alignment.centerLeft,
        decoration: _getDecoration(context),
        child: Row(
          children: [
            if (widget.leading != null) ...[widget.leading!, const SizedBox(width: Dimens.SPACING_S)],
            Expanded(child: widget.title),
            if (widget.trailing != null) ...[
              const SizedBox(width: Dimens.SPACING_L),
              widget.trailing!,
            ],
          ],
        ),
      ),
    );
  }

  void _onHover(bool hover) => setState(() => _hover = hover);

  BoxDecoration _getDecoration(BuildContext context) {
    if (widget.isShimmer ?? false) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.RADIUS_L),
        border: Border.all(color: ThemeColors.of(context).primaryLight),
      );
    }

    return BoxDecoration(
      borderRadius: BorderRadius.circular(Dimens.RADIUS_L),
      color: widget.backgroundColor ?? ThemeColors.of(context).primaryLight,
      boxShadow: [
        if (_hover)
          BoxShadow(
            offset: const Offset(0, 5),
            blurRadius: 10,
            color: ThemeColors.of(context).primaryLight,
            spreadRadius: 2,
          ),
      ],
    );
  }
}
