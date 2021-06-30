import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/form_fields/select_form_field/select_form_field_item.dart';
import 'package:flutter_core_ui_kit/form_fields/select_form_field/select_form_field_list.dart';

import '../alphanumeric_form_field.dart';

class MultiSelectFormField<T> extends StatefulWidget {
  final String? labelText;
  final List<SelectFormFieldItem<T>> items;
  final FormFieldValidator<List<T>>? validator;
  final ValueChanged<List<T>?>? onChange;
  final List<SelectFormFieldItem<T>>? initialValue;
  final IconData? prefixIcon;
  final int minLines;
  final int maxLines;
  final bool enabled;
  final bool readOnly;
  final bool enableTrailingActions;

  const MultiSelectFormField({
    Key? key,
    required this.items,
    this.labelText,
    this.validator,
    this.onChange,
    this.initialValue,
    this.prefixIcon,
    this.minLines = 1,
    this.maxLines = 1,
    this.enabled = true,
    this.readOnly = false,
    this.enableTrailingActions = true,
  })  : assert(minLines <= maxLines),
        super(key: key);

  @override
  _MultiSelectFormFieldState<T> createState() => _MultiSelectFormFieldState<T>();
}

class _MultiSelectFormFieldState<T> extends State<MultiSelectFormField<T>> {
  late List<SelectFormFieldItem<T>> _currentValues;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _currentValues = widget.initialValue ?? [];
    _controller = TextEditingController(
      text: _currentValues.isNotEmpty ? _currentValues.map((v) => v.label).reduce((a, b) => '$a • $b') : null,
    );
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
      onTap: _onTap,
      validator: _validator,
      enabled: widget.enabled,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      readOnly: widget.readOnly,
      labelText: widget.labelText,
      prefixIcon: widget.prefixIcon,
      showCursor: false,
      enableTrailingActions: false,
      enableInteractiveSelection: widget.enableTrailingActions,
    );
  }

  void _onTap() async {
    // if (MediaQuery.of(context).isA(MediaQueryBreakPoints.LARGE_SCREEN)) {
    //   //todo open drop down
    // } else {
    final result = await Navigator.push(
      context,
      MaterialPageRoute<List<SelectFormFieldItem<T>>?>(
        fullscreenDialog: true,
        builder: (context) => SelectFormFieldList<T>(
          items: widget.items,
          hasMultipleSelection: true,
          initialValues: _currentValues,
        ),
      ),
    );
    if (result != null) {
      _onChange(result);
    }
    // }
  }

  String? _validator(String? value) {
    return widget.validator?.call(_currentValues.map((v) => v.value).toList());
  }


  void _onChange(List<SelectFormFieldItem<T>> items) {
    setState(() {
      widget.onChange?.call(items.map((i) => i.value).toList());
      _currentValues = items;
      if (_currentValues.isEmpty) {
        _controller.clear();
      } else {
        _controller.text = _currentValues.map((v) => v.label).reduce((a, b) => '$a • $b');
      }
    });
  }
}
