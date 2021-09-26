part of 'core_theme.dart';

class Dimens {
  Dimens._();

  static final blurredFilter = ImageFilter.blur(sigmaX: 7, sigmaY: 7);

  static const iconButtonSize = 48.0;
  static const userAvatarSize = 50.0;
  static const buttonHeight = 56.0;
  static const textFieldHeight = 64.0;
  static const appBarHeight = 80.0;
  static const listItemHeight = 80.0;
  static const persistentHeaderHeight = 85.0;

  static const spacingXXS = 4.0;
  static const spacingXS = 8.0;
  static const spacingS = 12.0;
  static const spacingM = 16.0;
  static const spacingL = 20.0;
  static const spacingXL = 24.0;
  static const spacingXXL = 32.0;

  static const radiusXXS = 4.0;
  static const radiusXS = 8.0;
  static const radiusS = 12.0;
  static const radiusM = 16.0;
  static const radiusL = 20.0;
  static const radiusXL = 24.0;
  static const radiusXXL = 32.0;
}

class Durations {
  Durations._();

  static const animatedSwitcher = Duration(milliseconds: 600);
  static const animatedTap = Duration(milliseconds: 300);
  static const buttonTap = Duration(milliseconds: 100);
}

enum MediaQueryBreakPoints { smallScreen, mediumScreen, largeScreen }
