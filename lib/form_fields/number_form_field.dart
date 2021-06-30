import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/buttons/button.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';

import 'alphanumeric_form_field.dart';

class NumberFormField extends StatefulWidget {
  final String? labelText;
  final FormFieldValidator<num>? validator;
  final ValueChanged<num>? onChange;
  final num? initialValue;
  final IconData? prefixIcon;
  final bool enabled;
  final bool readOnly;
  final NumberFormFieldFormatter formatter;
  final num step;
  final num? minValue;
  final num? maxValue;

  const NumberFormField({
    Key? key,
    this.labelText,
    this.validator,
    this.onChange,
    this.initialValue,
    this.prefixIcon,
    this.minValue,
    this.maxValue,
    this.step = 1,
    this.enabled = true,
    this.readOnly = false,
    this.formatter = _defaultFormatter,
  })  : assert(minValue != null || initialValue != null),
        super(key: key);

  @override
  _NumberFormFieldState createState() => _NumberFormFieldState();
}

class _NumberFormFieldState extends State<NumberFormField> {
  late TextEditingController _controller;

  late num __currentValue;
  num get _currentValue => __currentValue;
  set _currentValue(num value) {
    __currentValue = value;
    _controller.text = widget.formatter(value);
    widget.onChange?.call(value);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _currentValue = widget.initialValue ?? widget.minValue ?? 0;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlphanumericFormField(
      controller: _controller,
      validator: _validator,
      enabled: widget.enabled,
      readOnly: true,
      labelText: widget.labelText,
      prefixIcon: widget.prefixIcon,
      showCursor: false,
      enableTrailingActions: false,
      trailingAction: _trailingAction,
    );
  }

  String? _validator(String? value) {
    return widget.validator?.call(_currentValue);
  }

  Widget get _trailingAction {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Button.icon(icon: Icons.remove_rounded, size: Dimens.ICON_BUTTON_SIZE * .8, onPressed: _remove),
        const SizedBox(width: Dimens.SPACING_XS),
        Button.icon(icon: Icons.add_rounded, size: Dimens.ICON_BUTTON_SIZE * .8, onPressed: _add),
        const SizedBox(width: Dimens.SPACING_S),
      ],
    );
  }

  void _remove() {
    setState(() {
      final newValue = _currentValue - widget.step;
      if (widget.minValue != null) {
        if (newValue >= widget.minValue!) {
          _currentValue = newValue;
        }
      } else {
        _currentValue = newValue;
      }
    });
  }

  void _add() {
    setState(() {
      final newValue = _currentValue + widget.step;
      if (widget.maxValue != null) {
        if (newValue <= widget.maxValue!) {
          _currentValue = newValue;
        }
      } else {
        _currentValue = newValue;
      }
    });
  }
}

typedef NumberFormFieldFormatter = String Function(num?);

String _defaultFormatter(num? number) => number?.toString() ?? '';
