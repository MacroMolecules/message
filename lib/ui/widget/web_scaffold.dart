import 'package:base_library/base_library.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:message/utils/navigator_util.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScaffold extends StatefulWidget {
  const WebScaffold({
    Key key,
    this.title,
    this.titleId,
    this.url,
  }) : super(key: key);

  final String title;
  final String titleId;
  final String url;

  @override
  State<StatefulWidget> createState() {
    return WebScaffoldState();
  }
}

class WebScaffoldState extends State<WebScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // 获取util标题
          widget.title ?? IntlUtil.getString(context, widget.titleId),
          // 一行
          maxLines: 1,
          // 标题不够 结尾使用省略号
          overflow: TextOverflow.ellipsis,
        ),
        // 居中
        centerTitle: true,
      ),
      // 页面具体内容
      body: WebView(
        // web控制器
        onWebViewCreated: (WebViewController webViewController) {},
        // 内容url
        initialUrl: widget.url,
        // js模式显示
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
