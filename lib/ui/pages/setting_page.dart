import 'package:base_library/base_library.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:message/blocs/application_bloc.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/common/common.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/res/colors.dart';
import 'package:message/res/strings.dart';
import 'package:message/ui/pages/language_page.dart';
import 'package:message/utils/navigator_util.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    LanguageModel languageModel = SpUtil.getObj(
      Constant.keyLanguage,
      (v) => LanguageModel.fromJson(v),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          IntlUtil.getString(context, Ids.titleSetting),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.color_lens,
                  color: Colours.gray_66,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    IntlUtil.getString(context, Ids.titleTheme),
                  ),
                )
              ],
            ),
            children: <Widget>[
              // 包装主题样式
              Wrap(
                children: themeColorMap.keys.map(
                  (String key) {
                    Color value = themeColorMap[key];
                    return InkWell(
                      onTap: () {
                        SpUtil.putString(Constant.key_theme_color, key);
                        // 发送事件到bloc
                        bloc.sendAppEvent(Constant.type_sys_update);
                      },
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        width: 36.0,
                        height: 36.0,
                        color: value,
                      ),
                    );
                  },
                ).toList(),
              )
            ],
          ),
          // 多语言
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.language,
                  color: Colours.gray_66,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    IntlUtil.getString(context, Ids.titleLanguage),
                  ),
                )
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  languageModel == null
                      ? IntlUtil.getString(context, Ids.languageAuto)
                      : IntlUtil.getString(context, languageModel.titleId,
                          languageCode: 'zh', countryCode: 'CH'),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colours.gray_99,
                  ),
                ),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
            // 跳转语言页面
            onTap: () {
              NavigatorUtil.pushPage(
                context,
                LanguagePage(),
                pageName: Ids.titleLanguage,
              );
            },
          )
        ],
      ),
    );
  }
}
