part of 'core_theme.dart';

class CoreColors {
  static const Color splashColor = Color(0xffffffff);

  static const Color red = Color(0xFF9E2A2B);

  static const Color lightRed = Color(0xFFBE4A4B);

  static const Color orange = Color(0xFFE76F51);

  static const Color lightOrange = Color(0xFFF4A261);

  static const Color green = Color(0xFF06D6A0);

  static const Color lightGreen = Color(0xFFA9E5BB);

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

class ThemeColorsLight extends ThemeColors {
  static const _instance = ThemeColorsLight._internal();

  static ThemeColorsLight get instance => _instance;

  const ThemeColorsLight._internal();

  @override
  Color get background => const Color(0xFFFFFFFF);

  @override
  Color get textColor => const Color(0xFF232323);

  @override
  Color get textColorLight => const Color(0xB3232323);

  @override
  Color get textColorLighter => const Color(0x80232323);

  @override
  Color get primary => const Color(0xFF457b9d);

  @override
  Color get primaryLight => const Color(0xFFe5f2fb);

  @override
  Color get primaryLighter => const Color(0xFFf0f9fe);

  @override
  Color get accent => const Color(0xFFf4a261);

  @override
  Color get accentLight => const Color(0xFFfce6d4);

  @override
  Color get accentLighter => const Color(0xFFfef9f5);
}

class ThemeColorsDark extends ThemeColors {
  static const _instance = ThemeColorsDark._internal();

  static ThemeColorsDark get instance => _instance;

  const ThemeColorsDark._internal();

  @override
  Color get background => const Color(0xFFFFFFFF);

  @override
  Color get textColor => const Color(0xFF232323);

  @override
  Color get textColorLight => const Color(0xB3232323);

  @override
  Color get textColorLighter => const Color(0x80232323);

  @override
  Color get primary => const Color(0xFF457b9d);

  @override
  Color get primaryLight => const Color(0xFFa8dadc);

  @override
  Color get primaryLighter => const Color(0xFFf1faee);

  @override
  Color get accent => const Color(0xFFf4a261);

  @override
  Color get accentLight => const Color(0xFFe9c46a);

  @override
  Color get accentLighter => const Color(0xFFf4e1b4);
}
