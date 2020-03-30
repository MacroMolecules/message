import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:message/common/common.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class InitializePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InitializePageState();
  }
}

class InitializePageState extends State<InitializePage> {
  // 轮播list
  List<String> _guideList = [
    Utils.getImgPath('guide1'),
    Utils.getImgPath('guide2'),
    Utils.getImgPath('guide3'),
    Utils.getImgPath('guide4'),
  ];

  List<Widget> _bannerList = List();

  int _status = 0;

  InitializeModel _initializeModel;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    Observable.just(1).delay(Duration(milliseconds: 500)).listen((_) {
      if (SpUtil.getBool(Constant.key_guide, defValue: true) &&
          ObjectUtil.isNotEmpty(_guideList)) {
        SpUtil.putBool(Constant.key_guide, false);
        _initBanner();
      } else {
        _initInitialize();
      }
    });
  }

  void _initBanner() {
    _initBannerData();
    setState(() {
      _status = 2;
    });
  }

  // 初始化轮播数据
  void _initBannerData() {
    for (int i = 0, length = _guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(Stack(
          children: <Widget>[
            Image.asset(
              _guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ],
        ));
      } else {
        _bannerList.add(
          Image.asset(
            _guideList[i],
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        );
      }
    }
  }

  void _initInitialize() {
    if (_initializeModel == null) {
      _goMain();
    }
  }

  // 主页
  void _goMain() {
    RouteUtil.goMain(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
        ],
      ),
    );
  }

}
