part of 'core_theme.dart';

const _smallScreen = 575.98;
const _mediumScreen = 991.98;

extension Screen on MediaQueryData {
  bool isA(MediaQueryBreakPoints breakPoint) {
    if (size.width <= _smallScreen) {
      return breakPoint == MediaQueryBreakPoints.smallScreen;
    }
    if (size.width <= _mediumScreen) {
      return breakPoint == MediaQueryBreakPoints.mediumScreen;
    }
    return breakPoint == MediaQueryBreakPoints.largeScreen;
  }

  MediaQueryBreakPoints get asBreakPoint {
    if (size.width <= _smallScreen) {
      return MediaQueryBreakPoints.smallScreen;
    }
    if (size.width <= _mediumScreen) {
      return MediaQueryBreakPoints.mediumScreen;
    }
    return MediaQueryBreakPoints.largeScreen;
  }
}
