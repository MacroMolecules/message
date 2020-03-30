import 'dart:collection';

import 'package:message/blocs/bloc_provider.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/data/repository/message_repository.dart';
import 'package:message/res/strings.dart';
import 'package:rxdart/rxdart.dart';

class RecommendBloc implements BlocBase {
  BehaviorSubject<List<TreeModel>> _recommendTree =
      BehaviorSubject<List<TreeModel>>();

  Sink<List<TreeModel>> get _recommendTreeSink => _recommendTree.sink;

  Stream<List<TreeModel>> get recommendTreeStream => _recommendTree.stream;

  List<TreeModel> treeList;

  MessageRepository messageRepository = MessageRepository();

  @override
  Future getData({String labelId, int page}) {
    switch (labelId) {
      case Ids.titleProjectTree:
        return getProjectTree(labelId);
        break;
      case Ids.titleWxArticleTree:
        return getWxArticleTree(labelId);
        break;
      case Ids.titleSystemTree:
        return getSystemTree(labelId);
        break;
      default:
        return Future.delayed(Duration(seconds: 1));
        break;
    }
  }

  @override
  Future onLoadMore({String labelId}) {
    return null;
  }

  @override
  Future onRefresh({String labelId}) {
    return getData(labelId: labelId);
  }

  void bindSystemData(TreeModel model) {
    if (model == null) return;
    treeList = model.children;
  }

  Future getProjectTree(String labelId) {
    return messageRepository.getProjectTree().then((list) {
      _recommendTreeSink.add(UnmodifiableListView<TreeModel>(list));
    });
  }

  Future getWxArticleTree(String labelId) {
    return messageRepository.getWxArticleChapters().then((list) {
      _recommendTreeSink.add(UnmodifiableListView<TreeModel>(list));
    });
  }

  Future getSystemTree(String labelId) {
    return Future.delayed(Duration(milliseconds: 500)).then((_) {
      _recommendTreeSink.add(UnmodifiableListView<TreeModel>(treeList));
    });
  }

  Future getTree(String labelId) {
    return messageRepository.getProjectTree().then((list) {
      if (treeList == null) {
        treeList = List();
      }
      treeList.clear();
      treeList.addAll(list);
      _recommendTreeSink.add(UnmodifiableListView<TreeModel>(treeList));
    }).catchError((_) {
    });
  }

  @override
  void dispose() {
    _recommendTree.close();
  }
}

