part of 'core_theme.dart';

class CoreColors {
  static const Color splashColor = Color(0xffffffff);

  static const Color red = Color(0xFF9E2A2B);

  static const Color lightRed = Color(0xFFBE4A4B);

  static const Color orange = Color(0xFFE76F51);

  static const Color lightOrange = Color(0xFFF4A261);

  static const Color green = Color(0xFF06D6A0);

  static const Color lightGreen = Color(0xFFA9E5BB);

  static const Color gray = Color(0xFFE6E6EA);

  static const Color lightGray = Color(0xFFF4F4F8);

  static const Color blue = Color(0xFF073B4C);

  static const Color lightBlue = Color(0xFF118AB2);
}

abstract class ThemeColors {
  static ThemeColors of(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return CoreTheme._themeColorsLight;
    }
    return CoreTheme._themeColorsDark;
  }

  const ThemeColors();

  Color get background;

  Color get textColor;

  Color get textColorLight;

  Color get textColorLighter;

  Color get primary;

  Color get primaryLight;

  Color get primaryLighter;

  Color get accent;

  Color get accentLight;

  Color get accentLighter;
}
