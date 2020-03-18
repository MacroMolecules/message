import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/ui/widget/banner_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.labelId}) : super(key: key);

  String labelId;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 声明一个list，存放image Widget
  List<Widget> imageList = List();

  @override
  void initState() {
    imageList
      ..add(Image.network(
        'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2726034926,4129010873&fm=26&gp=0.jpg',
        fit: BoxFit.fill,
      ))
      ..add(Image.network(
        'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3485348007,2192172119&fm=26&gp=0.jpg',
        fit: BoxFit.fill,
      ))
      ..add(Image.network(
        'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2594792439,969125047&fm=26&gp=0.jpg',
        fit: BoxFit.fill,
      ))
      ..add(Image.network(
        'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=190488632,3936347730&fm=26&gp=0.jpg',
        fit: BoxFit.fill,
      ));
    super.initState();
  }

  // 首页轮播
  Widget buildBanner(BuildContext context, List<BannerModel> list) {
    // 约束宽高比控件
    return Container(
      padding: EdgeInsets.fromLTRB(0, 55, 0, 5),
      width: MediaQuery.of(context).size.width,
      height: 265,
      child: Swiper(
        itemCount: 4,
        itemBuilder: _swiperBuilder,
        // 自动播放
        autoplay: true,
        // 拖拽的时候，是否停止自动播放
        autoplayDisableOnInteraction: true,
        // 轮播样式
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            // 其他点的颜色
            color: Colors.white70,
            // 当前点的颜色
            activeColor: Colors.redAccent,
            // 点与点之间的距离
            space: 2,
            // 当前点的大小
            activeSize: 12,
          ),
        ),
        controller: SwiperController(),
        scrollDirection: Axis.horizontal,
        onTap: (index) => print('点击了第$index'),
      ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (imageList[index]);
  }

  @override
  Widget build(BuildContext context) {
    List<BannerModel> list;
    return Scaffold(
      body: buildBanner(context, list),
    );
  }
}
