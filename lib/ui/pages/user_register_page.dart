import 'package:base_library/base_library.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:message/blocs/event.dart';
import 'package:message/common/common.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/data/repository/user_repository.dart';
import 'package:message/res/strings.dart';
import 'package:rxdart/rxdart.dart';

// 用户注册
class UserRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          IntlUtil.getString(context, Ids.user_register),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      resizeToAvoidBottomInset: false,
      body: UserRegisterBody(),
    );
  }
}

class UserRegisterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerName = TextEditingController();
    TextEditingController _controllerPwd = TextEditingController();
    TextEditingController _controllerRePwd = TextEditingController();
    UserRepository userRepository = UserRepository();

    void _userRegister() {
      String username = _controllerName.text;
      String password = _controllerPwd.text;
      String passwordRe = _controllerRePwd.text;
      if (username.isEmpty || username.length < 2) {
        Util.showSnackBar(context, username.isEmpty ? "请输入用户名" : "用户名至少2位");
        return;
      }
      if (password.isEmpty || password.length < 6) {
        Util.showSnackBar(context, password.isEmpty ? "请输入密码" : "密码至少6位");
        return;
      }
      if (passwordRe.isEmpty || passwordRe.length < 6) {
        Util.showSnackBar(context, passwordRe.isEmpty ? "请确认输入密码" : "密码至少6位");
        return;
      }
      if (password != passwordRe) {
        Util.showSnackBar(context, "密码不一致");
        return;
      }

      RegisterReq req = RegisterReq(username, password, passwordRe);
      userRepository.register(req).then((UserModel model) {
        Util.showSnackBar(context, "注册成功");
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
              Gaps.vGap10,
              LoginItem(
                controller: _controllerPwd,
                prefixIcon: Icons.lock,
                hintText: IntlUtil.getString(context, Ids.user_pwd),
              ),
              Gaps.vGap10,
              LoginItem(
                controller: _controllerRePwd,
                prefixIcon: Icons.lock,
                hintText: IntlUtil.getString(context, Ids.user_re_pwd),
              ),
              RoundButton(
                text: IntlUtil.getString(context, Ids.user_register),
                margin: EdgeInsets.only(top: 20),
                onPressed: () {
                  _userRegister();
                },
              ),
            ],
          ),
        )),
      ],
    );
  }
}
