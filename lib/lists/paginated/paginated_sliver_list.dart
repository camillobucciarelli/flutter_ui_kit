import 'package:flutter/material.dart';
import 'load_more_delegate.dart';
import 'package:loadmore/loadmore.dart';

class PaginatedSliverList<ItemType> extends StatelessWidget {
  final List<ItemType> items;
  final int totalCount;
  final ListViewItemBuilder<ItemType> itemBuilder;
  final OnLoadMore<ItemType> loadMore;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  const PaginatedSliverList({
    Key? key,
    required this.items,
    required this.totalCount,
    required this.itemBuilder,
    required this.loadMore,
    this.padding,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadMore(
      isFinish: items.length == totalCount,
      onLoadMore: () => loadMore(items.last),
      delegate: AppLoadMoreDelegate(MediaQuery.of(context)),
      child: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, position) => itemBuilder(items[position]),
          childCount: items.length,
        ),
      ),
    );
  }
}
