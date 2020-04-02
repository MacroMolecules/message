import 'package:base_library/base_library.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/blocs/collect_bloc.dart';
import 'package:message/blocs/event.dart';
import 'package:message/common/common.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/res/strings.dart';
import 'package:message/ui/pages/about_page.dart';
import 'package:message/ui/pages/collect_page.dart';
import 'package:message/ui/pages/setting_page.dart';
import 'package:message/ui/pages/share_page.dart';
import 'package:message/utils/navigator_util.dart';
import 'package:message/utils/utils.dart';

// 主页侧边栏
class MainDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainDrawerState();
  }
}

class PageInfo {
  PageInfo(this.titleId, this.iconData, this.page, [this.withScaffold = true]);

  String titleId;
  IconData iconData;
  Widget page;
  bool withScaffold;
}

class _MainDrawerState extends State<MainDrawer> {
  List<PageInfo> _pageInfo = List();
  PageInfo loginOut =
      PageInfo(Ids.titleSignOut, Icons.power_settings_new, null);
  String _userName;

  // 初始化侧边栏
  @override
  void initState() {
    super.initState();
    // 收藏页面
    _pageInfo.add(
      PageInfo(
        Ids.titleCollection,
        Icons.collections,
        CollectPage(
          labelId: Ids.titleCollection,
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

  void _showLoginOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        // 注销弹窗
        return AlertDialog(
          content: Text(
            "确定退出吗？",
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                IntlUtil.getString(ctx, Ids.cancel),
                style: TextStyles.listExtra2,
              ),
              onPressed: () {
                Navigator.pop(ctx);
              },
            ),
            FlatButton(
              child: Text(
                IntlUtil.getString(ctx, Ids.confirm),
                style: TextStyles.listExtra,
              ),
              onPressed: () {
                SpUtil.remove(BaseConstant.keyAppToken);
                Event.sendAppEvent(context, Constant.type_sys_update);
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Util.isLogin()) {
      if (!_pageInfo.contains(loginOut)) {
        _pageInfo.add(loginOut);
        UserModel userModel = SpUtil.getObj(
            BaseConstant.keyUserModel, (v) => UserModel.fromJson(v));
        _userName = userModel?.username ?? "";
      }
    } else {
      _userName = "Sky24n";
      if (_pageInfo.contains(loginOut)) {
        _pageInfo.remove(loginOut);
      }
    }

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
                    if (pageInfo.titleId == Ids.titleSignOut) {
                      _showLoginOutDialog(context);
                    } else if (pageInfo.titleId == Ids.titleCollection) {
                      NavigatorUtil.pushPage(
                        context,
                        BlocProvider<CollectBloc>(
                          child: pageInfo.page,
                          bloc: CollectBloc(),
                        ),
                        pageName: pageInfo.titleId,
                        needLogin: Utils.isNeedLogin(pageInfo.titleId),
                      );
                    } else {
                      NavigatorUtil.pushPage(
                        context,
                        pageInfo.page,
                        pageName: pageInfo.titleId,
                        needLogin: Utils.isNeedLogin(pageInfo.titleId),
                      );
                    }
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
