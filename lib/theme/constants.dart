part of 'core_theme.dart';

class Dimens {
  Dimens._();

  static final blurredFilter = ImageFilter.blur(sigmaX: 7, sigmaY: 7);

  static const ICON_BUTTON_SIZE = 48.0;
  static const USER_AVATAR = 50.0;
  static const BUTTON_HEIGHT = 56.0;
  static const TEXT_FIELD_HEIGHT = 64.0;
  static const APP_BAR_HEIGHT = 80.0;
  static const LIST_ITEM_HEIGHT = 80.0;
  static const PERSISTENT_HEADER_HEIGHT = 85.0;

  static const SPACING_XXS = 4.0;
  static const SPACING_XS = 8.0;
  static const SPACING_S = 12.0;
  static const SPACING_M = 16.0;
  static const SPACING_L = 20.0;
  static const SPACING_XL = 24.0;
  static const SPACING_XXL = 32.0;

  static const RADIUS_XXS = 4.0;
  static const RADIUS_XS = 8.0;
  static const RADIUS_S = 12.0;
  static const RADIUS_M = 16.0;
  static const RADIUS_L = 20.0;
  static const RADIUS_XL = 24.0;
  static const RADIUS_XXL = 32.0;
}

class Durations {
  Durations._();

  static const ANIMATED_SWITCHER = Duration(milliseconds: 600);
  static const ANIMATED_TAP = Duration(milliseconds: 300);
  static const BUTTON_TAP = Duration(milliseconds: 100);
}

enum MediaQueryBreakPoints { SMALL_SCREEN, MEDIUM_SCREEN, LARGE_SCREEN }
