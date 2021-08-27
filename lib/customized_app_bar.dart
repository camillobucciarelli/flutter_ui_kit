import 'dart:math' as math;

import 'package:flutter_core_ui_kit/adaptive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/flutter_core_ui_kit.dart';
import 'package:flutter_core_ui_kit/theme/core_theme.dart';

import 'buttons/button.dart';

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
    this.title,
    this.titleWidget,
    this.centerTitle = true,
    this.leading,
    this.actions,
    this.scrollController,
    this.fadeHeight = 0,
    this.appBarHeight = Dimens.APP_BAR_HEIGHT,
  });

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
  Size get preferredSize => const Size.fromHeight(Dimens.APP_BAR_HEIGHT);
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
            leadingWidth: Dimens.SPACING_M * 2 + Dimens.ICON_BUTTON_SIZE,
            leading: widget.leading ?? CustomizedAppBar.leadingButton(context),
            elevation: 0,
            toolbarHeight: widget.appBarHeight,
            actions: [...widget.actions ?? [], const SizedBox(width: Dimens.SPACING_M)],
          ),
        ),
      ),
    );
  }

  Widget get _title {
    Widget _titleWidget() {
      if(widget.title != null) {
        return Text(
          widget.title!,
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
