import 'package:anchorageislamabad/widgets/paginations/paged_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../core/utils/image_constant.dart';
import '../NoRecordFound.dart';
import '../loader.dart';

class PaginatedGridView<T> extends PagedView<T> {

  final double mainAxisSpacing,crossAxisSpacing,mainAxisExtent;
  final double childAspectRatio;
  final int crossAxisCount;

  //final List? initialItems;
  //final void Function(List? items)? onDispose;
  const PaginatedGridView({Key? key,required super.itemBuilder,
    required super.onFetchPage,
    required this.childAspectRatio,
    super.shrinkWrap=false,
    this.mainAxisSpacing=0,
    this.crossAxisSpacing=0,
    super.onDispose,this.mainAxisExtent=0,
    super.initialItems,
    super.notFoundWidget,
    super.initialLoader,
    super.physics=const AlwaysScrollableScrollPhysics(),
    super.padding=EdgeInsets.zero,required this.crossAxisCount}) : super(key: key);

  @override
  _PaginatedGridViewState<T> createState() => _PaginatedGridViewState<T>();
}

class _PaginatedGridViewState<T> extends PagedViewState<T> {


  @override
  PaginatedGridView get widget => super.widget as PaginatedGridView;

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, T>(
      pagingController: pagingController,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,physics: widget.physics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,mainAxisExtent: widget.mainAxisExtent,
          mainAxisSpacing: widget.mainAxisSpacing,crossAxisSpacing: widget.crossAxisSpacing,
          childAspectRatio: widget.childAspectRatio),

      builderDelegate: PagedChildBuilderDelegate<T>(
          firstPageProgressIndicatorBuilder: (con){
            return widget.initialLoader??const CircularLoader();
          },
          noItemsFoundIndicatorBuilder: (con){
            return widget.notFoundWidget??
                NoRecordFound("no Data", ImageConstant.selected );
          },
          itemBuilder: (context, dynamic item, index){
            return widget.itemBuilder(index,item);
          }
      ),
    );
  }


}