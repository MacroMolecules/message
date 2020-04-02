import 'package:base_library/base_library.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/blocs/collect_bloc.dart';
import 'package:message/blocs/main_bloc.dart';
import 'package:message/common/common.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/ui/widget/article_item.dart';
import 'package:message/ui/widget/project_item.dart';
import 'package:message/ui/widget/refresh_scaffold.dart';
import 'package:message/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 收藏页面
class CollectPage extends StatelessWidget {
  CollectPage({
    Key key,
    this.labelId,
  }) : super(key: key);

  final String labelId;

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = RefreshController();
    CollectBloc bloc = BlocProvider.of<CollectBloc>(context);
    MainBloc mainBloc = BlocProvider.of<MainBloc>(context);
    mainBloc.homeEventStream.listen((event) {
      if (labelId == event.labelId) {
        _controller.sendBack(false, event.status);
      }
    });
    bloc.setHomeEventSink(mainBloc.homeEventSink);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(IntlUtil.getString(context, labelId)),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: bloc.collectListStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<ProjectModel>> snapshot) {
            int loadStatus =
                Utils.getLoadStatus(snapshot.hasError, snapshot.data);
            if (loadStatus == LoadStatus.loading) {
              bloc.onRefresh(labelId: labelId);
            }
            return RefreshScaffold(
              labelId: labelId,
              loadStatus: loadStatus,
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
                return ObjectUtil.isEmpty(model.envelopePic)
                    ? ArticleItem(model, labelId: labelId)
                    : ProjectItem(model, labelId: labelId);
              },
            );
          }),
    );
  }
}
