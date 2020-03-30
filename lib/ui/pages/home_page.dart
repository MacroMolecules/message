import 'package:base_library/base_library.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/blocs/main_bloc.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/res/strings.dart';
import 'package:message/ui/widget/article_item.dart';
import 'package:message/ui/widget/header_item.dart';
import 'package:message/ui/widget/project_item.dart';
import 'package:message/ui/widget/refresh_scaffold.dart';
import 'package:message/ui/widget/widgets.dart';
import 'package:message/utils/navigator_util.dart';
import 'package:message/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

bool isHomeInit = true;

class HomePage extends StatelessWidget {
  const HomePage({Key key, this.labelId}) : super(key: key);

  // 标签id
  final String labelId;

  // 首页轮播
  Widget buildBanner(BuildContext context, List<BannerModel> list) {
    if (ObjectUtil.isEmpty(list)) {
      return Container(height: 0.0);
    }
    // 约束宽高比
    return AspectRatio(
      // 设置宽高比为16:9
      aspectRatio: 16.0 / 9.0,
      // 轮播组件
      child: Swiper(
        // 指标调整到顶部最后
        indicatorAlignment: AlignmentDirectional.topEnd,
        // 添加圆形
        circular: true,
        // 时间间隔5秒
        interval: Duration(seconds: 5),
        // 轮播样式
        indicator: NumberSwiperIndicator(),
        children: list.map((model) {
          return InkWell(
            // 点击事件回调
            onTap: () {
              // 页面跳转
              NavigatorUtil.pushWeb(context,
                  title: model.title, url: model.url);
            },
            // 使用缓存图片
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              // 图片路径
              imageUrl: model.imagePath,
              // 占位符 加载方式
              placeholder: (context, url) => ProgressView(),
              // 错误组件
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 首页 推荐项目
  Widget buildProject(BuildContext context, List<ProjectModel> list) {
    // 如果util为空
    if (ObjectUtil.isEmpty(list)) {
      return Container(height: 0.0);
    }
    // 推荐项目
    List<Widget> _children = list.map((model) {
      return ProjectItem(
        model,
        isHome: true,
      );
    }).toList();
    // 添加一个在主页显示的list
    List<Widget> children = List();
    children.add(
      HeaderItem(
        leftIcon: Icons.book,
        titleId: Ids.recProject,
        // 点击跳转推荐项目页面
        onTap: () {
          NavigatorUtil.pushRecommendPage(context,
              labelId: Ids.titleProjectTree, titleId: Ids.titleProjectTree);
        },
      ),
    );
    // 添加所有children
    children.addAll(_children);
    return Column(
      // 十字对齐
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  // 首页微信公众号信息流
  Widget buildWxArticle(BuildContext context, List<ProjectModel> list) {
    if (ObjectUtil.isEmpty(list)) {
      return Container(height: 0.0);
    }
    // 微信信息流列表
    List<Widget> _children = list.map((model) {
      return ArticleItem(
        model,
        isHome: true,
      );
    }).toList();
    List<Widget> children = List();
    // 向信息流List添加一个List,拼接成一个新的List
    children.add(
      HeaderItem(
        titleColor: Colors.green,
        leftIcon: Icons.library_books,
        titleId: Ids.recWxArticle,
        onTap: () {
          NavigatorUtil.pushRecommendPage(context,
              labelId: Ids.titleWxArticleTree, titleId: Ids.titleWxArticleTree);
        },
      ),
    );
    // 向List 添加一个List,拼接成一个新的List
    children.addAll(_children);
    // 返回List
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 刷新
    RefreshController _controller = RefreshController();
    // 提供bloc管理
    MainBloc bloc = BlocProvider.of<MainBloc>(context);
    // 主页事件流
    bloc.homeEventStream.listen(
      (event) {
        // 事件监听
        if (labelId == event.labelId) {
          // 发送事件状态
          _controller.sendBack(false, event.status);
        }
      },
    );

    // 主页初始化
    if (isHomeInit) {
      isHomeInit = false;
      Observable.just(1)
      // 延迟响应
          .delay(
        Duration(
          // 持续10秒
          milliseconds: 10,
        ),
      )
          .listen((_) {
        bloc.onRefresh(labelId: labelId);
        bloc.getHotRecItem();
      });
    }

    return StreamBuilder(
      // 轮播流
      stream: bloc.bannerStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<BannerModel>> snapshot) {
            // 刷新
        return RefreshScaffold(
          labelId: labelId,
          // 获取负载状态
          loadStatus: Utils.getLoadStatus(snapshot.hasError, snapshot.data),
          controller: _controller,
          enablePullUp: false,
          // 刷新
          onRefresh: ({bool isReload}) {
            return bloc.onRefresh(labelId: labelId);
          },
          child: ListView(
            children: <Widget>[
              buildBanner(context, snapshot.data),
              StreamBuilder(
                // 推荐项目流
                stream: bloc.recProjectStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProjectModel>> snapshot) {
                  return buildProject(context, snapshot.data);
                },
              ),
              StreamBuilder(
                // 微信公众号流
                stream: bloc.recWxArticleStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProjectModel>> snapshot) {
                  return buildWxArticle(context, snapshot.data);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// // 轮播样式函数
class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      // 轮播组件装饰
      decoration: BoxDecoration(
        color: Colors.black45,
        // 控制边界的圆角20
        borderRadius: BorderRadius.circular(20.0),
      ),
      // 边缘
      margin: EdgeInsets.only(top: 10.0, right: 5.0),
      // 填充
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Text(
        "${++index}/$itemCount",
        style: TextStyle(color: Colors.white70, fontSize: 11.0),
      ),
    );
  }
}
