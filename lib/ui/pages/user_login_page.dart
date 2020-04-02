import 'package:base_library/base_library.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:message/blocs/event.dart';
import 'package:message/common/common.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/data/repository/user_repository.dart';
import 'package:message/res/strings.dart';
import 'package:message/ui/pages/user_register_page.dart';
import 'package:message/utils/navigator_util.dart';
import 'package:rxdart/rxdart.dart';

// 用户登陆
class UserLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          IntlUtil.getString(context, Ids.user_login),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      resizeToAvoidBottomInset: false,
      body: LoginBody(),
    );
  }
}

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerName = TextEditingController();
    TextEditingController _controllerPwd = TextEditingController();
    UserRepository userRepository = UserRepository();
    UserModel userModel =
        SpUtil.getObj(BaseConstant.keyUserModel, (v) => UserModel.fromJson(v));
    _controllerName.text = userModel?.username ?? "";

    void _userLogin() {
      String username = _controllerName.text;
      String password = _controllerPwd.text;
      if (username.isEmpty || username.length < 2) {
        Util.showSnackBar(context, username.isEmpty ? "请输入用户名" : "用户名至少2位");
        return;
      }
      if (password.isEmpty || password.length < 6) {
        Util.showSnackBar(context, username.isEmpty ? "请输入密码" : "密码至少6位");
        return;
      }
      LoginReq req = LoginReq(username, password);
      userRepository.login(req).then((UserModel model) {
        Util.showSnackBar(context, "登录成功");
        Observable.just(1).delay(Duration(milliseconds: 500)).listen((_) {
          Event.sendAppEvent(context, Constant.type_refresh_all);
          RouteUtil.goMain(context);
        });
      }).catchError((error) {
        Util.showSnackBar(context, error.toString());
      });
    }

    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
          margin: EdgeInsets.only(left: 20, top: 15, right: 20),
          child: Column(
            children: <Widget>[
              LoginItem(
                controller: _controllerName,
                prefixIcon: Icons.person,
                hintText: IntlUtil.getString(context, Ids.user_name),
              ),
              Gaps.vGap15,
              LoginItem(
                controller: _controllerPwd,
                prefixIcon: Icons.lock,
                hasSuffixIcon: true,
                hintText: IntlUtil.getString(context, Ids.user_pwd),
              ),
              RoundButton(
                text: IntlUtil.getString(context, Ids.user_login),
                margin: EdgeInsets.only(top: 20),
                onPressed: () {
                  _userLogin();
                },
              ),
              Gaps.vGap15,
              InkWell(
                onTap: () {
                  NavigatorUtil.pushPage(context, UserRegisterPage());
                },
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      style: TextStyle(fontSize: 14, color: Colours.text_gray),
                      text: IntlUtil.getString(
                        context,
                        Ids.user_new_user_hint,
                      ),
                    ),
                    TextSpan(
                      style: TextStyle(
                          fontSize: 14, color: Theme.of(context).primaryColor),
                      text: IntlUtil.getString(
                        context,
                        Ids.user_register,
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}
