import 'package:base_library/base_library.dart';
import 'package:message/common/common.dart';

class SpHelper {
  // T 用于区分存储类型
  static void _putObject<T>(String key, Object value) {
    switch (T) {
      case int:
        SpUtil.putInt(key, value);
        break;
      case double:
        SpUtil.putDouble(key, value);
        break;
      case bool:
        SpUtil.putBool(key, value);
        break;
      case String:
        SpUtil.putString(key, value);
        break;
      case List:
        SpUtil.putStringList(key, value);
        break;
      default:
        SpUtil.putObject(key, value);
        break;
    }
  }

  static String getThemeColor() {
    return SpUtil.getString(Constant.key_theme_color,
        defValue: 'deepPurpleAccent');
  }
}