import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme/core_theme.dart';

class Button extends StatefulWidget {
  final String? title;
  final IconData? icon;
  final VoidCallback? onPressed;
  final _ButtonStyle style;
  final Color? buttonColor;
  final Color? textColor;
  final bool enabled;
  final bool loading;
  final Widget? leading;
  final Widget? trailing;
  final double? size;

  const Button._(
    Key? key,
    this.title,
    this.icon,
    this.style,
    this.onPressed,
    this.loading,
    this.buttonColor,
    this.textColor,
    this.leading,
    this.trailing,
    this.enabled,
    this.size,
  ) : super(key: key);

  factory Button.filled({
    Key? key,
    required String title,
    VoidCallback? onPressed,
    Color? buttonColor,
    Color? textColor,
    bool loading = false,
    Widget? leading,
    Widget? trailing,
    bool enabled = true,
  }) =>
      Button._(key, title, null, _ButtonStyle.filled, onPressed, loading, buttonColor, textColor, leading, trailing, enabled, null);

  factory Button.icon({
    Key? key,
    required IconData icon,
    VoidCallback? onPressed,
    Color? buttonColor,
    Color? iconColor,
    bool loading = false,
    bool enabled = true,
    double size = Dimens.iconButtonSize,
  }) =>
      Button._(key, null, icon, _ButtonStyle.filled, onPressed, loading, buttonColor, iconColor, null, null, enabled, size);

  factory Button.outlined({
    Key? key,
    required String title,
    VoidCallback? onPressed,
    Color? borderColor,
    Color? textColor,
    bool loading = false,
    Widget? leading,
    Widget? trailing,
    bool enabled = true,
  }) =>
      Button._(key, title, null, _ButtonStyle.outlined, onPressed, loading, borderColor, textColor, leading, trailing, enabled, null);

  factory Button.text({
    Key? key,
    required String title,
    VoidCallback? onPressed,
    Color? textColor,
    bool loading = false,
    Widget? leading,
    Widget? trailing,
    bool enabled = true,
  }) =>
      Button._(key, title, null, _ButtonStyle.text, onPressed, loading, null, textColor, leading, trailing, enabled, null);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  final Duration _duration = Durations.buttonTap;
  var _factor = 1.0;
  var _hover = false;

  bool get _enable => widget.onPressed != null && !widget.loading && widget.enabled;

  @override
  Widget build(BuildContext context) {
    Widget button() => InkWell(
          onHover: _enable ? _onHover : null,
          onTapCancel: _enable ? _onTapCancel : null,
          onTapDown: _enable ? (_) => _onTapDown() : null,
          onTap: _enable ? _onTapUp : null,
          child: Transform.scale(
            scale: _factor,
            child: AnimatedOpacity(
              duration: _duration,
              opacity: _enable ? 1 : .3,
              child: Container(
                height: widget.size ?? Dimens.buttonHeight,
                width: widget.size,
                alignment: Alignment.center,
                decoration: widget.style.decoration(context, widget.onPressed, widget.buttonColor, hover: _hover),
                child: AnimatedSwitcher(
                  key: UniqueKey(),
                  duration: Durations.animatedSwitcher,
                  child: _child(context),
                ),
              ),
            ),
          ),
        );
    if (widget.icon != null) {
      return UnconstrainedBox(
        child: button(),
      );
    }
    return button();
  }

  Widget _child(BuildContext context) {
    if (widget.loading) {
      return const CircularProgressIndicator.adaptive();
    }
    if (widget.icon != null) {
      return FittedBox(child: Icon(widget.icon, color: widget.style.getTextStyle(context, widget.textColor, hover: _hover)?.color));
    }
    return Row(
      children: [
        if (widget.leading != null || widget.trailing != null)
          SizedBox(
            width: Dimens.buttonHeight,
            height: Dimens.buttonHeight,
            child: widget.leading,
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Dimens.spacingXS,
              horizontal: Dimens.spacingM,
            ),
            child: Text(
              widget.style.formatTitle(widget.title ?? ''),
              textAlign: TextAlign.center,
              maxLines: 2,
              style: widget.style.getTextStyle(context, widget.textColor, hover: _hover),
            ),
          ),
        ),
        if (widget.leading != null || widget.trailing != null)
          SizedBox(
            width: Dimens.buttonHeight,
            height: Dimens.buttonHeight,
            child: widget.trailing,
          ),
      ],
    );
  }

  void _onHover(bool hover) => setState(() => _hover = hover);

  void _onTapCancel() => setState(() => _factor = 1.0);

  void _onTapDown() => setState(() => _factor = .9);

  void _onTapUp() async {
    await Future.delayed(_duration);
    setState(() => _factor = 1.0);
    widget.onPressed?.call();
  }
}

