import 'package:flutter/services.dart';

class MaskTextFormatter extends TextInputFormatter {
  final String mask;

  MaskTextFormatter({required this.mask});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    if (oldValue.text.length == mask.length) {
      return oldValue;
    }

    final resultText = _mask(newValue.text);
    return newValue.copyWith(text: resultText, selection: updateCursorPosition(resultText));
  }

  String _mask(String value) {
    if (mask[value.length - 1] != '#' && value.substring(value.length - 1) != mask[value.length - 1]) {
      value = '${value.substring(0, value.length - 1)}${mask[value.length - 1]}${value.substring(value.length - 1)}';
    }
    return value;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
