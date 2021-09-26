import 'dart:async';

import 'package:flutter/material.dart';

class TimerBuilder extends StatefulWidget {
  final Duration interval;
  final WidgetBuilder builder;

  const TimerBuilder(
    this.interval, {
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TimerBuilderState();

  const TimerBuilder.periodic(this.interval, {Key? key, required this.builder}) : super(key: key);
}

class _TimerBuilderState extends State<TimerBuilder> {
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  @override
  void didUpdateWidget(TimerBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    _update();
  }

  @override
  void initState() {
    super.initState();
    _update();
  }

  @override
  void dispose() {
    super.dispose();
    _cancel();
  }

  void _update() {
    _cancel();
    _timer = Timer.periodic(widget.interval, (_) {
      if (mounted) setState(() {});
    });
  }

  void _cancel() {
    _timer?.cancel();
  }
}
