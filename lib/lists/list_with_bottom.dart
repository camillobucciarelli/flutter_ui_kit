import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/flutter_core_ui_kit.dart';

class ListWithBottom extends StatelessWidget {
  final List<Widget> children;
  final Widget bottom;

  const ListWithBottom({required this.children, required this.bottom});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            ...children,
            const SizedBox(height: Dimens.SPACING_XXL),
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
