import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'theme/core_theme.dart';

class Header extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Widget? trailing;
  final EdgeInsets padding;
  final TextStyle? textStyle;

  const Header({
    Key? key,
    required this.title,
    this.titleColor,
    this.trailing,
    this.textStyle,
    this.padding = const EdgeInsets.only(top: Dimens.spacingS, bottom: Dimens.spacingXL),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AutoSizeText(
              title,
              style: textStyle?.apply(color: titleColor) ?? Theme.of(context).textTheme.header?.apply(color: titleColor),
              maxLines: 1,
            ),
          ),
          const SizedBox(width: Dimens.spacingXL),
          if (trailing != null) Flexible(child: trailing!),
        ],
      ),
    );
  }
}
