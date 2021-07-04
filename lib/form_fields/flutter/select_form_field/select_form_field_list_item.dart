import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/flutter_core_ui_kit.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';


class SelectFormFieldListItem extends StatelessWidget {
  final bool selected;
  final String label;
  final Function onTap;

  const SelectFormFieldListItem({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 768;
    return AdaptiveContainer(
      child: Padding(
        padding: EdgeInsets.fromLTRB(Dimens.SPACING_L, 0, Dimens.SPACING_L, isWeb ? Dimens.SPACING_S : Dimens.SPACING_XS),
        child: Transform.scale(
          scale: selected ? .97 : 1,
          child: ListItem(
            backgroundColor: selected ? ThemeColors.of(context).primary : null,
            onTap: () => onTap.call(),
            title: Text(label),
            trailing: selected ? const Icon(Icons.check) : null,
          ),
        ),
      ),
    );
  }
}
