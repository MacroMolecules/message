import 'package:flutter/material.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/blocs/main_bloc.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/ui/widget/refresh_scaffold.dart';
import 'package:message/ui/widget/tree_item.dart';
import 'package:message/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

bool isSystemInit = true;

// 体系
class SystemPage extends StatelessWidget {
  SystemPage({
    Key key,
    this.labelId,
  }) : super(key: key);

  final String labelId;

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = RefreshController();
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);

    if (isSystemInit) {
      isSystemInit = false;
      Observable.just(1).delay(Duration(milliseconds: 500)).listen((_) {
        bloc.onRefresh(labelId: labelId);
      });
    }

    return StreamBuilder(
      stream: bloc.treeStream,
      builder: (BuildContext context, AsyncSnapshot<List<TreeModel>> snapshot) {
        return RefreshScaffold(
          labelId: labelId,
          loadStatus: Utils.getLoadStatus(snapshot.hasError, snapshot.data),
          controller: _controller,
          enablePullUp: false,
          onRefresh: ({bool isReload}) {
            return bloc.onRefresh(labelId: labelId, isReload: isReload);
          },
          onLoadMore: (up) {},
          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            TreeModel model = snapshot.data[index];
            return TreeItem(model);
          },
        );
      },
    );
  }
}
