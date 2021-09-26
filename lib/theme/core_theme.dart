import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'constants.dart';

part 'core_colors.dart';

part 'core_text_theme.dart';

part 'utils.dart';

class CoreTheme {
  static late final String _fontFamily;
  static late final ThemeColors _themeColorsLight;
  static late final ThemeColors _themeColorsDark;

  static void init({
    required ThemeColors themeColorsLight,
    required ThemeColors themeColorsDark,
    required String fontFamily,
  }) {
    _themeColorsLight = themeColorsLight;
    _themeColorsDark = themeColorsDark;
    _fontFamily = fontFamily;
  }

  //region Cupertino
  static CupertinoThemeData cupertinoThemeDataOf(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return cupertinoThemeLight;
    }
    return cupertinoThemeDark;
  }

  static final CupertinoThemeData cupertinoThemeLight = CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        dateTimePickerTextStyle: ThemeData.dark().textTheme.bodyText2,
        pickerTextStyle: ThemeData.dark().textTheme.bodyText2,
      ),
      brightness: Brightness.light);

  static final CupertinoThemeData cupertinoThemeDark = CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        dateTimePickerTextStyle: ThemeData.dark().textTheme.bodyText2,
        pickerTextStyle: ThemeData.dark().textTheme.bodyText2,
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
    //region Input fields
    inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
          filled: true,
          alignLabelWithHint: true,
          counterStyle: ThemeData.light().textTheme.textFieldLabel?.apply(color: _themeColorsLight.textColor),
          labelStyle: ThemeData.light().textTheme.textFieldLabel?.apply(color: _themeColorsLight.textColor),
          hintStyle: ThemeData.light().textTheme.textFieldHint?.apply(color: _themeColorsLight.textColorLighter),
          errorStyle: ThemeData.light().textTheme.textFieldError?.apply(color: CoreColors.red),
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _themeColorsLight.primary),
            borderRadius: BorderRadius.circular(Dimens.radiusM),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(Dimens.radiusM),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _themeColorsLight.secondary),
            borderRadius: BorderRadius.circular(Dimens.radiusM),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CoreColors.red),
            borderRadius: BorderRadius.circular(Dimens.radiusM),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CoreColors.red),
            borderRadius: BorderRadius.circular(Dimens.radiusM),
          ),
        ),
    textSelectionTheme: ThemeData.light().textSelectionTheme.copyWith(
          cursorColor: _themeColorsLight.secondary,
          selectionColor: _themeColorsLight.secondary.withOpacity(.4),
          selectionHandleColor: _themeColorsLight.secondary.withOpacity(.4),
        ),
    hintColor: _themeColorsLight.secondary,
    focusColor: _themeColorsLight.secondary,
    fontFamily: _fontFamily,
    //region App bar
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          backgroundColor: _themeColorsLight.background.withOpacity(.7),
          elevation: 0,
          centerTitle: true,
          actionsIconTheme: IconThemeData(color: _themeColorsLight.textColor),
          iconTheme: IconThemeData(color: _themeColorsLight.textColor),
        ),
    //endregion
    //region Text theme
    textTheme: ThemeData.light().textTheme.copyWith(
          bodyText2: ThemeData.light().textTheme.bodyText2?.copyWith(
                fontFamily: _fontFamily,
                fontSize: 16.0,
                color: _themeColorsLight.textColor,
              ),
        ),
    //endregion
    //region Tab bar
    tabBarTheme: TabBarTheme(
      labelStyle: ThemeData.light().tabBarTheme.labelStyle?.copyWith(
            fontFamily: _fontFamily,
            fontWeight: FontWeight.w900,
            fontSize: 16.0,
          ),
      unselectedLabelStyle: ThemeData.light().tabBarTheme.labelStyle?.copyWith(
            fontFamily: _fontFamily,
            fontWeight: FontWeight.w900,
            fontSize: 16.0,
          ),
      labelColor: CoreColors.lightBlue,
      unselectedLabelColor: _themeColorsLight.textColorLight,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.radiusXS)),
        color: Colors.white,
      ),
    ),
    //endregion
    //region Buttons styles
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        onSurface: _themeColorsLight.primary,
        primary: _themeColorsLight.textColor,
        minimumSize: const Size(Dimens.buttonHeight, Dimens.buttonHeight),
        padding: const EdgeInsets.all(Dimens.spacingL),
        shadowColor: _themeColorsLight.primaryLight,
        textStyle: ThemeData.light().textTheme.buttonText?.copyWith(fontFamily: _fontFamily),
        animationDuration: Durations.buttonTap,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.radiusM)),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: _themeColorsLight.primary,
        minimumSize: const Size(Dimens.buttonHeight, Dimens.buttonHeight),
        padding: const EdgeInsets.all(Dimens.spacingL),
        shadowColor: _themeColorsLight.primaryLight,
        textStyle: ThemeData.light().textTheme.buttonText?.copyWith(fontFamily: _fontFamily),
        animationDuration: Durations.buttonTap,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.radiusM)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        onSurface: _themeColorsLight.primary,
        primary: _themeColorsLight.textColor,
        minimumSize: const Size(Dimens.buttonHeight, Dimens.buttonHeight),
        padding: const EdgeInsets.all(Dimens.spacingL),
        shadowColor: _themeColorsLight.primaryLight,
        textStyle: ThemeData.light().textTheme.buttonText?.copyWith(fontFamily: _fontFamily),
        animationDuration: Durations.buttonTap,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _themeColorsLight.primary, style: BorderStyle.solid),
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.radiusM)),
        ),
      ),
    ),
    //endregion
    chipTheme: ThemeData.light().chipTheme.copyWith(
        backgroundColor: _themeColorsLight.primaryLight,
        deleteIconColor: _themeColorsLight.primary,
        labelStyle: ThemeData.light().textTheme.chips),
    iconTheme: ThemeData.light().iconTheme.copyWith(color: _themeColorsLight.textColor),
    cupertinoOverrideTheme: cupertinoThemeLight, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: _themeColorsLight.secondary),
  );

  static final ThemeData dark = ThemeData(
    scaffoldBackgroundColor: _themeColorsDark.background,
    backgroundColor: _themeColorsDark.background,
    brightness: Brightness.dark,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
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
            borderRadius: BorderRadius.circular(Dimens.radiusM),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(Dimens.radiusM),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _themeColorsDark.secondary),
            borderRadius: BorderRadius.circular(Dimens.radiusM),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CoreColors.red),
            borderRadius: BorderRadius.circular(Dimens.radiusM),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CoreColors.red),
            borderRadius: BorderRadius.circular(Dimens.radiusM),
          ),
        ),
    textSelectionTheme: ThemeData.dark().textSelectionTheme.copyWith(
          cursorColor: _themeColorsDark.secondary,
          selectionColor: _themeColorsDark.secondary.withOpacity(.4),
          selectionHandleColor: _themeColorsDark.secondary.withOpacity(.4),
        ),
    hintColor: _themeColorsDark.secondary,
    focusColor: _themeColorsDark.secondary,
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
        borderRadius: BorderRadius.all(Radius.circular(Dimens.radiusXS)),
        color: Colors.white,
      ),
    ),
    //endregion
    //region Buttons styles
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        onSurface: _themeColorsDark.primary,
        primary: _themeColorsDark.textColor,
        minimumSize: const Size(Dimens.buttonHeight, Dimens.buttonHeight),
        padding: const EdgeInsets.all(Dimens.spacingL),
        shadowColor: _themeColorsDark.primaryLight,
        textStyle: ThemeData.dark().textTheme.buttonText,
        animationDuration: Durations.buttonTap,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.radiusM)),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: _themeColorsDark.primary,
        minimumSize: const Size(Dimens.buttonHeight, Dimens.buttonHeight),
        padding: const EdgeInsets.all(Dimens.spacingL),
        shadowColor: _themeColorsDark.primaryLight,
        textStyle: ThemeData.dark().textTheme.buttonText,
        animationDuration: Durations.buttonTap,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.radiusM)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        onSurface: _themeColorsDark.primary,
        primary: _themeColorsDark.textColor,
        minimumSize: const Size(Dimens.buttonHeight, Dimens.buttonHeight),
        padding: const EdgeInsets.all(Dimens.spacingL),
        shadowColor: _themeColorsDark.primaryLight,
        textStyle: ThemeData.dark().textTheme.buttonText,
        animationDuration: Durations.buttonTap,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _themeColorsDark.primary, style: BorderStyle.solid),
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.radiusM)),
        ),
      ),
    ),
    //endregion
    chipTheme: ThemeData.dark().chipTheme.copyWith(
        backgroundColor: _themeColorsDark.primaryLight,
        deleteIconColor: _themeColorsDark.primary,
        labelStyle: ThemeData.dark().textTheme.chips),
    iconTheme: ThemeData.dark().iconTheme.copyWith(color: _themeColorsDark.textColor),
    cupertinoOverrideTheme: cupertinoThemeDark, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: _themeColorsDark.secondary),
  );
}
