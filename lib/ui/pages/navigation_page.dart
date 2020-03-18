import 'package:flutter/material.dart';
import 'package:message/res/strings.dart';
import 'package:message/ui/pages/drawer_page.dart';
import 'package:message/ui/pages/dynamic_page.dart';
import 'package:message/ui/pages/home_page.dart';
import 'package:message/ui/pages/hot_page.dart';
import 'package:message/ui/pages/project_page.dart';
import 'package:message/ui/pages/search_page.dart';
import 'package:message/ui/pages/system_page.dart';
import 'package:message/utils/utils.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _Page {
  final String labelId;

  _Page(this.labelId);
}

// tab页面列表
final List<_Page> _tabPages = <_Page>[
  _Page(Ids.titleHome),
  _Page(Ids.titleProject),
  _Page(Ids.titleHot),
  _Page(Ids.titleDynamic),
  _Page(Ids.titleSystem),
];

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    // 首页标签组件
    return DefaultTabController(
      length: _tabPages.length,
      child: Scaffold(
        appBar: AppBar(
          // 左边头像
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  Utils.getImgPath('ali_connors'),
                ),

              ),
            ),
            // child: Container(
            //   width: 5.0,
            //   height: 5.0,
            // ),
          ),
          // 中间
          centerTitle: true,
          title: TabLayout(),
          // 右边
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                SearchPage();
              },
            )
          ],
        ),
        body: TabBarViewLayout(),
        drawer: Drawer(
          child: DrawerPage(),
        ),
      ),
    );
  }
}

// 顶部中间tab
class TabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      // 是否滚动
      isScrollable: true,
      // 标签间距
      labelPadding: EdgeInsets.all(12.0),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: _tabPages.map(
        (_Page page) {
          return Tab(
            text: page.labelId,
          );
        },
      ).toList(),
    );
  }
}

// tab导航切换页面
class TabBarViewLayout extends StatelessWidget {
  Widget buildTabView(BuildContext context, _Page page) {
    String labelId = page.labelId;
    // 开关控件
    switch (labelId) {
      case Ids.titleHome:
        return HomePage(labelId: labelId);
        break;
      case Ids.titleProject:
        return ProjectPage(labelId: labelId);
        break;
      case Ids.titleHot:
        return HotPage(labelId: labelId);
        break;
      case Ids.titleDynamic:
        return DynamicPage(labelId: labelId);
        break;
      case Ids.titleSystem:
        return SystemPage(labelId: labelId);
        break;
      default:
        return Container();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new TabBarView(
        children: _tabPages.map((_Page page) {
      return buildTabView(context, page);
    }).toList());
  }
}
