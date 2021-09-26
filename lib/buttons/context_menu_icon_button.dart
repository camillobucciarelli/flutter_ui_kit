import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class ContextMenuButton<T> extends StatelessWidget {
  final List<ContextMenuButtonAction<T>> actions;
  final IconData icon;
  final ItemSelected<T?>? onSelected;
  final AdaptiveStyle adaptiveStyle;

  const ContextMenuButton({
    required this.actions,
    required this.icon,
    Key? key,
    this.onSelected,
    this.adaptiveStyle = AdaptiveStyle.adaptive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android || Theme.of(context).platform == TargetPlatform.iOS) {
      return Button.icon(
        icon: icon,
        onPressed: () => _onButtonTapped(context),
      );
    } else {
      return PopupMenuButton<T>(
        itemBuilder: (BuildContext context) {
          return actions
              .map((cma) => PopupMenuItem(
                    value: cma.key,
                    child: Text(cma.label),
                  ))
              .toList();
        },
        onSelected: onSelected,
        child: IgnorePointer(
          ignoring: true,
          child: Button.icon(icon: icon, onPressed: () {}),
        ),
      );
    }
  }

  void _onButtonTapped(BuildContext context) async {
    final result = await showModalActionSheet<T>(
      context: context,
      actions: actions
          .map((cma) => SheetAction<T>(
                key: cma.key,
                label: cma.label,
              ))
          .toList(),
      style: adaptiveStyle,
    );
    onSelected?.call(result);
  }
}

class ContextMenuButtonAction<T> {
  final T key;
  final String label;

  ContextMenuButtonAction({required this.key, required this.label});
}

typedef ItemSelected<T> = void Function(T value);
