import 'package:flutter/cupertino.dart';

class SelectFormFieldItem<T> {
  final String label;
  final IconData? icon;
  final T value;

  SelectFormFieldItem({required this.label, this.icon, required this.value});
}
