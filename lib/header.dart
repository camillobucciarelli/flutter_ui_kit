import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';


class Header extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Widget? trailing;
  final EdgeInsets padding;
  final TextStyle? textStyle;

  const Header(
      {required this.title,
      this.titleColor,
      this.trailing,
      this.textStyle,
      this.padding = const EdgeInsets.only(top: Dimens.SPACING_S, bottom: Dimens.SPACING_XL)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: _getTextStyle(context),
            ),
          ),
          const SizedBox(width: Dimens.SPACING_XL),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (textStyle != null) return textStyle?.apply(color: titleColor);
    return Theme.of(context).textTheme.header?.apply(color: titleColor);
  }
}
