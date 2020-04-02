import 'dart:collection';

import 'package:base_library/base_library.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/blocs/event.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/data/repository/collect_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

// 收藏bloc
class CollectBloc implements BlocBase {
  // 缓存最新一次收藏事件的广播流控制器
  BehaviorSubject<List<ProjectModel>> _collectListBs =
      BehaviorSubject<List<ProjectModel>>();

  // 通过 sink 传输 收藏列表
  Sink<List<ProjectModel>> get _collectListSink => _collectListBs.sink;

  // 收藏列表bloc流
  Stream<List<ProjectModel>> get collectListStream =>
      _collectListBs.stream.asBroadcastStream();

  List<ProjectModel> _collectList;
  int _collectPage = 0;

  // 收藏库
  CollectRepository _collectRepository = CollectRepository();

  // 获取数据返回收藏列表
  @override
  Future getData({String labelId, int page}) {
    return getCollectList(labelId, page);
  }

  @override
  Future onLoadMore({String labelId}) {
    int _page = ++_collectPage;
    return getData(labelId: labelId, page: _page);
  }

  @override
  Future onRefresh({String labelId, bool isReload}) {
    _collectPage = 0;
    if (isReload == true) {
      _collectListSink.add(null);
    }
    return getData(labelId: labelId, page: _collectPage);
  }

  Future getCollectList(String labelId, int page) {
    return _collectRepository.getCollectList(page).then((list) {
      if (_collectList == null) {
        _collectList = List();
      }
      if (page == 0) {
        _collectList.clear();
      }
      // 添加到收藏列表
      _collectList.addAll(list);
      _collectListSink.add(UnmodifiableListView<ProjectModel>(_collectList));
      _homeEventSink?.add(StatusEvent(
          labelId,
          ObjectUtil.isEmpty(list)
              ? RefreshStatus.noMore
              : RefreshStatus.idle));
    }).catchError((_) {
      if (ObjectUtil.isEmpty(_collectList)) {
        _collectListBs.sink.addError("error");
      }
      _collectPage--;
      _homeEventSink?.add(StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  Sink<StatusEvent> _homeEventSink;

  // 设置Home事件接收器
  void setHomeEventSink(Sink<StatusEvent> eventSink) {
    _homeEventSink = eventSink;
  }

  @override
  void dispose() {
    _collectListBs.close();
  }
}