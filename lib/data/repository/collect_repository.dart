import 'package:base_library/base_library.dart';
import 'package:message/common/common.dart';
import 'package:message/data/api/api.dart';
import 'package:message/data/protocol/modeels.dart';

class CollectRepository {
  Future<List<ProjectModel>> getCollectList(int page) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.get,
            MessageApi.getPath(
                path: MessageApi.lg_collect_list, page: page));
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    List<ProjectModel> list;
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas?.map((value) {
        ProjectModel model = ProjectModel.fromJson(value);
        model.collect = true;
        return model;
      })?.toList();
    }
    return list;
  }

  Future<bool> collect(int id) async {
    BaseResp baseResp = await DioUtil().request(Method.post,
        MessageApi.getPath(path: MessageApi.lg_collect, page: id));
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    return true;
  }

  Future<bool> unCollect(int id) async {
    BaseResp baseResp = await DioUtil().request(
        Method.post,
        MessageApi.getPath(
            path: MessageApi.lg_uncollect_originid, page: id));
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    return true;
  }
}