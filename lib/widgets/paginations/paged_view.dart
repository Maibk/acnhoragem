

import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../core/model_classes/page_model.dart';

abstract class PagedView<T> extends StatefulWidget {
  final PageModel<T>? initialItems;
  //final void Function(List? items)? onDispose;
  final void Function(PageModel items)? onDispose;
  final Future<PageModel<T>?> Function(int page) onFetchPage;
  // final bool initialCall;
  final Widget Function(int ind, dynamic item) itemBuilder;
  final EdgeInsetsGeometry padding;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final PagingController<int, T>? pagingController;
  final Widget? initialLoader,notFoundWidget;
  const PagedView({
    Key? key,
    required this.itemBuilder,
    this.shrinkWrap = false,this.initialLoader,this.notFoundWidget,
    this.physics = const AlwaysScrollableScrollPhysics(),
    required this.onFetchPage,
    this.onDispose,
    this.padding = EdgeInsets.zero,this.pagingController,
    this.initialItems, //this.initialCall=true,
  }) : super(key: key);

  @override
  PagedViewState<T> createState();
}

abstract class PagedViewState<T> extends State<PagedView> {
  late PagingController<int, T> _pagingController;
  late int _page;
  late bool _lastLoaded;

  PagingController<int, T> get pagingController => _pagingController;


  @override
  void initState() {
    _page = widget.initialItems?.current_page ?? 1;
    _lastLoaded=widget.initialItems?.lastLoaded??false;
    _pagingController = PagingController(firstPageKey: _page);
    _pagingController.itemList = widget.initialItems?.data as List<T>?;
    _pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.onDispose?.call(PageModel<T>(
        data: _pagingController.itemList?.toList(), current_page: _page,lastLoaded: _lastLoaded));
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      if(!_lastLoaded) {
        final PageModel<T>? model = await widget.onFetchPage(_page) as PageModel<T>?;
        if (model != null) {
          if (_page == 1) {
            _pagingController.itemList?.clear();
          }
          final bool isNotLastPage = _page < model.total_page;
          print("last page: ${!isNotLastPage}");
          // final bool isNotLastPage = _page+1 <= model.total_page;
          if (!isNotLastPage) {
            // page is last
            _pagingController.appendLastPage(model.data!);
            _lastLoaded=true;
          } else {
            _page++;
            _pagingController.appendPage(model.data!, _page);
          }
          // _page++;
        }
      }else{
        _pagingController.appendLastPage([]);
      }
    } catch (error) {
      //  _pagingController.error = error;
    }
  }

  void clearSaveList(
      void Function(PageModel<T> model) onOldPage, {
        PageModel<T>? newPage,
      }) {
    onOldPage.call(
        PageModel<T>(data: _pagingController.itemList, current_page: _page,lastLoaded: _lastLoaded));
    _page = newPage?.current_page ?? 1;
    _pagingController.itemList = newPage?.data;
  }

  void refresh() {
    _page = 1;
    _lastLoaded=false;
    if (_pagingController.itemList == null) {
      _pagingController.notifyPageRequestListeners(_page);
    } else {
      _pagingController.refresh();
    }
  }
}