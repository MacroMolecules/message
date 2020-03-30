import 'package:base_library/base_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/blocs/recommend_bloc.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/ui/pages/recommend_page.dart';
import 'package:message/ui/widget/web_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigatorUtil {
  static void pushPage(
    BuildContext context,
    Widget page, {
    String pageName,
  }) {
    if (context == null || page == null) return;
    Navigator.push(
      context,
      CupertinoPageRoute<void>(builder: (ctx) => page),
    );
  }

  static void pushWeb(BuildContext context,
      {String title, String titleId, String url, bool isHome: false}) {
    if (context == null || ObjectUtil.isEmpty(url)) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title ?? titleId);
    } else {
      // 新的web页面
      Navigator.push(
        context,
        CupertinoPageRoute<void>(
          builder: (ctx) => WebScaffold(
            title: title,
            titleId: titleId,
            url: url,
          ),
        ),
      );
    }
  }

  // 推荐项目页面
  static void pushRecommendPage(BuildContext context,
      {String labelId, String title, String titleId, TreeModel treeModel}) {
    if (context == null) return;
    Navigator.push(
      context,
      CupertinoPageRoute<void>(
        // 提供bloc
        builder: (ctx) => BlocProvider<RecommendBloc>(
          child: RecommendPage(
            labelId: labelId,
            title: title,
            titleId: titleId,
            treeModel: treeModel,
          ),
          bloc: RecommendBloc(),
        ),
      ),
    );
  }

  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
