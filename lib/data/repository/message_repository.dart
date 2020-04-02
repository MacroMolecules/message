import 'package:base_library/base_library.dart';
import 'package:message/common/common.dart';
import 'package:message/data/api/api.dart';
import 'package:message/data/protocol/modeels.dart';

class MessageRepository {
  Future<List<BannerModel>> getBanner() async {
    BaseResp<List> baseResp = await DioUtil().request<List>(
        Method.get, MessageApi.getPath(path: MessageApi.BANNER));
    List<BannerModel> bannerList;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      bannerList = baseResp.data.map((value) {
        return BannerModel.fromJson(value);
      }).toList();
    }
    return bannerList;
  }

  Future<List<ProjectModel>> getArticleListProject(int page) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.get,
            MessageApi.getPath(
                path: MessageApi.ARTICLE_LISTPROJECT, page: page));
    List<ProjectModel> list;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((value) {
        return ProjectModel.fromJson(value);
      }).toList();
    }
    return list;
  }

  Future<List<ProjectModel>> getArticleList({int page, data}) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.get,
            MessageApi.getPath(path: MessageApi.ARTICLE_LIST, page: page),
            data: data);
    List<ProjectModel> list;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((value) {
        return ProjectModel.fromJson(value);
      }).toList();
    }
    return list;
  }

  Future<List<TreeModel>> getTree() async {
    BaseResp<List> baseResp = await DioUtil().request<List>(
        Method.get, MessageApi.getPath(path: MessageApi.TREE));
    List<TreeModel> treeList;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      treeList = baseResp.data.map((value) {
        return TreeModel.fromJson(value);
      }).toList();
    }
    return treeList;
  }

  Future<List<ProjectModel>> getProjectList({int page: 1, data}) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.get,
            MessageApi.getPath(path: MessageApi.PROJECT_LIST, page: page),
            data: data);
    List<ProjectModel> list;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((value) {
        return ProjectModel.fromJson(value);
      }).toList();
    }
    return list;
  }

  Future<List<ProjectModel>> getWxArticleList({int id, int page: 1, data}) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.get,
            MessageApi.getPath(
                path: MessageApi.WXARTICLE_LIST + '/$id', page: page),
            data: data);
    List<ProjectModel> list;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((value) {
        return ProjectModel.fromJson(value);
      }).toList();
    }
    return list;
  }

  Future<List<TreeModel>> getWxArticleChapters() async {
    BaseResp<List> baseResp = await DioUtil().request<List>(Method.get,
        MessageApi.getPath(path: MessageApi.WXARTICLE_CHAPTERS));
    List<TreeModel> treeList;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      treeList = baseResp.data.map((value) {
        return TreeModel.fromJson(value);
      }).toList();
    }
    return treeList;
  }

  Future<List<TreeModel>> getProjectTree() async {
    BaseResp<List> baseResp = await DioUtil().request<List>(
        Method.get, MessageApi.getPath(path: MessageApi.PROJECT_TREE));
    List<TreeModel> treeList;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      treeList = baseResp.data.map((value) {
        return TreeModel.fromJson(value);
      }).toList();
    }
    return treeList;
  }
}