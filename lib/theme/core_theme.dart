import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'core_colors.dart';

part 'constants.dart';

part 'core_text_theme.dart';

part 'utils.dart';

abstract class CoreTheme {
  static late final ThemeColors _themeColorsLight;
  static late final ThemeColors _themeColorsDark;

  static void init(ThemeColors themeColorsLight, ThemeColors themeColorsDark) {
    _themeColorsLight = themeColorsLight;
    _themeColorsDark = themeColorsDark;
  }

  //region Cupertino
  static CupertinoThemeData cupertinoThemeDataOf(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return _cupertinoThemeLight;
    }
    return _cupertinoThemeDark;
  }

  static final CupertinoThemeData _cupertinoThemeLight = CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        dateTimePickerTextStyle: ThemeData.dark().textTheme.headline6,
        pickerTextStyle: ThemeData.dark().textTheme.headline6,
      ),
      brightness: Brightness.light);

  static final CupertinoThemeData _cupertinoThemeDark = CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        dateTimePickerTextStyle: ThemeData.dark().textTheme.headline6,
        pickerTextStyle: ThemeData.dark().textTheme.headline6,
      ),
      brightness: Brightness.dark);

  //endregion

  static final ThemeData light = ThemeData(
    scaffoldBackgroundColor: _themeColorsLight.background,
    backgroundColor: _themeColorsLight.background,
    brightness: Brightness.light,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    accentColorBrightness: Brightness.light,
    buttonColor: _themeColorsLight.accent,
    accentTextTheme: ThemeData.dark().textTheme,
    //region Input fields
    inputDecorationTheme: ThemeData.dark().inputDecorationTheme.copyWith(
          filled: true,
          alignLabelWithHint: true,
          labelStyle: ThemeData.dark().textTheme.textFieldLabel?.apply(color: _themeColorsLight.textColor),
          hintStyle: ThemeData.dark().textTheme.textFieldHint?.apply(color: _themeColorsLight.textColorLighter),
          errorStyle: ThemeData.dark().textTheme.textFieldError?.apply(color: CoreColors.red),
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _themeColorsLight.primary),
            borderRadius: BorderRadius.circular(Dimens.RADIUS_M),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(Dimens.RADIUS_M),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _themeColorsLight.accent),
            borderRadius: BorderRadius.circular(Dimens.RADIUS_M),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CoreColors.red),
            borderRadius: BorderRadius.circular(Dimens.RADIUS_M),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CoreColors.red),
            borderRadius: BorderRadius.circular(Dimens.RADIUS_M),
          ),
        ),
    textSelectionTheme: ThemeData.dark().textSelectionTheme.copyWith(
          cursorColor: _themeColorsLight.accent,
          selectionColor: _themeColorsLight.accent.withOpacity(.4),
          selectionHandleColor: _themeColorsLight.accent.withOpacity(.4),
        ),
    //endregion
    accentColor: _themeColorsLight.accent,
    hintColor: _themeColorsLight.accent,
    focusColor: _themeColorsLight.accent,
    fontFamily: _fontFamily,
    //region App bar
    appBarTheme: ThemeData.dark().appBarTheme.copyWith(
          backgroundColor: _themeColorsLight.background.withOpacity(.7),
          elevation: 0,
          centerTitle: true,
          actionsIconTheme: IconThemeData(color: _themeColorsLight.textColor),
          iconTheme: IconThemeData(color: _themeColorsLight.textColor),
        ),
    //endregion
    //region Text theme
    textTheme: ThemeData.dark().textTheme.copyWith(
          bodyText2: ThemeData.dark().textTheme.bodyText2?.copyWith(
                fontFamily: _fontFamily,
                color: _themeColorsLight.textColor,
              ),
        ),
    //endregion
    //region Tab bar
    tabBarTheme: TabBarTheme(
      labelStyle: ThemeData.dark().tabBarTheme.labelStyle?.copyWith(
            fontFamily: _fontFamily,
            fontWeight: FontWeight.w900,
            fontSize: 12.0,
          ),
      unselectedLabelStyle: ThemeData.dark().tabBarTheme.labelStyle?.copyWith(
            fontFamily: _fontFamily,
            fontWeight: FontWeight.w900,
            fontSize: 12.0,
          ),
      labelColor: CoreColors.lightBlue,
      unselectedLabelColor: _themeColorsLight.textColorLight,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.RADIUS_XS)),
        color: Colors.white,
      ),
    ),
    //endregion
    //region Buttons styles
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        onSurface: _themeColorsLight.primary,
        primary: _themeColorsLight.textColor,
        minimumSize: const Size(Dimens.BUTTON_HEIGHT, Dimens.BUTTON_HEIGHT),
        padding: const EdgeInsets.all(Dimens.SPACING_L),
        shadowColor: _themeColorsLight.primaryLight,
        textStyle: ThemeData.dark().textTheme.buttonText,
        animationDuration: Durations.BUTTON_TAP,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.RADIUS_M)),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: _themeColorsLight.primary,
        minimumSize: const Size(Dimens.BUTTON_HEIGHT, Dimens.BUTTON_HEIGHT),
        padding: const EdgeInsets.all(Dimens.SPACING_L),
        shadowColor: _themeColorsLight.primaryLight,
        textStyle: ThemeData.dark().textTheme.buttonText,
        animationDuration: Durations.BUTTON_TAP,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.RADIUS_M)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        onSurface: _themeColorsLight.primary,
        primary: _themeColorsLight.textColor,
        minimumSize: const Size(Dimens.BUTTON_HEIGHT, Dimens.BUTTON_HEIGHT),
        padding: const EdgeInsets.all(Dimens.SPACING_L),
        shadowColor: _themeColorsLight.primaryLight,
        textStyle: ThemeData.dark().textTheme.buttonText,
        animationDuration: Durations.BUTTON_TAP,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _themeColorsLight.primary, style: BorderStyle.solid),
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.RADIUS_M)),
        ),
      ),
    ),
    //endregion
    chipTheme: ThemeData.dark().chipTheme.copyWith(
        backgroundColor: _themeColorsLight.primaryLight,
        deleteIconColor: _themeColorsLight.primary,
        labelStyle: ThemeData.dark().textTheme.chips),
    iconTheme: ThemeData.dark().iconTheme.copyWith(color: _themeColorsLight.textColor),
    cupertinoOverrideTheme: _cupertinoThemeLight,
  );

  static final ThemeData dark = ThemeData(
    scaffoldBackgroundColor: _themeColorsDark.background,
    backgroundColor: _themeColorsDark.background,
    brightness: Brightness.dark,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    accentColorBrightness: Brightness.dark,
    buttonColor: _themeColorsDark.accent,
    accentTextTheme: ThemeData.dark().textTheme,
    //region Input fields
    inputDecorationTheme: ThemeData.dark().inputDecorationTheme.copyWith(
          filled: true,
          alignLabelWithHint: true,
          labelStyle: ThemeData.dark().textTheme.textFieldLabel?.apply(color: _themeColorsDark.textColor),
          hintStyle: ThemeData.dark().textTheme.textFieldHint?.apply(color: _themeColorsDark.textColorLighter),
          errorStyle: ThemeData.dark().textTheme.textFieldError?.apply(color: CoreColors.red),
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _themeColorsDark.primary),
            borderRadius: BorderRadius.circular(Dimens.RADIUS_M),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(Dimens.RADIUS_M),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _themeColorsDark.accent),
            borderRadius: BorderRadius.circular(Dimens.RADIUS_M),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CoreColors.red),
            borderRadius: BorderRadius.circular(Dimens.RADIUS_M),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CoreColors.red),
            borderRadius: BorderRadius.circular(Dimens.RADIUS_M),
          ),
        ),
    textSelectionTheme: ThemeData.dark().textSelectionTheme.copyWith(
          cursorColor: _themeColorsDark.accent,
          selectionColor: _themeColorsDark.accent.withOpacity(.4),
          selectionHandleColor: _themeColorsDark.accent.withOpacity(.4),
        ),
    //endregion
    accentColor: _themeColorsDark.accent,
    hintColor: _themeColorsDark.accent,
    focusColor: _themeColorsDark.accent,
    fontFamily: _fontFamily,
    //region App bar
    appBarTheme: ThemeData.dark().appBarTheme.copyWith(
          backgroundColor: _themeColorsDark.background.withOpacity(.7),
          elevation: 0,
          centerTitle: true,
          actionsIconTheme: IconThemeData(color: _themeColorsDark.textColor),
          iconTheme: IconThemeData(color: _themeColorsDark.textColor),
        ),
    //endregion
    //region Text theme
    textTheme: ThemeData.dark().textTheme.copyWith(
          bodyText2: ThemeData.dark().textTheme.bodyText2?.copyWith(
                fontFamily: _fontFamily,
                color: _themeColorsDark.textColor,
              ),
        ),
    //endregion
    //region Tab bar
    tabBarTheme: TabBarTheme(
      labelStyle: ThemeData.dark().tabBarTheme.labelStyle?.copyWith(
            fontFamily: _fontFamily,
            fontWeight: FontWeight.w900,
            fontSize: 12.0,
          ),
      unselectedLabelStyle: ThemeData.dark().tabBarTheme.labelStyle?.copyWith(
            fontFamily: _fontFamily,
            fontWeight: FontWeight.w900,
            fontSize: 12.0,
          ),
      labelColor: CoreColors.lightBlue,
      unselectedLabelColor: _themeColorsDark.textColorLight,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.RADIUS_XS)),
        color: Colors.white,
      ),
    ),
    //endregion
    //region Buttons styles
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        onSurface: _themeColorsDark.primary,
        primary: _themeColorsDark.textColor,
        minimumSize: const Size(Dimens.BUTTON_HEIGHT, Dimens.BUTTON_HEIGHT),
        padding: const EdgeInsets.all(Dimens.SPACING_L),
        shadowColor: _themeColorsDark.primaryLight,
        textStyle: ThemeData.dark().textTheme.buttonText,
        animationDuration: Durations.BUTTON_TAP,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.RADIUS_M)),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: _themeColorsDark.primary,
        minimumSize: const Size(Dimens.BUTTON_HEIGHT, Dimens.BUTTON_HEIGHT),
        padding: const EdgeInsets.all(Dimens.SPACING_L),
        shadowColor: _themeColorsDark.primaryLight,
        textStyle: ThemeData.dark().textTheme.buttonText,
        animationDuration: Durations.BUTTON_TAP,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.RADIUS_M)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        onSurface: _themeColorsDark.primary,
        primary: _themeColorsDark.textColor,
        minimumSize: const Size(Dimens.BUTTON_HEIGHT, Dimens.BUTTON_HEIGHT),
        padding: const EdgeInsets.all(Dimens.SPACING_L),
        shadowColor: _themeColorsDark.primaryLight,
        textStyle: ThemeData.dark().textTheme.buttonText,
        animationDuration: Durations.BUTTON_TAP,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _themeColorsDark.primary, style: BorderStyle.solid),
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.RADIUS_M)),
        ),
      ),
    ),
    //endregion
    chipTheme: ThemeData.dark().chipTheme.copyWith(
        backgroundColor: _themeColorsDark.primaryLight,
        deleteIconColor: _themeColorsDark.primary,
        labelStyle: ThemeData.dark().textTheme.chips),
    iconTheme: ThemeData.dark().iconTheme.copyWith(color: _themeColorsDark.textColor),
    cupertinoOverrideTheme: _cupertinoThemeDark,
  );
}
