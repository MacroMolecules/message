import 'dart:collection';

import 'package:base_library/base_library.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/blocs/event.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/data/repository/message_repository.dart';
import 'package:message/res/strings.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class ComListBloc implements BlocBase {
  BehaviorSubject<List<ProjectModel>> _comListData =
      BehaviorSubject<List<ProjectModel>>();

  Sink<List<ProjectModel>> get _comListSink => _comListData.sink;

  Stream<List<ProjectModel>> get comListStream => _comListData.stream;

  List<ProjectModel> comList;
  int _comListPage = 0;

  BehaviorSubject<StatusEvent> _comListEvent = BehaviorSubject<StatusEvent>();

  Sink<StatusEvent> get _comListEventSink => _comListEvent.sink;

  Stream<StatusEvent> get comListEventStream =>
      _comListEvent.stream.asBroadcastStream();

  MessageRepository messageRepository = MessageRepository();

  @override
  Future getData({String labelId, int cid, int page}) {
    switch (labelId) {
      case Ids.titleProjectTree:
        return getProject(labelId, cid, page);
        break;
      case Ids.titleWxArticleTree:
        return getWxArticle(labelId, cid, page);
        break;
      case Ids.titleSystemTree:
        return getArticle(labelId, cid, page);
        break;
      default:
        return Future.delayed(Duration(seconds: 1));
        break;
    }
  }

  @override
  Future onLoadMore({String labelId, int cid}) {
    int _page = 0;
    _page = ++_comListPage;
    return getData(labelId: labelId, cid: cid, page: _page);
  }

  @override
  Future onRefresh({String labelId, int cid}) {
    switch (labelId) {
      case Ids.titleProjectTree:
        _comListPage = 1;
        break;
      case Ids.titleWxArticleTree:
        _comListPage = 1;
        break;
      case Ids.titleSystemTree:
        _comListPage = 0;
        break;
      default:
        break;
    }

    return getData(labelId: labelId, cid: cid, page: _comListPage);
  }

  Future getProject(String labelId, int cid, int page) async {
    ComReq _comReq = ComReq(cid);
    return messageRepository
        .getProjectList(page: page, data: _comReq.toJson())
        .then((list) {
      if (comList == null) comList = List();
      if (page == 1) {
        comList.clear();
      }
      comList.addAll(list);
      _comListSink.add(UnmodifiableListView<ProjectModel>(comList));
      _comListEventSink.add(StatusEvent(labelId,
          ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle,
          cid: cid));
    }).catchError((_) {
      _comListPage--;
      _comListEventSink.add(StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  Future getWxArticle(String labelId, int cid, int page) async {
    return messageRepository.getWxArticleList(id: cid, page: page).then((list) {
      if (comList == null) comList = List();
      if (page == 1) {
        comList.clear();
      }
      comList.addAll(list);
      _comListSink.add(UnmodifiableListView<ProjectModel>(comList));
      _comListEventSink.add(StatusEvent(labelId,
          ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle,
          cid: cid));
    }).catchError((_) {
      _comListPage--;
      _comListEventSink.add(StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  Future getArticle(String labelId, int cid, int page) async {
    ComReq _comReq = ComReq(cid);
    return messageRepository
        .getArticleList(page: page, data: _comReq.toJson())
        .then((list) {
      if (comList == null) comList = List();
      if (page == 0) {
        comList.clear();
      }
      comList.addAll(list);
      _comListSink.add(UnmodifiableListView<ProjectModel>(comList));
      _comListEventSink.add(StatusEvent(labelId,
          ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle,
          cid: cid));
    }).catchError((_) {
      _comListPage--;
      _comListEventSink.add(StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  @override
  void dispose() {
    _comListData.close();
    _comListEvent.close();
  }
}
