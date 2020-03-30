import 'package:base_library/base_library.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/res/strings.dart';
import 'package:message/ui/pages/about_page.dart';
import 'package:message/ui/pages/collect_page.dart';
import 'package:message/ui/pages/setting_page.dart';
import 'package:message/ui/pages/share_page.dart';
import 'package:message/utils/navigator_util.dart';
import 'package:message/utils/utils.dart';

class MainDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainDrawerState();
  }
}

class PageInfo {
  PageInfo(
    this.titleId,
    this.iconData,
    this.page, [
    this.withScaffold = true,
  ]);

  String titleId;
  IconData iconData;
  Widget page;
  bool withScaffold;
}

class _MainDrawerState extends State<MainDrawer> {
  List<PageInfo> _pageInfo = List();
  String _userName;

  // 初始化侧边栏
  @override
  void initState() {
    super.initState();
    // 收藏页面
    _pageInfo.add(
      PageInfo(
        Ids.titleCollect,
        Icons.collections,
        CollectPage(
          labelId: Ids.titleCollect,
        ),
      ),
    );
    // 设置页面
    _pageInfo.add(
      PageInfo(
        Ids.titleSetting,
        Icons.settings,
        SettingPage(),
      ),
    );
    // 关于页面
    _pageInfo.add(
      PageInfo(
        Ids.titleAbout,
        Icons.info,
        AboutPage(),
      ),
    );
    // 分享页面
    _pageInfo.add(
      PageInfo(
        Ids.titleShare,
        Icons.share,
        SharePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _userName = "Sky24n";
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 166.0,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(
                top: ScreenUtil.getInstance().statusBarHeight, left: 10.0),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 64.0,
                      height: 64.0,
                      margin: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // 本地图片
                        image: DecorationImage(
                          image: AssetImage(
                            Utils.getImgPath('ali_connors'),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      _userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.vGap5,
                    Text(
                      "个人简介",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ],
                ),
                // 侧边栏顶部色块
                Align(
                  alignment: Alignment.topRight,
                ),
              ],
            ),
          ),
          // 布局
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: _pageInfo.length,
              itemBuilder: (BuildContext context, int index) {
                PageInfo pageInfo = _pageInfo[index];
                return ListTile(
                  leading: Icon(pageInfo.iconData),
                  title: Text(
                    IntlUtil.getString(context, pageInfo.titleId),
                  ),
                  onTap: () {
                    NavigatorUtil.pushPage(
                      context,
                      pageInfo.page,
                      pageName: pageInfo.titleId,
                    );
                  },
                );
              },
            ),
            flex: 1,
          )
        ],
      ),
    );
  }
}
