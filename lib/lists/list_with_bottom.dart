import 'package:flutter/material.dart';
import '../flutter_core_ui_kit.dart';

class ListWithBottom extends StatelessWidget {
  final List<Widget> children;
  final Widget bottom;
  final double bottomSpacing;
  final ScrollPhysics physics;
  final EdgeInsets? padding;

  const ListWithBottom({
    Key? key,
    required this.children,
    required this.bottom,
    this.bottomSpacing = Dimens.spacingXXL,
    this.physics = const BouncingScrollPhysics(),
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? MediaQuery.of(context).viewPadding,
      child: CustomScrollView(
        physics: physics,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              ...children,
              SizedBox(height: bottomSpacing),
            ]),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: false,
            child: bottom,
          )
        ],
      ),
    );
  }
}
