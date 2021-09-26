import 'package:flutter/material.dart';
import '../flutter_core_ui_kit.dart';
import 'indicator_item.dart';

class PageViewIndicator extends StatefulWidget {
  final double indicatorHeight;
  final double indicatorSpacing;
  final Duration animationDuration;
  final int pagesCount;
  final PageController pageController;
  final bool single;

  const PageViewIndicator({
    Key? key,
    required this.pageController,
    required this.pagesCount,
    this.indicatorHeight = Dimens.spacingXS,
    this.indicatorSpacing = Dimens.spacingXXS,
    this.animationDuration = Durations.buttonTap,
    this.single = false,
  }) : super(key: key);

  @override
  _PageViewIndicatorState createState() => _PageViewIndicatorState();
}

class _PageViewIndicatorState extends State<PageViewIndicator> {
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = widget.pageController.initialPage;
    widget.pageController.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.pageController.removeListener(_listener);
  }

  void _listener() {
    setState(() {
      currentPage = widget.pageController.page?.round() ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.pagesCount, (index) => _indicator(context, index)).addHorizontalSpacer(widget.indicatorSpacing),
    );
  }

  Expanded _indicator(BuildContext context, int index) {
    return Expanded(
      child: IndicatorItem(
        height: widget.indicatorHeight,
        animationDuration: widget.animationDuration,
        active: widget.single ? index == currentPage : index <= currentPage,
      ),
    );
  }
}
