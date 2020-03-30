import 'package:base_library/base_library.dart';
import 'package:dio/dio.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:message/blocs/application_bloc.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/blocs/main_bloc.dart';
import 'package:message/common/common.dart';
import 'package:message/common/global.dart';
import 'package:message/common/sp_helper.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/res/colors.dart';
import 'package:message/res/strings.dart';
import 'package:message/ui/pages/main_page.dart';
import 'package:message/ui/pages/initialize_page.dart';

void main() {
  // 全局变量
  Global.init(
    () {
      runApp(
        BlocProvider<ApplicationBloc>(
          // bloc
          bloc: ApplicationBloc(),
          child: BlocProvider(
            child: MyApp(),
            bloc: MainBloc(),
          ),
        ),
      );
    },
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  Locale _locale;
  Color _themeColor = Colours.app_main;

  @override
  void initState() {
    super.initState();
    // 国际化
    setLocalizedValues(localizedValues);
    init();
  }

  // 使用dio发起网络请求以及Cookie管理
  void _init() {
    // 通过传递一个options来创建dio实例
    Options options = DioUtil.getDefOptions();
    // 设置 baseUrl
    options.baseUrl = Constant.server_address;
    // 在cookie中写入token
    String cookie = SpUtil.getString(BaseConstant.keyAppToken);
    if (ObjectUtil.isNotEmpty(cookie)) {
      // 头部添加 token 验证
      Map<String, dynamic> _headers = Map();
      _headers["Cookie"] = cookie;
      options.headers = _headers;
    }
    // 配置http
    HttpConfig config = HttpConfig(options: options);
    DioUtil().setConfig(config);
  }

  void init() {
    _init();
    _initListener();
    _loadLocale();
  }

  // Bloc监听
  void _initListener() {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    bloc.appEventStream.listen((value) {
      _loadLocale();
    });
  }

  // 加载本地化
  void _loadLocale() {
    setState(() {
      // 获取本地语言
      LanguageModel model =
          SpUtil.getObj(Constant.keyLanguage, (v) => LanguageModel.fromJson(v));
      if (model != null) {
        _locale = Locale(model.languageCode, model.countryCode);
      } else {
        _locale = null;
      }
      // 获取本地主题
      String _colorKey = SpHelper.getThemeColor();
      if (themeColorMap[_colorKey] != null)
        _themeColor = themeColorMap[_colorKey];
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 通过Navigation.of(context).pushNamed跳转的路由
      routes: {
        BaseConstant.routeMain: (ctx) => MainPage(),
      },
      // 初始化主页
      home: InitializePage(),
      // 主题
      theme: ThemeData.light().copyWith(
        // 主色
        primaryColor: _themeColor,
        // 强调色
        accentColor: _themeColor,
        indicatorColor: Colors.white,
      ),
      // 国际化
      locale: _locale,
      // 更改Flutter 组件默认的提示语，按钮text
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // 自定义
        CustomLocalizations.delegate
      ],
      // 传入支持的语种数组
      supportedLocales: CustomLocalizations.supportedLocales,
    );
  }
}
