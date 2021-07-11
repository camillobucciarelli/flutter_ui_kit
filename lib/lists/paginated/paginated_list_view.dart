import 'package:flutter/material.dart';
import 'package:flutter_core_ui_kit/lists/paginated/load_more_delegate.dart';
import 'package:loadmore/loadmore.dart';

class PaginatedListView<ItemType> extends StatelessWidget {
  final List<ItemType> items;
  final int totalCount;
  final ListViewItemBuilder<ItemType> itemBuilder;
  final IndexedWidgetBuilder separatorBuilder;
  final OnLoadMore<ItemType> loadMore;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  const PaginatedListView({
    required this.items,
    required this.loadMore,
    required this.totalCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    this.padding,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return LoadMore(
      isFinish: items.length == totalCount,
      onLoadMore: () => loadMore(items.last),
      delegate: AppLoadMoreDelegate(MediaQuery.of(context)),
      child: ListView.separated(
          padding: padding,
          physics: physics,
          itemBuilder: (_, position) => items.length - 1 >= position ? itemBuilder(items[position]) : const SizedBox(),
          separatorBuilder: separatorBuilder,
          itemCount: items.length),
    );
  }
}
