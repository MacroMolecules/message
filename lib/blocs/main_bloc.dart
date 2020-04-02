
import 'dart:collection';

import 'package:azlistview/azlistview.dart';
import 'package:base_library/base_library.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/blocs/event.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/data/repository/collect_repository.dart';
import 'package:message/data/repository/message_repository.dart';
import 'package:message/res/strings.dart';
import 'package:message/utils/http_utils.dart';
import 'package:message/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/subjects.dart';

// BLoC的通用接口
class MainBloc implements BlocBase {
  // 缓存最新一次轮播事件的广播流控制器
  BehaviorSubject<List<BannerModel>> _banner =
      BehaviorSubject<List<BannerModel>>();

  // 通过 sink 传输
  Sink<List<BannerModel>> get _bannerSink => _banner.sink;

  // 轮播Bloc流
  Stream<List<BannerModel>> get bannerStream => _banner.stream;

  // 缓存最新一次推荐事件的广播流控制器
  BehaviorSubject<List<ProjectModel>> _recProject =
      BehaviorSubject<List<ProjectModel>>();

  // 通过 sink 传输
  Sink<List<ProjectModel>> get _recProjectSink => _recProject.sink;

  // 推荐Bloc流
  Stream<List<ProjectModel>> get recProjectStream => _recProject.stream;

  // 缓存最新一次文章事件的广播流控制器
  BehaviorSubject<List<ProjectModel>> _recWxArticle =
      BehaviorSubject<List<ProjectModel>>();

  // 通过 sink 传输
  Sink<List<ProjectModel>> get _recWxArticleSink => _recWxArticle.sink;

  // 微信文章Bloc流
  Stream<List<ProjectModel>> get recWxArticleStream => _recWxArticle.stream;

  BehaviorSubject<List<ProjectModel>> _project =
      BehaviorSubject<List<ProjectModel>>();

  Sink<List<ProjectModel>> get _projectSink => _project.sink;

  Stream<List<ProjectModel>> get projectStream => _project.stream;

  List<ProjectModel> _projectList;
  int _projectPage = 0;

  // 动态页面
  BehaviorSubject<List<ProjectModel>> _dynamic =
      BehaviorSubject<List<ProjectModel>>();

  Sink<List<ProjectModel>> get _dynamicSink => _dynamic.sink;

  Stream<List<ProjectModel>> get dynamicStream => _dynamic.stream;

  List<ProjectModel> _dynamicList;
  int _dynamicPage = 0;

  BehaviorSubject<List<TreeModel>> _tree = BehaviorSubject<List<TreeModel>>();

  Sink<List<TreeModel>> get _treeSink => _tree.sink;

  Stream<List<TreeModel>> get treeStream => _tree.stream;

  List<TreeModel> _treeList;

  BehaviorSubject<StatusEvent> _homeEvent = BehaviorSubject<StatusEvent>();

  Sink<StatusEvent> get homeEventSink => _homeEvent.sink;

  Stream<StatusEvent> get homeEventStream =>
      _homeEvent.stream.asBroadcastStream();

  BehaviorSubject<ComModel> _recItem = BehaviorSubject<ComModel>();

  Sink<ComModel> get _recItemSink => _recItem.sink;

  Stream<ComModel> get recItemStream => _recItem.stream.asBroadcastStream();

  BehaviorSubject<List<ComModel>> _recList = BehaviorSubject<List<ComModel>>();

  Sink<List<ComModel>> get _recListSink => _recList.sink;

  Stream<List<ComModel>> get recListStream =>
      _recList.stream.asBroadcastStream();

  MessageRepository messageRepository = MessageRepository();
  CollectRepository _collectRepository = CollectRepository();
  HttpUtils httpUtils = HttpUtils();

  // 获取数据
  @override
  Future getData({String labelId, int page}) {
    switch (labelId) {
      // 主页
      case Ids.titleHome:
        return getHomeData(labelId);
        break;
      // 项目
      case Ids.titleProject:
        return getArticleListProject(labelId, page);
        break;
      // 动态
      case Ids.titleDynamic:
        return getArticleList(labelId, page);
        break;
      // 体系
      case Ids.titleSystem:
        return getTree(labelId);
        break;
      default:
        return Future.delayed(Duration(seconds: 1));
        break;
    }
  }

  @override
  Future onLoadMore({String labelId}) {
    int _page = 0;
    switch (labelId) {
      case Ids.titleHome:
        break;
      case Ids.titleProject:
        _page = ++_projectPage;
        break;
      case Ids.titleDynamic:
        _page = ++_dynamicPage;
        break;
      case Ids.titleSystem:
        break;
      default:
        break;
    }
    return getData(labelId: labelId, page: _page);
  }

  @override
  Future onRefresh({String labelId, bool isReload}) {
    switch (labelId) {
      case Ids.titleHome:
        break;
      case Ids.titleProject:
        _projectPage = 0;
        break;
      case Ids.titleDynamic:
        _dynamicPage = 0;
        break;
      case Ids.titleSystem:
        break;
      default:
        break;
    }
    return getData(labelId: labelId, page: 0);
  }

