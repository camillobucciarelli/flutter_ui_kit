import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

import '../buttons/button.dart';
import '../customized_app_bar.dart';
import '../theme/core_theme.dart';

class CropImage extends StatelessWidget {
  final _controller = CropController();
  final Uint8List imageData;
  final bool circle;
  final double initialSize;
  final void Function(Uint8List)? onCropped;

  CropImage({
    Key? key,
    required this.imageData,
    this.circle = false,
    this.initialSize = .5,
    this.onCropped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizedAppBar(
        actions: [Button.icon(icon: Icons.crop, onPressed: () => _crop(context))],
      ),
      body: Crop(
        image: imageData,
        controller: _controller,
        onCropped: (image) => onCropped?.call(image),
        withCircleUi: circle,
        initialSize: initialSize,
        baseColor: ThemeColors.of(context).background,
        maskColor: ThemeColors.of(context).background.withOpacity(.7),
        cornerDotBuilder: (size, cornerIndex) => DotControl(color: ThemeColors.of(context).textColor),
      ),
    );
  }

  void _crop(BuildContext context) {
    if (circle) {
      _controller.cropCircle();
    } else {
      _controller.crop();
    }
    Navigator.of(context).pop();
  }
}
