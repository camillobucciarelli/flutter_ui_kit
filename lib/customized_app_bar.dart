import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'adaptive_container.dart';
import 'buttons/button.dart';
import 'flutter_core_ui_kit.dart';
import 'theme/core_theme.dart';

class CustomizedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final double fadeHeight;
  final double appBarHeight;
  final ScrollController? scrollController;

  const CustomizedAppBar({
    Key? key,
    this.title,
    this.titleWidget,
    this.centerTitle = true,
    this.leading,
    this.actions,
    this.scrollController,
    this.fadeHeight = 0,
    this.appBarHeight = Dimens.appBarHeight,
  }) : super(key: key);

  @override
  _CustomizedAppBarState createState() => _CustomizedAppBarState();

  static Widget? leadingButton<T extends Object?>(BuildContext context, {T? result, VoidCallback? onPressed}) {
    final parentRoute = ModalRoute.of(context);
    final canPop = parentRoute?.canPop ?? false;
    final useCloseButton = (parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog);

    if (canPop) {
      return Button.icon(
        icon: useCloseButton ? Icons.close_rounded : Icons.arrow_back_ios_rounded,
        onPressed: onPressed ?? () => CoreUIKit.genericBackAction(context, result),
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(Dimens.appBarHeight);
}

class _CustomizedAppBarState extends State<CustomizedAppBar> {
  double _titleOpacity = .0;

  @override
  void initState() {
    widget.scrollController?.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    setState(() => _titleOpacity = math.max(0, math.min(1, (widget.scrollController?.offset ?? 1) / widget.fadeHeight)));
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveContainer(
      child: ClipRect(
        child: BackdropFilter(
          filter: Dimens.blurredFilter,
          child: AppBar(
            title: _title,
            centerTitle: widget.centerTitle,
            leadingWidth: Dimens.spacingM * 2 + Dimens.iconButtonSize,
            leading: widget.leading ?? CustomizedAppBar.leadingButton(context),
            elevation: 0,
            toolbarHeight: widget.appBarHeight,
            actions: [...widget.actions ?? [], const SizedBox(width: Dimens.spacingM)],
          ),
        ),
      ),
    );
  }

  Widget get _title {
    Widget _titleWidget() {
      if (widget.titleWidget == null) {
        return Text(
          widget.title ?? '',
          style: Theme.of(context).textTheme.appBar,
        );
      }
      return widget.titleWidget!;
    }

    if (widget.fadeHeight == 0) {
      return _titleWidget();
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 16),
      opacity: _titleOpacity,
      child: _titleWidget(),
    );
  }
}
