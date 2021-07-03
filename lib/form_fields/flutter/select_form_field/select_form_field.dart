import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/form_fields/flutter/select_form_field/select_form_field_item.dart';
import 'package:flutter_core_ui_kit/form_fields/flutter/select_form_field/select_form_field_list.dart';

import '../alphanumeric_form_field.dart';

class SelectFormField<T> extends StatefulWidget {
  final String? labelText;
  final List<SelectFormFieldItem<T>> items;
  final FormFieldValidator<T>? validator;
  final ValueChanged<T?>? onChange;
  final SelectFormFieldItem<T>? initialValue;
  final IconData? prefixIcon;
  final int minLines;
  final int maxLines;
  final bool enabled;
  final bool readOnly;

  const SelectFormField({
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
  })  : assert(minLines <= maxLines),
        super(key: key);

  @override
  _SelectFormFieldState<T> createState() => _SelectFormFieldState<T>();
}

class _SelectFormFieldState<T> extends State<SelectFormField<T>> {
  SelectFormFieldItem<T>? _currentValue;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _controller = TextEditingController(text: _currentValue?.label);
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
          initialValues: _currentValue != null ? [_currentValue!] : null,
        ),
      ),
    );
    if (result != null) {
      if (result.isEmpty) {
        _onChange(null);
      } else {
        _onChange(result.first);
      }
    }
    // }
  }

  String? _validator(String? value) {
    return widget.validator?.call(_currentValue?.value);
  }

  void _onChange(SelectFormFieldItem<T>? item) {
    setState(() {
      widget.onChange?.call(item?.value);
      _currentValue = item;
      if (item == null) {
        _controller.clear();
      } else {
        _controller.text = item.label;
      }
    });
  }
}
