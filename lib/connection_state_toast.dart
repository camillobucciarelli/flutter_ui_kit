import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/flutter_core_ui_kit.dart';
import 'package:flutter_core_ui_kit/snack_bar_overlay.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionStateToast extends StatefulWidget {
  final Widget child;

  const ConnectionStateToast({required this.child});

  @override
  _ConnectionStateToastState createState() => _ConnectionStateToastState();
}

class _ConnectionStateToastState extends State<ConnectionStateToast> {
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    if (!kIsWeb) {
      _streamSubscription = InternetConnectionChecker().onStatusChange.listen(
        (InternetConnectionStatus status) {
          switch (status) {
            case InternetConnectionStatus.connected:
              SnackBarOverlay.dismiss();
              break;
            case InternetConnectionStatus.disconnected:
              SnackBarOverlay.showWarning(context, CoreUIKit.connectionWarningMessage);
              break;
          }
        },
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
