import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/blocs/com_list_bloc.dart';
import 'package:message/blocs/recommend_bloc.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/ui/widget/com_list_page.dart';
import 'package:message/ui/widget/widgets.dart';
import 'package:rxdart/rxdart.dart';

// 推荐项目页面
class RecommendPage extends StatefulWidget {
  RecommendPage({
    Key key,
    this.labelId,
    this.title,
    this.titleId,
    this.treeModel,
  }) : super(key: key);

  final String labelId;
  final String title;
  final String titleId;
  final TreeModel treeModel;

  @override
  State<StatefulWidget> createState() {
    return RecommendPageState();
  }
}

class RecommendPageState extends State<RecommendPage> {
  List<BlocProvider<ComListBloc>> _children = List();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 推荐项目bloc
    RecommendBloc bloc = BlocProvider.of<RecommendBloc>(context);
    // 结合系统数据
    bloc.bindSystemData(widget.treeModel);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          widget.title ?? IntlUtil.getString(context, widget.titleId),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        // 推荐树流
        stream: bloc.tabTreeStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<TreeModel>> snapshot) {
          if (snapshot.data == null) {
            Observable.just(1).delay(Duration(milliseconds: 500)).listen(
              (_) {
                bloc.getData(labelId: widget.labelId);
              },
            );
            return ProgressView();
          }
          _children = snapshot.data
              .map((TreeModel model) {
                return BlocProvider<ComListBloc>(
                  child: ComListPage(
                    labelId: widget.labelId,
                    cid: model.id,
                  ),
                  bloc: ComListBloc(),
                );
              })
              .cast<BlocProvider<ComListBloc>>()
              .toList();
              // 默认选项卡控制器
          return DefaultTabController(
            length: snapshot.data == null ? 0 : snapshot.data.length,
            child: Column(
              children: <Widget>[
                Material(
                  color: Theme.of(context).primaryColor,
                  child: SizedBox(
                    height: 48.0,
                    width: double.infinity,
                    child: TabBar(
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: snapshot.data
                          ?.map((TreeModel model) => Tab(text: model.name))
                          ?.toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(children: _children),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    for (int i = 0, length = _children.length; i < length; i++) {
      _children[i].bloc.dispose();
    }
    super.dispose();
  }
}
