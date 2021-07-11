import 'package:flutter/widgets.dart';
import 'package:loadmore/loadmore.dart';

typedef ListViewItemBuilder<ItemType> = Widget Function(ItemType);

typedef OnLoadMore<ItemType> = Future<bool> Function(ItemType);

class AppLoadMoreDelegate extends LoadMoreDelegate {

  final MediaQueryData mediaQuery;

  AppLoadMoreDelegate(this.mediaQuery);

  @override
  double widgetHeight(LoadMoreStatus status) => mediaQuery.size.height * .1;

  @override
  Widget buildChild(LoadMoreStatus status, {builder = DefaultLoadMoreTextBuilder.chinese}) => Container();

}
