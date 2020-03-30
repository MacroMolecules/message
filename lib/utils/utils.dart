import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:message/common/common.dart';
import 'package:message/res/colors.dart';

class Utils {
  // 本地img路径
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  // 拼音
  static String getPinyin(String str) {
    return PinyinHelper.getShortPinyin(str).substring(0, 1).toUpperCase();
  }

  static Color getCircleBg(String str) {
    String pinyin = getPinyin(str);
    return getCircleAvatarBg(pinyin);
  }

  // 圆圈头像
  static Color getCircleAvatarBg(String key) {
    return circleAvatarMap[key];
  }

  static Color getChipBgColor(String name) {
    String pinyin = PinyinHelper.getFirstWordPinyin(name);
    pinyin = pinyin.substring(0, 1).toUpperCase();
    return nameToColor(pinyin);
  }

  // 名字颜色
  static Color nameToColor(String name) {
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  // 获取时间线
  static String getTimeLine(BuildContext context, int timeMillis) {
    return TimelineUtil.format(
      timeMillis,
      // 本地化
      locale: Localizations.localeOf(context).languageCode,
      dayFormat: DayFormat.Common,
    );
  }

  // 获取标题字体大小
  static double getTitleFontSize(String title) {
    // 空或小于10
    if (ObjectUtil.isEmpty(title) || title.length < 10) {
      return 18.0;
    }
    int count = 0;
    List<String> list = title.split("");
    for (int i = 0, length = list.length; i < length; i++) {
      String ss = list[i];
      if (RegexUtil.isZh(ss)) {
        count++;
      }
    }

    return (count >= 10 || title.length > 16) ? 14.0 : 18.0;
  }

  // 获取负载状态
  static int getLoadStatus(bool hasError, List data) {
    if (hasError) return LoadStatus.fail;
    // 数据等于空返回正在加载
    if (data == null) {
      return LoadStatus.loading;
    } else if (data.isEmpty) {
      return LoadStatus.empty;
    } else {
      return LoadStatus.success;
    }
  }
}
