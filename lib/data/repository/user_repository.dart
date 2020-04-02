import 'package:base_library/base_library.dart';
import 'package:message/common/common.dart';
import 'package:message/data/api/api.dart';
import 'package:message/data/protocol/modeels.dart';

class UserRepository {
  Future<UserModel> login(LoginReq req) async {
    BaseRespR<Map<String, dynamic>> baseResp = await DioUtil()
        .requestR<Map<String, dynamic>>(Method.post, MessageApi.user_login,
            data: req.toJson());
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    baseResp.response.headers.forEach((String name, List<String> values) {
      if (name == "set-cookie") {
        String cookie = values.toString();
        SpUtil.putString(BaseConstant.keyAppToken, cookie);
        DioUtil().setCookie(cookie);
      }
    });
    UserModel model = UserModel.fromJson(baseResp.data);
    SpUtil.putObject(BaseConstant.keyUserModel, model);
    return model;
  }

  Future<UserModel> register(RegisterReq req) async {
    BaseRespR<Map<String, dynamic>> baseResp = await DioUtil()
        .requestR<Map<String, dynamic>>(
            Method.post, MessageApi.user_register,
            data: req.toJson());
    if (baseResp.code != Constant.status_success) {
      return Future.error(baseResp.msg);
    }
    baseResp.response.headers.forEach((String name, List<String> values) {
      if (name == "set-cookie") {
        String cookie = values.toString();
        SpUtil.putString(BaseConstant.keyAppToken, cookie);
        DioUtil().setCookie(cookie);
      }
    });
    UserModel model = UserModel.fromJson(baseResp.data);
    SpUtil.putObject(BaseConstant.keyUserModel, model);
    return model;
  }
}
