import 'package:base_library/base_library.dart';
import 'package:message/common/common.dart';
import 'package:message/data/api/api.dart';
import 'package:message/data/protocol/modeels.dart';

// 存储库
class MessageRepository {
  // 轮播异步
  Future<List<BannerModel>> getBanner() async {
    // dio请求
    BaseResp<List> baseResp = await DioUtil().request<List>(
      Method.get,
      MessageApi.getPath(path: MessageApi.BANNER),
    );
    List<BannerModel> bannerList;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      bannerList = baseResp.data.map(
        (value) {
          return BannerModel.fromJson(value);
        },
      ).toList();
    }
    // 返回轮播列表
    return bannerList;
  }

  // 获取文章列表项目
  Future<List<ProjectModel>> getArticleListProject(int page) async {
    BaseResp<Map<String, dynamic>> baseResp =
        await DioUtil().request<Map<String, dynamic>>(
      Method.get,
      MessageApi.getPath(
        path: MessageApi.ARTICLE_LISTPROJECT,
        page: page,
      ),
    );
    List<ProjectModel> list;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map(
        (value) {
          return ProjectModel.fromJson(value);
        },
      ).toList();
    }
    return list;
  }

  // 获取文章列表
  Future<List<ProjectModel>> getArticleList({int page, data}) async {
    BaseResp<Map<String, dynamic>> baseResp =
        await DioUtil().request<Map<String, dynamic>>(
      Method.get,
      MessageApi.getPath(
        path: MessageApi.ARTICLE_LIST,
        page: page,
      ),
      data: data,
    );
    List<ProjectModel> list;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map(
        (value) {
          return ProjectModel.fromJson(value);
        },
      ).toList();
    }
    return list;
  }

  Future<List<TreeModel>> getTree() async {
    BaseResp<List> baseResp = await DioUtil().request<List>(
      Method.get,
      MessageApi.getPath(
        path: MessageApi.TREE,
      ),
    );
    List<TreeModel> treeList;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      treeList = baseResp.data.map(
        (value) {
          return TreeModel.fromJson(value);
        },
      ).toList();
    }
    return treeList;
  }

  // 获取项目列表
  Future<List<ProjectModel>> getProjectList({int page: 1, data}) async {
    BaseResp<Map<String, dynamic>> baseResp =
        await DioUtil().request<Map<String, dynamic>>(
      Method.get,
      MessageApi.getPath(
        path: MessageApi.PROJECT_LIST,
        page: page,
      ),
      data: data,
    );
    List<ProjectModel> list;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map(
        (value) {
          return ProjectModel.fromJson(value);
        },
      ).toList();
    }
    return list;
  }

  Future<List<TreeModel>> getProjectTree() async {
    BaseResp<List> baseResp = await DioUtil().request<List>(
      Method.get,
      MessageApi.getPath(
        path: MessageApi.PROJECT_TREE,
      ),
    );
    List<TreeModel> treeList;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      treeList = baseResp.data.map(
        (value) {
          return TreeModel.fromJson(value);
        },
      ).toList();
    }
    return treeList;
  }

  // 获取微信文章列表
  Future<List<ProjectModel>> getWxArticleList(
      {int id, int page: 1, data}) async {
    BaseResp<Map<String, dynamic>> baseResp =
        await DioUtil().request<Map<String, dynamic>>(
      Method.get,
      MessageApi.getPath(
        path: MessageApi.WXARTICLE_LIST + '/$id',
        page: page,
      ),
      data: data,
    );
    List<ProjectModel> list;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map(
        (value) {
          return ProjectModel.fromJson(value);
        },
      ).toList();
    }
    return list;
  }

  // 获取微信公众号章节
  Future<List<TreeModel>> getWxArticleChapters() async {
    BaseResp<List> baseResp = await DioUtil().request<List>(
      Method.get,
      MessageApi.getPath(
        path: MessageApi.WXARTICLE_CHAPTERS,
      ),
    );
    List<TreeModel> treeList;
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      treeList = baseResp.data.map(
        (value) {
          return TreeModel.fromJson(value);
        },
      ).toList();
    }
    return treeList;
  }
}
