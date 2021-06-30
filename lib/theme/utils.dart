part of 'core_theme.dart';

const _SMALL_SCREEN = 575.98;
const _MEDIUM_SCREEN = 991.98;

extension Screen on MediaQueryData {
  bool isA(MediaQueryBreakPoints breakPoint) {
    if (size.width <= _SMALL_SCREEN) {
      return breakPoint == MediaQueryBreakPoints.SMALL_SCREEN;
    }
    if (size.width <= _MEDIUM_SCREEN) {
      return breakPoint == MediaQueryBreakPoints.MEDIUM_SCREEN;
    }
    return breakPoint == MediaQueryBreakPoints.LARGE_SCREEN;
  }

  MediaQueryBreakPoints get asBreakPoint {
    if (size.width <= _SMALL_SCREEN) {
      return MediaQueryBreakPoints.SMALL_SCREEN;
    }
    if (size.width <= _MEDIUM_SCREEN) {
      return MediaQueryBreakPoints.MEDIUM_SCREEN;
    }
    return MediaQueryBreakPoints.LARGE_SCREEN;
  }
}
