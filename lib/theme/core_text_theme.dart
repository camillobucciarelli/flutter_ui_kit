part of 'core_theme.dart';

const _fontFamily = 'ProximaNova';

extension CoreTextTheme on TextTheme {
  TextStyle? get header => bodyText2?.copyWith(fontSize: 22.0, fontWeight: FontWeight.w600);
  TextStyle? get textFieldLabel => bodyText2?.copyWith(fontSize: 16.0, fontWeight: FontWeight.w400);
  TextStyle? get textFieldHint => bodyText2?.copyWith(fontSize: 16.0, fontWeight: FontWeight.w400);
  TextStyle? get buttonText => bodyText2?.copyWith(fontSize: 16.0, fontWeight: FontWeight.w600);
  TextStyle? get textFieldError => bodyText2?.copyWith(fontSize: 14.0, fontWeight: FontWeight.w600);
  TextStyle? get userAvatar => bodyText2?.copyWith(fontSize: 16.0, fontWeight: FontWeight.w600);
  TextStyle? get chips => bodyText2?.copyWith(fontSize: 16.0, fontWeight: FontWeight.w400);
  TextStyle? get appBar => bodyText2?.copyWith(fontSize: 16.0, fontWeight: FontWeight.w600);
  TextStyle? get snackBar => bodyText2?.copyWith(fontSize: 14.0, fontWeight: FontWeight.w400);
}
