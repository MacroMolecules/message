import 'package:flutter/material.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/blocs/com_list_bloc.dart';
import 'package:message/common/common.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/res/strings.dart';
import 'package:message/ui/widget/article_item.dart';
import 'package:message/ui/widget/project_item.dart';
import 'package:message/ui/widget/refresh_scaffold.dart';
import 'package:message/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ComListPage extends StatelessWidget {
  ComListPage({
    Key key,
    this.labelId,
    this.cid,
  }) : super(key: key);
  final String labelId;
  final int cid;

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = RefreshController();
    final ComListBloc bloc = BlocProvider.of<ComListBloc>(context);
    bloc.comListEventStream.listen((event) {
      if (cid == event.cid) {
        _controller.sendBack(false, event.status);
      }
    });

    return StreamBuilder(
      stream: bloc.comListStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProjectModel>> snapshot) {
        int loadStatus = Utils.getLoadStatus(snapshot.hasError, snapshot.data);
        if (loadStatus == LoadStatus.loading) {
          bloc.onRefresh(labelId: labelId, cid: cid);
        }
        return RefreshScaffold(
          labelId: cid.toString(),
          loadStatus: loadStatus,
          controller: _controller,
          onRefresh: ({bool isReload}) {
            return bloc.onRefresh(labelId: labelId, cid: cid);
          },
          onLoadMore: (up) {
            bloc.onLoadMore(labelId: labelId, cid: cid);
          },
          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            ProjectModel model = snapshot.data[index];
            return labelId == Ids.titleProjectTree
                ? ProjectItem(model)
                : ArticleItem(model);
          },
        );
      },
    );
  }
}
