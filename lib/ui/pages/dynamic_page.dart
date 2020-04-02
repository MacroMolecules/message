import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/blocs/main_bloc.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/ui/widget/article_item.dart';
import 'package:message/ui/widget/refresh_scaffold.dart';
import 'package:message/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

bool isDynamicInit = true;

// 动态页面
class DynamicPage extends StatelessWidget {
  DynamicPage({
    Key key,
    this.labelId,
  }) : super(key: key);

  final String labelId;

  @override
  Widget build(BuildContext context) {
    // 刷新控制
    RefreshController _controller = RefreshController();
    // 提供bloc
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    // 控制流 发送状态
    bloc.homeEventStream.listen((event) {
      if (labelId == event.labelId) {
        _controller.sendBack(false, event.status);
      }
    });

    if (isDynamicInit) {
      isDynamicInit = false;
      // 延迟刷新持续时间
      Observable.just(1).delay(Duration(milliseconds: 500)).listen((_) {
        bloc.onRefresh(labelId: labelId);
      });
    }

    return StreamBuilder(
      stream: bloc.dynamicStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProjectModel>> snapshot) {
        // 刷新脚手架
        return RefreshScaffold(
          labelId: labelId,
          // 负载状态
          loadStatus: Utils.getLoadStatus(snapshot.hasError, snapshot.data),
          controller: _controller,
          onRefresh: ({bool isReload}) {
            return bloc.onRefresh(labelId: labelId, isReload: isReload);
          },
          onLoadMore: (up) {
            bloc.onLoadMore(labelId: labelId);
          },
          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            ProjectModel model = snapshot.data[index];
            return ArticleItem(model);
          },
        );
      },
    );
  }
}