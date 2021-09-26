import 'package:flutter/material.dart';

import '../../../flutter_core_ui_kit.dart';
import '../../../theme/core_theme.dart';

class SelectFormFieldListItem extends StatelessWidget {
  final bool selected;
  final String label;
  final Function onTap;

  const SelectFormFieldListItem({
    Key? key,
    required this.label,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 768;
    return AdaptiveContainer(
      child: Padding(
        padding: EdgeInsets.fromLTRB(Dimens.spacingL, 0, Dimens.spacingL, isWeb ? Dimens.spacingS : Dimens.spacingXS),
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
