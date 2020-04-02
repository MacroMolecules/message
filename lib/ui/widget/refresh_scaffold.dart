import 'package:flutter/material.dart';
import 'package:message/ui/widget/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 加载
typedef void OnLoadMore(bool up);
// 在在刷新时回调
typedef OnRefreshCallback = Future<void> Function({bool isReload});

// 刷新脚手架
class RefreshScaffold extends StatefulWidget {
  RefreshScaffold(
      {Key key,
      this.labelId,
      this.loadStatus,
      @required this.controller,
      this.enablePullUp: true,
      this.onRefresh,
      this.onLoadMore,
      this.child,
      this.itemCount,
      this.itemBuilder})
      : super(key: key);

  final String labelId;
  final int loadStatus;
  final RefreshController controller;
  final bool enablePullUp;
  final OnRefreshCallback onRefresh;
  final OnLoadMore onLoadMore;
  final Widget child;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  State<StatefulWidget> createState() {
    return RefreshScaffoldState();
  }
}

// 自动激活客户端
class RefreshScaffoldState extends State<RefreshScaffold>
    with AutomaticKeepAliveClientMixin {
  bool isShowFloatBtn = false;

  @override
  void initState() {
    super.initState();
    // 添加后帧回调
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 添加监听器
      widget.controller.scrollController.addListener(() {
        int offset = widget.controller.scrollController.offset.toInt();
        if (offset < 480 && isShowFloatBtn) {
          isShowFloatBtn = false;
          setState(() {});
        } else if (offset > 480 && !isShowFloatBtn) {
          isShowFloatBtn = true;
          setState(() {});
        }
      });
    });
  }

  // 浮动操作按钮
  Widget buildFloatingActionButton() {
    if (widget.controller.scrollController == null ||
        widget.controller.scrollController.offset < 480) {
      return null;
    }

    return FloatingActionButton(
      // 系统默认会给所有FAB使用同一个tag
      heroTag: widget.labelId,
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        Icons.keyboard_arrow_up,
      ),
      onPressed: () {
        widget.controller.scrollController.animateTo(
          0.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          RefreshIndicator(
            child: SmartRefresher(
              controller: widget.controller,
              // 下拉刷新
              enablePullDown: false,
              // 上拉加载
              enablePullUp: widget.enablePullUp,
              // 滚动
              enableOverScroll: false,
              // 下拉刷新的回调
              onRefresh: widget.onLoadMore,
              child: widget.child ??
                  ListView.builder(
                    itemCount: widget.itemCount,
                    itemBuilder: widget.itemBuilder,
                  ),
            ),
            // 下拉刷新的回调
            onRefresh: widget.onRefresh,
          ),
          StatusViews(
            widget.loadStatus,
            onTap: () {
              widget.onRefresh(isReload: true);
            },
          ),
        ],
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
