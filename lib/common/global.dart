
import 'dart:io';

import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Global {
  static const bool kReleaseMode =
      bool.fromEnvironment('dart.vm.product', defaultValue: false);

  //初始化全局信息
  static Future init(VoidCallback callback) async {
    WidgetsFlutterBinding.ensureInitialized();
    await SpUtil.getInstance();
    callback();
    if (Platform.isAndroid) {
      // 设置android状态栏为透明的沉浸
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}