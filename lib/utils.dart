import 'package:flutter/material.dart';

extension $ListWidget on List<Widget> {
  List<Widget> addVerticalSpacer(double space) {
    return asMap()
        .map((key, value) {
      if (key == length - 1) {
        return MapEntry(key, [value]);
      }
      return MapEntry(key, [value, SizedBox(height: space)]);
    })
        .values
        .fold(<Widget>[], (a, b) => [...a, ...b]);
  }

  List<Widget> addHorizontalSpacer(double space) {
    return asMap()
        .map((key, value) {
      if (key == length - 1) {
        return MapEntry(key, [value]);
      }
      return MapEntry(key, [value, SizedBox(width: space)]);
    })
        .values
        .fold(<Widget>[], (a, b) => [...a, ...b]);
  }

  List<Widget> addHorizontalDivider(Divider divider) {
    return asMap()
        .map((key, value) {
      if (key == length - 1) {
        return MapEntry(key, [value]);
      }
      return MapEntry(key, [value, divider]);
    })
        .values
        .fold(<Widget>[], (a, b) => [...a, ...b]);
  }
}
