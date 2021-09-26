import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'theme/core_theme.dart';

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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimens.radiusL), color: ThemeColors.of(context).primaryLight),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: Dimens.spacingL, vertical: Dimens.spacingS),
            title: title,
            leading: leading,
            trailing: trailing ?? const SizedBox(width: Dimens.iconButtonSize, height: Dimens.iconButtonSize),
            initiallyExpanded: false,
            childrenPadding: const EdgeInsets.only(right: Dimens.spacingS, left: Dimens.spacingS, bottom: Dimens.spacingS),
            children: expandedContent,
          ),
        ),
      ),
    );
  }
}
