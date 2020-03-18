class MessageApi {
  // 首页banner http://www.wanandroid.com/banner/json
  static const String BANNER = "banner";
  // 注册
  static const String USER_REGISTER = "user/register";
  // 登录
  static const String USER_LOGIN = "user/login";
  // 退出
  static const String USER_LOGOUT = "user/logout";

  // 拼接url
  static String getPath({String path: '', int page, String resType: 'json'}) {
    StringBuffer sb = new StringBuffer(path);
    if (page != null) {
      sb.write('/$page');
    }
    if (resType != null && resType.isNotEmpty) {
      sb.write('/$resType');
    }
    return sb.toString();
  }
}