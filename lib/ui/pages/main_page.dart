import 'package:base_library/base_library.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:message/res/strings.dart';
import 'package:message/ui/pages/dynamic_page.dart';
import 'package:message/ui/pages/home_page.dart';
import 'package:message/ui/pages/main_drawer.dart';
import 'package:message/ui/pages/project_page.dart';
import 'package:message/ui/pages/search_page.dart';
import 'package:message/ui/pages/system_page.dart';
import 'package:message/utils/navigator_util.dart';
import 'package:message/utils/utils.dart';

class _Page {
  final String labelId;

  _Page(this.labelId);
}

// 主页顶部tab栏list
final List<_Page> _allPages = <_Page>[
  _Page(Ids.titleHome),
  _Page(Ids.titleProject),
  _Page(Ids.titleDynamic),
  _Page(Ids.titleSystem),
];

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 标签控制器
    return DefaultTabController(
      length: _allPages.length,
      child: Scaffold(
        appBar: MyAppBar(
          leading: Container(
            decoration: BoxDecoration(
              // 形状 圆形
              shape: BoxShape.circle,
              image: DecorationImage(
                // 用户头像本地路径
                image: AssetImage(
                  Utils.getImgPath('ali_connors'),
                ),
              ),
            ),
          ),
          // 标题居中
          centerTitle: true,
          title: TabLayout(),
          // 顶部右侧搜索组件
          actions: <Widget>[
            IconButton(
              // 搜索icon
              icon: Icon(Icons.search),
              // 点击事件
              onPressed: () {
                // 跳转搜索页面
                NavigatorUtil.pushPage(context, SearchPage(),
                    pageName: "SearchPage");
              },
            )
          ],
        ),
        // tab切换组件
        body: TabBarViewLayout(),
        // 主页侧边栏
        drawer: Drawer(
          child: MainDrawer(),
        ),
      ),
    );
  }
}

class TabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      labelPadding: EdgeInsets.all(12.0),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: _allPages
          .map(
            (_Page page) => Tab(
              text: IntlUtil.getString(context, page.labelId),
            ),
          )
          .toList(),
    );
  }
}

class TabBarViewLayout extends StatelessWidget {
  Widget buildTabView(BuildContext context, _Page page) {
    // 页面标签id
    String labelId = page.labelId;
    switch (labelId) {
      // 主页
      case Ids.titleHome:
        return HomePage(labelId: labelId);
        break;
        // 项目页面
      case Ids.titleProject:
        return ProjectPage(labelId: labelId);
        break;
        // 动态页面
      case Ids.titleDynamic:
        return DynamicPage(labelId: labelId);
        break;
        // 体系页面
      case Ids.titleSystem:
        return SystemPage(labelId: labelId);
        break;
        // 空
      default:
        return Container();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: _allPages.map(
        (_Page page) {
          return buildTabView(context, page);
        },
      ).toList(),
    );
  }
}
