import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';

class SnackBarOverlay {
  static void dismiss() {
    _SnackBarOverlayView.dismiss();
  }

  static void showError(BuildContext context, String msg) {
    _SnackBarOverlayView.createView(msg, context, SnackBarOverlayThemeError.instance);
  }

  static void showInfo(BuildContext context, String msg) {
    _SnackBarOverlayView.createView(msg, context, SnackBarOverlayThemeInfo.instance);
  }

  static void showWarning(BuildContext context, String msg) {
    _SnackBarOverlayView.createView(msg, context, SnackBarOverlayThemeWarning.instance);
  }
}

class _SnackBarOverlayView {
  static OverlayState? _overlayState;
  static OverlayEntry? _overlayEntry;
  static GlobalKey? _overlayKey;

  static void createView(String msg, BuildContext context, SnackBarOverlayTheme overlayTheme) {
    if (_overlayKey != null) {
      dismiss();
    }
    _overlayKey = GlobalKey<_SnackBarOverlayWidgetState>();
    _overlayState = Overlay.of(context, rootOverlay: true);
    _overlayEntry = OverlayEntry(
      maintainState: true,
      builder: (BuildContext context) {
        return _SnackBarOverlayWidget(
          msg: msg,
          overlayTheme: overlayTheme,
        );
      },
    );
    if(_overlayEntry != null) {
      _overlayState?.insert(_overlayEntry!);
    }
  }

  static void dismiss() async {
    if(_overlayKey?.currentState != null){
      (_overlayKey?.currentState as _SnackBarOverlayWidgetState).dismiss();
    }
    if (_overlayKey != null && (_overlayState?.mounted ?? false)) _overlayEntry?.remove();
    _overlayKey = null;
  }
}

class _SnackBarOverlayWidget extends StatefulWidget {
  final String msg;
  final SnackBarOverlayTheme overlayTheme;

  const _SnackBarOverlayWidget({
    Key? key,
    required this.msg,
    required this.overlayTheme,
  }) : super(key: key);

  @override
  _SnackBarOverlayWidgetState createState() => _SnackBarOverlayWidgetState();
}

class _SnackBarOverlayWidgetState extends State<_SnackBarOverlayWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _offset = Tween<Offset>(
      begin: const Offset(.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    _controller.forward();
  }

  void dismiss() {
    if (_controller.isDismissed || !mounted) return;
    _controller.reverse();
    _timer = Timer(const Duration(milliseconds: 1000), _SnackBarOverlayView.dismiss);
  }

  @override
  void deactivate() {
    dismiss();
    super.deactivate();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offset,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(Dimens.SPACING_L),
            color: widget.overlayTheme.background,
            child: Text(
              widget.msg,
              style: Theme.of(context).textTheme.headline4?.apply(color: widget.overlayTheme.textColor),
            ),
          ),
        ],
      ),
    );
  }
}

abstract class SnackBarOverlayTheme {
  Color get background;
  Color get textColor;
  EdgeInsetsGeometry get padding;
  //borderradius
}

class SnackBarOverlayThemeError extends SnackBarOverlayTheme {
  static final _instance = SnackBarOverlayThemeError._internal();

  static SnackBarOverlayThemeError get instance => _instance;

  SnackBarOverlayThemeError._internal();

  @override
  Color get background => CoreColors.lightRed;
  @override
  Color get textColor => Colors.white;
  @override
  EdgeInsetsGeometry get padding => const EdgeInsets.all(Dimens.SPACING_L);
}

class SnackBarOverlayThemeInfo extends SnackBarOverlayTheme {
  static final _instance = SnackBarOverlayThemeInfo._internal();

  static SnackBarOverlayThemeInfo get instance => _instance;

  SnackBarOverlayThemeInfo._internal();
  @override
  Color get background => CoreColors.lightGreen;
  @override
  Color get textColor => Colors.white;
  @override
  EdgeInsetsGeometry get padding => const EdgeInsets.all(Dimens.SPACING_L);
}

class SnackBarOverlayThemeWarning extends SnackBarOverlayTheme {
  static final _instance = SnackBarOverlayThemeWarning._internal();

  static SnackBarOverlayThemeWarning get instance => _instance;

  SnackBarOverlayThemeWarning._internal();
  @override
  Color get background => CoreColors.lightOrange;
  @override
  Color get textColor => Colors.white;
  @override
  EdgeInsetsGeometry get padding => const EdgeInsets.all(Dimens.SPACING_L);
}
