import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/blocs/main_bloc.dart';
import 'package:message/common/common.dart';
import 'package:message/ui/pages/user_login_page.dart';
import 'package:message/utils/navigator_util.dart';
import 'package:message/utils/utils.dart';

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}

// 点赞
class LikeBtn extends StatelessWidget {
  LikeBtn({
    Key key,
    this.labelId,
    this.id,
    this.isLike,
  }) : super(key: key);
  final String labelId;
  final int id;
  final bool isLike;

  @override
  Widget build(BuildContext context) {
    MainBloc bloc = BlocProvider.of<MainBloc>(context);
    return InkWell(
      // 如果登陆就添加到收藏 否则就跳转登陆页面
      onTap: () {
        if (Util.isLogin()) {
          bloc.doCollection(labelId, id, !isLike);
        } else {
          NavigatorUtil.pushPage(context, UserLoginPage(),
              pageName: "UserLoginPage");
        }
      },
      // 小红心
      child: Icon(
        Icons.favorite,
        color: (isLike == true && Util.isLogin())
            ? Colors.redAccent
            : Colours.gray_99,
      ),
    );
  }
}

// 状态视图
class StatusViews extends StatelessWidget {
  StatusViews(
    this.status, {
    Key key,
    this.onTap,
  }) : super(key: key);
  final int status;
  // 点击回调
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    // 开关状态
    switch (status) {
      // 失败
      case LoadStatus.fail:
        return Container(
          width: double.infinity,
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                onTap();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    Utils.getImgPath("ic_network_error"),
                    package: BaseConstant.packageBase,
                    width: 100,
                    height: 100,
                  ),
                  Gaps.vGap10,
                  Text(
                    "请您查看网络设置",
                    style: TextStyles.listContent,
                  ),
                  Gaps.vGap5,
                  Text(
                    "点击屏幕，重新加载",
                    style: TextStyles.listContent,
                  ),
                ],
              ),
            ),
          ),
        );
        break;
        // 加载中
      case LoadStatus.loading:
        return Container(
          alignment: Alignment.center,
          color: Colours.gray_f0,
          child: ProgressView(),
        );
        break;
        // 空的
      case LoadStatus.empty:
        return Container(
          color: Colors.white,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  Utils.getImgPath("ic_data_empty"),
                  package: BaseConstant.packageBase,
                  width: 60,
                  height: 60,
                ),
                Gaps.vGap10,
                Text(
                  "空空如也",
                  style: TextStyles.listContent2,
                ),
              ],
            ),
          ),
        );
        break;
      default:
        return Container();
        break;
    }
  }
}
