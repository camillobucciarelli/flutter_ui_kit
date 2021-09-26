import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../theme/core_theme.dart';

class ReactiveAlphanumericField<T> extends StatefulWidget {
  final FormControl<T>? formControl;
  final ValidationMessagesFunction<T>? validationMessages;
  final ControlValueAccessor<T, String>? valueAccessor;
  final ShowErrorsFunction? showErrors;
  final String? formControlName;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final bool enableSuggestions;
  final bool autocorrect;
  final int minLines;
  final int maxLines;
  final bool enableInteractiveSelection;
  final bool enabled;
  final bool obscureText;
  final bool readOnly;
  final bool enableTrailingActions;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool showCursor;
  final Widget? trailingAction;
  final VoidCallback? onSubmitted;

  const ReactiveAlphanumericField({
    Key? key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.onTap,
    this.trailingAction,
    this.textInputAction,
    this.inputFormatters,
    this.formControl,
    this.validationMessages,
    this.valueAccessor,
    this.showErrors,
    this.formControlName,
    this.onSubmitted,
    this.minLines = 1,
    this.maxLines = 1,
    this.enabled = true,
    this.readOnly = false,
    this.showCursor = true,
    this.autocorrect = true,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.enableTrailingActions = true,
    this.enableInteractiveSelection = true,
    this.keyboardType = TextInputType.text,
  })  : assert((formControlName != null && formControl == null) || (formControlName == null && formControl != null)),
        assert(obscureText == true && maxLines == 1 || obscureText == false),
        assert(minLines <= maxLines),
        assert(trailingAction != null && !enableTrailingActions || trailingAction == null),
        super(key: key);

  @override
  _ReactiveAlphanumericFieldState<T> createState() => _ReactiveAlphanumericFieldState<T>();
}

class _ReactiveAlphanumericFieldState<T> extends State<ReactiveAlphanumericField<T>> {
  StreamSubscription? _focusListener;
  StreamSubscription? _valueListener;
  _SuffixIconTypes? _suffixIconType;
  Icon? _prefixIcon;
  bool _hasInteractedByUser = false;
  bool _obscureText = false;
  bool _hasFocus = true;

  FormControl<T> get _formControl {
    if (widget.formControl != null) {
      return widget.formControl!;
    }

    final parent = ReactiveForm.of(context, listen: false);
    if (parent == null || parent is! FormControlCollection) {
      throw FormControlParentNotFoundException(widget);
    }

    final collection = parent as FormControlCollection;
    final control = collection.control(widget.formControlName!);
    if (control is! FormControl<T>) {
      throw BindingCastException<T, String>(ReactiveTextField(), control);
    }

    return control;
  }

  bool get _showClearSuffix => _hasFocus && _formControl.value != null && widget.enableTrailingActions && !widget.obscureText;

  bool get _hideClearSuffix => !_hasFocus || _formControl.value == null;

  bool get _showErrorSuffix => !_hasFocus && _formControl.invalid && _hasInteractedByUser;

  bool get _hideErrorSuffix => _formControl.valid;

  bool get _showObscureTextSuffix => _hasFocus && widget.obscureText && widget.enableTrailingActions;

  bool get _hideObscureTextSuffix => !_hasFocus;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.prefixIcon != null) {
      _prefixIcon = Icon(widget.prefixIcon, color: ThemeColors.of(context).textColorLighter);
    }
    _focusListener = _formControl.focusChanges.listen(_changesListener);
    _valueListener = _formControl.valueChanges.listen((_) => _changesListener(true));
  }

  @override
  void dispose() {
    super.dispose();
    _focusListener?.cancel();
    _valueListener?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControl: widget.formControl,
      formControlName: widget.formControlName,
      validationMessages: widget.validationMessages,
      valueAccessor: widget.valueAccessor,
      showErrors: widget.showErrors,
      keyboardType: widget.keyboardType,
      onTap: widget.onTap,
      obscureText: _obscureText,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      readOnly: widget.readOnly,
      inputFormatters: widget.inputFormatters,
      showCursor: widget.showCursor,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: _prefixIcon,
        hintText: widget.hintText,
        suffixIcon: widget.trailingAction ?? _suffixIconType?.getSuffixIcon(this),
      ),
    );
  }

  //region Change and Focus listeners
  void _changesListener(bool hasFocus) {
    setState(() => _hasInteractedByUser = true);
    if (_hasFocus != hasFocus) {
      setState(() => _hasFocus = hasFocus);
    }
    if (_showClearSuffix) {
      setState(() => _suffixIconType = _SuffixIconTypes.clear);
      return;
    }
    if (_showObscureTextSuffix && _obscureText) {
      setState(() => _suffixIconType = _SuffixIconTypes.showText);
      return;
    }
    if (_showObscureTextSuffix && !_obscureText) {
      setState(() => _suffixIconType = _SuffixIconTypes.obscureText);
      return;
    }
    if (_showErrorSuffix) {
      setState(() => _suffixIconType = _SuffixIconTypes.error);
      return;
    }
    if (_hideClearSuffix && _suffixIconType == _SuffixIconTypes.clear ||
        _hideErrorSuffix && _suffixIconType == _SuffixIconTypes.error ||
        _hideObscureTextSuffix && (_suffixIconType == _SuffixIconTypes.obscureText || _suffixIconType == _SuffixIconTypes.showText)) {
      _hideSuffixIcon();
    }
  }

  //endregion

  void _hideSuffixIcon() {
    setState(() {
      _suffixIconType = null;
    });
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      _suffixIconType = _obscureText ? _SuffixIconTypes.showText : _SuffixIconTypes.obscureText;
    });
  }
}

enum _SuffixIconTypes { clear, error, obscureText, showText }

extension on _SuffixIconTypes {
  Widget? getSuffixIcon(_ReactiveAlphanumericFieldState state) => {
        _SuffixIconTypes.clear: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.cancel, color: ThemeColors.of(state.context).secondary),
            onPressed: () {
              state._formControl.patchValue(null);
            }),
        _SuffixIconTypes.error: const Icon(Icons.error_rounded, color: CoreColors.red),
        _SuffixIconTypes.obscureText: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.visibility_rounded, color: ThemeColors.of(state.context).secondary),
          onPressed: () {
            state._toggleObscureText();
          },
        ),
        _SuffixIconTypes.showText: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.visibility_off_rounded, color: ThemeColors.of(state.context).secondary),
          onPressed: () {
            state._toggleObscureText();
          },
        )
      }[this];
}