  Future getHomeData(String labelId) {
    getRecProject(labelId);
    getRecWxArticle(labelId);
    return getBanner(labelId);
  }

  Future getBanner(String labelId) {
    return messageRepository.getBanner().then((list) {
      _bannerSink.add(UnmodifiableListView<BannerModel>(list));
    });
  }

  Future getRecProject(String labelId) async {
    ComReq _comReq = ComReq(402);
    messageRepository.getProjectList(data: _comReq.toJson()).then((list) {
      if (list.length > 6) {
        list = list.sublist(0, 6);
      }
      _recProjectSink.add(UnmodifiableListView<ProjectModel>(list));
    });
  }

  Future getRecWxArticle(String labelId) async {
    int _id = 408;
    messageRepository.getWxArticleList(id: _id).then((list) {
      if (list.length > 6) {
        list = list.sublist(0, 6);
      }
      _recWxArticleSink.add(UnmodifiableListView<ProjectModel>(list));
    });
  }

  Future getArticleListProject(String labelId, int page) {
    return messageRepository.getArticleListProject(page).then((list) {
      if (_projectList == null) {
        _projectList = List();
      }
      if (page == 0) {
        _projectList.clear();
      }
      _projectList.addAll(list);
      _projectSink.add(UnmodifiableListView<ProjectModel>(_projectList));
      homeEventSink.add(StatusEvent(
          labelId,
          ObjectUtil.isEmpty(list)
              ? RefreshStatus.noMore
              : RefreshStatus.idle));
    }).catchError((_) {
      if (ObjectUtil.isEmpty(_projectList)) {
        _project.sink.addError("error");
      }
      _projectPage--;
      homeEventSink.add(StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  Future getArticleList(String labelId, int page) {
    return messageRepository.getArticleList(page: page).then((list) {
      if (_dynamicList == null) {
        _dynamicList = List();
      }
      if (page == 0) {
        _dynamicList.clear();
      }
      _dynamicList.addAll(list);
      _dynamicSink.add(UnmodifiableListView<ProjectModel>(_dynamicList));
      homeEventSink.add(StatusEvent(
          labelId,
          ObjectUtil.isEmpty(list)
              ? RefreshStatus.noMore
              : RefreshStatus.idle));
    }).catchError((_) {
      if (ObjectUtil.isEmpty(_dynamicList)) {
        _dynamic.sink.addError("error");
      }
      _dynamicPage--;
      homeEventSink.add(StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  Future getTree(String labelId) {
    return messageRepository.getTree().then((list) {
      if (_treeList == null) {
        _treeList = List();
      }

      for (int i = 0, length = list.length; i < length; i++) {
        String tag = Utils.getPinyin(list[i].name);
        if (RegExp("[A-Z]").hasMatch(tag)) {
          list[i].tagIndex = tag;
        } else {
          list[i].tagIndex = "#";
        }
      }
      SuspensionUtil.sortListBySuspensionTag(list);

      _treeList.clear();
      _treeList.addAll(list);
      _treeSink.add(UnmodifiableListView<TreeModel>(_treeList));
      homeEventSink.add(StatusEvent(
          labelId,
          ObjectUtil.isEmpty(list)
              ? RefreshStatus.noMore
              : RefreshStatus.idle));
    }).catchError((_) {
      if (ObjectUtil.isEmpty(_projectList)) {
        _tree.sink.addError("error");
      }
      homeEventSink.add(StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  // 收藏
  void doCollection(String labelId, int id, bool isCollect) {
    if (isCollect) {
      _collectRepository.collect(id).then((bool suc) {
        onCollectRefresh(labelId, id, isCollect);
      });
    } else {
      _collectRepository.unCollect(id).then((bool suc) {
        onCollectRefresh(labelId, id, isCollect);
      });
    }
  }

  // 刷新收藏
  void onCollectRefresh(String labelId, int id, bool isCollect) {
    if (ObjectUtil.isNotEmpty(_projectList)) {
      _projectList?.forEach((model) {
        if (id == model.id) {
          model.collect = isCollect;
        }
        return model;
      });
      _projectSink.add(UnmodifiableListView<ProjectModel>(_projectList));
    }
    if (ObjectUtil.isNotEmpty(_dynamicList)) {
      _dynamicList?.forEach((model) {
        if (id == model.id) {
          model.collect = isCollect;
        }
        return model;
      });
      _dynamicSink.add(UnmodifiableListView<ProjectModel>(_dynamicList));
    }
  }

  @override
  void dispose() {
    _banner.close();
    _recProject.close();
    _recWxArticle.close();
    _project.close();
    _dynamic.close();
    _tree.close();
    _homeEvent.close();
    _recItem.close();
    _recList.close();
  }
}
