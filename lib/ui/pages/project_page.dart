import 'package:flutter/material.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/blocs/main_bloc.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/ui/widget/project_item.dart';
import 'package:message/ui/widget/refresh_scaffold.dart';
import 'package:message/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

bool isProjectInit = true;

// 项目页面
class ProjectPage extends StatelessWidget {
  ProjectPage({Key key, this.labelId,}) : super(key: key);

  final String labelId;

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = RefreshController();
    MainBloc bloc = BlocProvider.of<MainBloc>(context);
    bloc.homeEventStream.listen((event) {
      if (labelId == event.labelId) {
        _controller.sendBack(false, event.status);
      }
    });

    if (isProjectInit) {
      isProjectInit = false;
      Observable.just(1).delay(Duration(milliseconds: 500)).listen((_) {
        bloc.onRefresh(labelId: labelId);
      });
    }

    return StreamBuilder(
        stream: bloc.projectStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ProjectModel>> snapshot) {
          return RefreshScaffold(
            labelId: labelId,
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
              return ProjectItem(model);
            },
          );
        });
  }
}
