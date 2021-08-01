import 'package:flutter/cupertino.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';

class IndicatorItem extends StatelessWidget {
  final double indicatorHeight;
  final Duration animationDuration;
  final bool active;

  const IndicatorItem({this.indicatorHeight = Dimens.SPACING_XS, this.animationDuration = Durations.BUTTON_TAP, this.active = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeInOutQuad,
      duration: animationDuration,
      height: indicatorHeight,
      decoration: BoxDecoration(
          color: active ? ThemeColors.of(context).primary : ThemeColors.of(context).primaryLight,
          borderRadius: BorderRadius.circular(Dimens.RADIUS_S)),
    );
  }
}