enum _ButtonStyle { filled, outlined, text }

extension on _ButtonStyle {
  String formatTitle(String title) => this == _ButtonStyle.text ? title : title.toUpperCase();

  TextStyle? getTextStyle(BuildContext context, Color? textColor, {required bool hover}) => {
        _ButtonStyle.filled: Theme.of(context).elevatedButtonTheme.style?.textStyle?.resolve({MaterialState.selected})?.copyWith(
          color: textColor ?? Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({MaterialState.selected}),
        ),
        _ButtonStyle.outlined: Theme.of(context).outlinedButtonTheme.style?.textStyle?.resolve({MaterialState.selected})?.copyWith(
          color: textColor ?? Theme.of(context).outlinedButtonTheme.style?.foregroundColor?.resolve({MaterialState.selected}),
        ),
        _ButtonStyle.text: Theme.of(context).textButtonTheme.style?.textStyle?.resolve({MaterialState.selected})?.copyWith(
          color: textColor ?? Theme.of(context).outlinedButtonTheme.style?.foregroundColor?.resolve({MaterialState.selected}),
          shadows: [
            if (hover)
              Shadow(
                color: Theme.of(context).textButtonTheme.style?.shadowColor?.resolve({MaterialState.selected}) ??
                    ThemeColors.of(context).primary,
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
          ],
        )
      }[this];

  BoxDecoration? decoration(BuildContext context, VoidCallback? onPressed, Color? buttonColor, {required bool hover}) {
    BoxShadow shadow(Color shadowColor) {
      return BoxShadow(
        offset: const Offset(0, 5),
        blurRadius: 10,
        color: shadowColor,
        spreadRadius: 2,
      );
    }

    return {
      _ButtonStyle.filled: BoxDecoration(
        color: buttonColor ?? Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve({MaterialState.selected}),
        borderRadius:
            (Theme.of(context).elevatedButtonTheme.style?.shape?.resolve({MaterialState.selected}) as RoundedRectangleBorder).borderRadius,
        boxShadow: [
          if (hover)
            shadow(Theme.of(context).elevatedButtonTheme.style?.shadowColor?.resolve({MaterialState.selected}) ??
                ThemeColors.of(context).primary)
        ],
      ),
      _ButtonStyle.outlined: BoxDecoration(
        color: Colors.transparent,
        borderRadius:
            (Theme.of(context).outlinedButtonTheme.style?.shape?.resolve({MaterialState.selected}) as RoundedRectangleBorder).borderRadius,
        border: Border.all(
            color: buttonColor ??
                Theme.of(context).outlinedButtonTheme.style?.shape?.resolve({MaterialState.selected})?.side.color ??
                ThemeColors.of(context).secondary,
            style: Theme.of(context).outlinedButtonTheme.style?.shape?.resolve({MaterialState.selected})?.side.style ?? BorderStyle.solid,
            width: Theme.of(context).outlinedButtonTheme.style?.shape?.resolve({MaterialState.selected})?.side.width ?? 2.0),
        boxShadow: [
          if (hover)
            shadow(Theme.of(context).outlinedButtonTheme.style?.shadowColor?.resolve({MaterialState.selected}) ??
                ThemeColors.of(context).primary)
        ],
      ),
      _ButtonStyle.text: BoxDecoration(
        color: buttonColor ?? Theme.of(context).textButtonTheme.style?.backgroundColor?.resolve({MaterialState.selected}),
        borderRadius:
            (Theme.of(context).textButtonTheme.style?.shape?.resolve({MaterialState.selected}) as RoundedRectangleBorder).borderRadius,
      )
    }[this];
  }
}
