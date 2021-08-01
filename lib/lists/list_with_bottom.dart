import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/flutter_core_ui_kit.dart';

class ListWithBottom extends StatelessWidget {
  final List<Widget> children;
  final Widget bottom;
  final double bottomSpacing;

  const ListWithBottom({required this.children, required this.bottom, this.bottomSpacing = Dimens.SPACING_XXL});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
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
    );
  }
}
