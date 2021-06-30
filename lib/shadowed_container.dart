import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';

class ShadowedContainer extends AnimatedContainer {
  ShadowedContainer(
      {required ThemeColors themeColors,
      Key? key,
      Alignment? alignment,
      EdgeInsets? padding,
      Duration? duration,
      EdgeInsets? margin,
      BoxConstraints? constraints,
      double? height,
      double? width,
      Color? backgroundColor,
      Color? borderColor,
      Color? shadowColor,
      Color? hoverColor,
      Widget? child,
      bool isShimmer = false,
      bool hover = false})
      : super(
            key: key,
            height: height,
            duration: duration ?? const Duration(milliseconds: 0),
            width: width,
            alignment: alignment,
            padding: padding,
            margin: margin,
            constraints: constraints,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: child,
            decoration: BoxDecoration(
              color: !isShimmer ? backgroundColor ?? themeColors.background : null,
              borderRadius: BorderRadius.circular(Dimens.RADIUS_XXL),
              border: borderColor != null ? Border.all(color: borderColor) : Border.all(color: themeColors.primary),
              boxShadow: [
                if (!isShimmer)
                  BoxShadow(
                    offset: const Offset(0, 8),
                    blurRadius: 20,
                    color: hover ? hoverColor ?? themeColors.primaryLight : shadowColor ?? themeColors.primary,
                    spreadRadius: 2,
                  ),
              ],
            ));
}
