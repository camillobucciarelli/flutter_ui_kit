import 'package:flutter/cupertino.dart';
import '../theme/core_theme.dart';

class IndicatorItem extends StatelessWidget {
  final double height;
  final double? width;
  final Duration animationDuration;
  final bool active;

  const IndicatorItem({
    Key? key,
    this.height = Dimens.spacingXS,
    this.width,
    this.animationDuration = Durations.buttonTap,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeInOutQuad,
      duration: animationDuration,
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: active ? ThemeColors.of(context).primary : ThemeColors.of(context).primaryLight,
          borderRadius: BorderRadius.circular(Dimens.radiusS)),
    );
  }
}
