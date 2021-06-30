import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';

class ExpansionCard extends StatelessWidget {
  final Widget title;
  final Widget? leading;
  final Widget? trailing;
  final List<Widget> expandedContent;
  final bool enable;

  const ExpansionCard({
    Key? key,
    required this.title,
    this.expandedContent = const [],
    this.enable = true,
    this.trailing,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enable,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(Dimens.RADIUS_L), color: ThemeColors.of(context).primaryLight),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: Dimens.SPACING_L, vertical: Dimens.SPACING_S),
            title: title,
            leading: leading,
            trailing: trailing ?? const SizedBox(width: Dimens.ICON_BUTTON_SIZE, height: Dimens.ICON_BUTTON_SIZE),
            initiallyExpanded: false,
            childrenPadding: const EdgeInsets.only(right: Dimens.SPACING_S, left: Dimens.SPACING_S, bottom: Dimens.SPACING_S),
            children: expandedContent,
          ),
        ),
      ),
    );
  }
}
