import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'theme/core_theme.dart';

import 'adaptive_container.dart';

const _animationDuration = Duration(milliseconds: 1000);
const _toastDuration = Duration(milliseconds: 5000);
const _padding = EdgeInsets.all(Dimens.spacingL);

EdgeInsets _margin(BuildContext context) => EdgeInsets.fromLTRB(
      Dimens.spacingXS,
      MediaQuery.of(context).viewPadding.top + Dimens.spacingXS,
      Dimens.spacingXS,
      Dimens.spacingL,
    );

/// Following the different component configurations:
/// ERROR:
///  * autoHide
///     Toast.show('msg', context, ToastAppearance.error);
///  * hide programmatically
///     Toast.show('msg', context, ToastAppearance.error, autoHide: false);
///     Toast.dismiss();
/// INFO:
///  * autoHide
///     Toast.show('msg', context, ToastAppearance.info);
///  * hide programmatically
///     Toast.show('msg', context, ToastAppearance.info, autoHide: false);
///     Toast.dismiss();
/// CTA:
///  * autoHide
///     Toast.show('msg', context, ToastAppearance.cta, ctaLabel:'label', ctaAction: (){});
///  * hide programmatically
///     Toast.show('msg', context, ToastAppearance.cta, autoHide: false, ctaLabel:'label', ctaAction: (){});
///     Toast.dismiss();
class Toast {
  static void show(String msg, BuildContext context, ToastAppearance appearance,
      {String ctaLabel = '', VoidCallback? ctaAction, bool autoHide = true}) {
    _ToastView.dismiss();
    _ToastView.createView(msg, context, appearance, autoHide: autoHide, ctaLabel: ctaLabel, ctaAction: ctaAction);
  }

  static void dismiss() {
    _ToastView.dismiss();
  }
}

class _ToastView {
  static OverlayState? _overlayState;
  static OverlayEntry? _overlayEntry;
  static GlobalKey? _overlayKey;

  static void createView(
    String msg,
    BuildContext context,
    ToastAppearance appearance, {
    bool autoHide = true,
    String ctaLabel = '',
    VoidCallback? ctaAction,
  }) async {
    if (_overlayKey != null) {
      dismiss();
    }
    _overlayKey = GlobalKey<_ToastWidgetState>();
    _overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      maintainState: true,
      builder: (BuildContext context) {
        return _ToastWidget(
          appearance,
          autoHide: autoHide,
          key: _overlayKey,
          msg: msg,
          ctaLabel: ctaLabel,
          ctaAction: ctaAction,
        );
      },
    );
    if (_overlayEntry != null) {
      _overlayState?.insert(_overlayEntry!);
    }
  }

  static void dismiss() async {
    if (_overlayKey?.currentState != null) {
      (_overlayKey?.currentState as _ToastWidgetState).dismiss();
    }
    if (_overlayKey != null && (_overlayState?.mounted ?? false)) _overlayEntry?.remove();
    _overlayKey = null;
  }
}

enum ToastAppearance { error, info, cta }

extension _$ToastAppearance on ToastAppearance {
  BoxDecoration Function(ThemeData) get decoration =>
      {
        ToastAppearance.error: (ThemeData theme) => BoxDecoration(
              boxShadow: const [
                BoxShadow(offset: Offset(0, 15), blurRadius: 20, color: Colors.black12, spreadRadius: 5),
              ],
              color: CoreColors.lightRed,
              borderRadius: BorderRadius.circular(Dimens.radiusS),
            ),
        ToastAppearance.info: (ThemeData theme) => BoxDecoration(
              boxShadow: const [
                BoxShadow(offset: Offset(0, 15), blurRadius: 20, color: Colors.black12, spreadRadius: 5),
              ],
              color: CoreColors.lightGreen,
              borderRadius: BorderRadius.circular(Dimens.radiusS),
            ),
        ToastAppearance.cta: (ThemeData theme) => BoxDecoration(
              boxShadow: const [
                BoxShadow(offset: Offset(0, 15), blurRadius: 20, color: Colors.black12, spreadRadius: 5),
              ],
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(Dimens.radiusS),
            )
      }[this] ??
      (ThemeData theme) => BoxDecoration(
            boxShadow: const [
              BoxShadow(offset: Offset(0, 15), blurRadius: 20, color: Colors.black12, spreadRadius: 5),
            ],
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(Dimens.radiusS),
          );

  Function get content =>
      {
        ToastAppearance.error: (BuildContext context, String msg, String ctaLabel, VoidCallback? ctaAction) => Text(
              msg,
              style: Theme.of(context).textTheme.headline4?.apply(color: Colors.white),
            ),
        ToastAppearance.info: (BuildContext context, String msg, String ctaLabel, VoidCallback? ctaAction) => Text(
              msg,
              style: Theme.of(context).textTheme.snackBar,
            ),
        ToastAppearance.cta: (BuildContext context, String msg, String ctaLabel, VoidCallback? ctaAction) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    msg,
                    style: Theme.of(context).textTheme.snackBar,
                  ),
                ),
                const SizedBox(width: Dimens.spacingXS),
                TextButton(
                  onPressed: ctaAction,
                  child: Text(
                    ctaLabel.toUpperCase(),
                    style: Theme.of(context).textTheme.snackBar,
                  ),
                )
              ],
            )
      }[this] ??
      (BuildContext context, String msg, String ctaLabel, VoidCallback? ctaAction) => Text(
            msg,
            style: Theme.of(context).textTheme.snackBar,
          );
}

class _ToastWidget extends StatefulWidget {
  final String msg;
  final String ctaLabel;
  final VoidCallback? ctaAction;
  final ToastAppearance appearance;
  final bool autoHide;

  const _ToastWidget(
    this.appearance, {
    Key? key,
    required this.autoHide,
    required this.msg,
    this.ctaAction,
    this.ctaLabel = '',
  }) : super(key: key);

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset;
  late Timer _timer;
  bool _alreadyOpen = false;

  @override
  void initState() {
    super.initState();
    if (_alreadyOpen) {
      _ToastView.dismiss();
      return;
    }
    _controller = AnimationController(vsync: this, duration: _animationDuration);
    _offset = Tween<Offset>(begin: const Offset(.0, -1.0), end: Offset.zero).animate(_controller);
    _controller.forward();
    _alreadyOpen = true;
    if (widget.autoHide) {
      _timer = Timer(_toastDuration, dismiss);
    }
  }

  void dismiss() {
    if (_controller.isDismissed || !mounted) return;
    _controller.reverse();
    _timer = Timer(_animationDuration, _ToastView.dismiss);
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
        mainAxisSize: MainAxisSize.min,
        children: [
          AdaptiveContainer(
            child: Container(
              width: double.infinity,
              margin: _margin(context),
              padding: _padding,
              decoration: widget.appearance.decoration(Theme.of(context)),
              child: widget.appearance.content(context, widget.msg, widget.ctaLabel, widget.ctaAction),
            ),
          ),
        ],
      ),
    );
  }
}
