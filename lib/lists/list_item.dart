import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/adaptive_container.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';

class ListItem extends StatefulWidget {
  final Widget title;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets padding;
  final bool isShimmer;
  final double? height;
  final Color? backgroundColor;
  final Color? backgroundSelectedColor;
  final VoidCallback? onTap;
  final bool selectable;
  final bool isSelected;

  const ListItem({
    required this.title,
    this.leading,
    this.trailing,
    this.height,
    this.backgroundColor,
    this.backgroundSelectedColor,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: Dimens.SPACING_L),
    this.isShimmer = false,
    this.selectable = false,
    this.isSelected = false,
  }): assert(isShimmer && !selectable && !isSelected || !isShimmer);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late double _factor;
  var _hover = false;

  @override
  void initState() {
    super.initState();
    _toggleFactor();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: widget.selectable ? _onHover : null,
      onTap: _onTap,
      onTapDown: (_) => _onTapDown(),
      onTapCancel: _onTapCancel,
      child: AdaptiveContainer(
        child: Transform.scale(
          scale: _factor,
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
        ),
      ),
    );
  }

  void _onHover(bool hover) => setState(() => _hover = hover);

  void _onTapCancel() {
    if (!widget.selectable) return;
    setState(() {
      _factor = 1.0;
    });
  }

  void _onTapDown() {
    if (!widget.selectable) return;
    setState(() {
      _factor = 0.9;
    });
  }

  void _onTap() async {
    if (!widget.selectable) {
      widget.onTap?.call();
      return;
    }
    await Future.delayed(Durations.BUTTON_TAP);
    setState(_toggleFactor);
    widget.onTap?.call();
  }

  void _toggleFactor() {
    if (widget.isSelected) {
      _factor = 0.9;
    } else {
      _factor = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant ListItem oldWidget) {
    if (oldWidget.isSelected != widget.isSelected) setState(_toggleFactor);
    super.didUpdateWidget(oldWidget);
  }

  BoxDecoration _getDecoration(BuildContext context) {
    if (widget.isShimmer) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.RADIUS_L),
        border: Border.all(color: ThemeColors.of(context).primaryLight),
      );
    }

    return BoxDecoration(
      borderRadius: BorderRadius.circular(Dimens.RADIUS_L),
      color: widget.isSelected
          ? widget.backgroundSelectedColor ?? ThemeColors.of(context).primary
          : widget.backgroundColor ?? ThemeColors.of(context).primaryLight,
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
