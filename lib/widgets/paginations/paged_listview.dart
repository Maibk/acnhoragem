

import 'package:anchorageislamabad/widgets/paginations/paged_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../core/utils/image_constant.dart';
import '../NoRecordFound.dart';
import '../loader.dart';

class PaginatedListView<T> extends PagedView<T> {

  final Widget Function(BuildContext context,int ind,)
  separatorBuilder;

  const PaginatedListView({
    Key? key,
    required super.itemBuilder,
    required super.onFetchPage,
    required this.separatorBuilder,
    super.pagingController,
    super.shrinkWrap = false,
    super.onDispose,
    super.initialItems,
    super.physics = const AlwaysScrollableScrollPhysics(),
    super.padding = EdgeInsets.zero,
    super.initialLoader,super.notFoundWidget,
  }) : super(key: key);

  @override
  _PagedListViewState<T> createState() => _PagedListViewState<T>();
}

class _PagedListViewState<T> extends PagedViewState<T> {

  @override
  PaginatedListView get widget => super.widget as PaginatedListView;

  @override
  Widget build(BuildContext context) {
    return PagedListView.separated(
      pagingController: pagingController,
      separatorBuilder: widget.separatorBuilder,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      builderDelegate: PagedChildBuilderDelegate<T>(
          firstPageProgressIndicatorBuilder: (con) {
            return widget.initialLoader??const CircularLoader();
          }, noItemsFoundIndicatorBuilder: (con) {
        return widget.notFoundWidget?? NoRecordFound("no Data", ImageConstant.selected );
      }, itemBuilder: (context, dynamic item, index) {
        return widget.itemBuilder(index, item);
      },
          newPageProgressIndicatorBuilder: (con){
            return const CircularLoader();
          }
      ),
    );
  }
}