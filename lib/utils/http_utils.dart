import 'package:message/data/protocol/modeels.dart';

//模拟网络请求数据
class HttpUtils {

  Future<ComModel> getRecItem() async {
    return Future.delayed(
      Duration(milliseconds: 300),
      () {
        return null;
      },
    );
  }

  Future<List<ComModel>> getRecList() async {
    return Future.delayed(
      Duration(milliseconds: 300),
      () {
        return List();
      },
    );
  }
}
