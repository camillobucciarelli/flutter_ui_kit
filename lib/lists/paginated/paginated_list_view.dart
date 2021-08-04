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
  final Widget? header;
  final Widget? headerPadding;

  const PaginatedListView({
    required this.items,
    required this.loadMore,
    required this.totalCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    this.header,
    this.headerPadding,
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
        itemCount: itemsLength,
        itemBuilder: (_, position) {
          if (position == 0 && header != null) {
            return header!;
          }
          return itemBuilder(items[header == null ? position : position - 1]);
        },
        separatorBuilder: (context, index) {
          if (index == 0 && header != null) {
            return headerPadding ?? separatorBuilder(context, index);
          }
          return separatorBuilder(context, index);
        },
      ),
    );
  }

  int get itemsLength => header == null ? items.length : items.length + 1;
}
