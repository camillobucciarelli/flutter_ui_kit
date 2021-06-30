import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';

class AlphanumericFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
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

  const AlphanumericFormField({
    Key? key,
    this.hintText,
    this.labelText,
    this.validator,
    this.onChanged,
    this.controller,
    this.initialValue,
    this.prefixIcon,
    this.onTap,
    this.trailingAction,
    this.textInputAction,
    this.inputFormatters,
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
  })  : assert(initialValue == null || controller == null),
        assert(obscureText == true && maxLines == 1 || obscureText == false),
        assert(minLines <= maxLines),
        assert(trailingAction != null && !enableTrailingActions || trailingAction == null),
        super(key: key);

  @override
  _AlphanumericFormFieldState createState() => _AlphanumericFormFieldState();
}

class _AlphanumericFormFieldState extends State<AlphanumericFormField> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;
  _SuffixIconTypes? _suffixIconType;
  Icon? _prefixIcon;
  bool _hasInteractedByUser = false;
  bool _obscureText = false;

  bool get _showClearSuffix => _focusNode.hasFocus && _controller.text.isNotEmpty && widget.enableTrailingActions && !widget.obscureText;

  bool get _hideClearSuffix => !_focusNode.hasFocus || _controller.text.isEmpty;

  bool get _showErrorSuffix => _focusNode.hasFocus && widget.validator?.call(_controller.text) != null && _hasInteractedByUser;

  bool get _hideErrorSuffix => widget.validator?.call(_controller.text) == null;

  bool get _showObscureTextSuffix => _focusNode.hasFocus && widget.obscureText && widget.enableTrailingActions;

  bool get _hideObscureTextSuffix => !_focusNode.hasFocus;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    _obscureText = widget.obscureText;
    _focusNode.addListener(_focusListener);
    _controller.addListener(_onChangeListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.prefixIcon != null) {
      _prefixIcon = Icon(widget.prefixIcon, color: ThemeColors.of(context).textColorLighter);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_focusListener);
    if (widget.controller == null) {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: _focusNode,
      controller: _controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      onTap: widget.onTap,
      enabled: widget.enabled,
      obscureText: _obscureText,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      onChanged: (value) => _hasInteractedByUser = true,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      readOnly: widget.readOnly,
      inputFormatters: widget.inputFormatters,
      showCursor: widget.showCursor,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: _prefixIcon,
        hintText: widget.hintText,
        suffixIcon: widget.trailingAction ?? _suffixIconType?.getSuffixIcon(this),
      ),
    );
  }

  //region Change and Focus listeners
  void _onChangeListener() {
    widget.onChanged?.call(_controller.text);
    _focusListener();
  }

  void _focusListener() {
    if (_showClearSuffix) {
      setState(() => _suffixIconType = _SuffixIconTypes.clear);
      return;
    }
    if (_showErrorSuffix) {
      setState(() => _suffixIconType = _SuffixIconTypes.error);
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
  Widget? getSuffixIcon(_AlphanumericFormFieldState state) => {
        _SuffixIconTypes.clear: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.cancel, color: ThemeColors.of(state.context).accent),
            onPressed: () {
              state._controller.clear();
              state.widget.onChanged?.call('');
            }),
        _SuffixIconTypes.error: const Icon(Icons.error_rounded, color: CoreColors.red),
        _SuffixIconTypes.obscureText: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.visibility_rounded, color: ThemeColors.of(state.context).accent),
          onPressed: () {
            state._toggleObscureText();
          },
        ),
        _SuffixIconTypes.showText: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.visibility_off_rounded, color: ThemeColors.of(state.context).accent),
          onPressed: () {
            state._toggleObscureText();
          },
        )
      }[this];
}
