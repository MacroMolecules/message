import 'package:base_library/base_library.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:message/blocs/application_bloc.dart';
import 'package:message/blocs/bloc_provider.dart';
import 'package:message/common/common.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/res/strings.dart';

class LanguagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LanguagePageState();
  }
}

class _LanguagePageState extends State<LanguagePage> {
  List<LanguageModel> _list = List();

  LanguageModel _currentLanguage;

  @override
  void initState() {
    super.initState();
    // 跟随系统
    _list.add(LanguageModel(Ids.languageAuto, '', ''));
    // 中文
    _list.add(LanguageModel(Ids.languageZH, 'zh', 'CH'));
    // 英文
    _list.add(LanguageModel(Ids.languageEN, 'en', 'US'));
    // 当前语言
    _currentLanguage =
        SpUtil.getObj(Constant.keyLanguage, (v) => LanguageModel.fromJson(v));
    if (ObjectUtil.isEmpty(_currentLanguage)) {
      _currentLanguage = _list[0];
    }

    _updateData();
  }

  // 更新数据
  void _updateData() {
    String language = _currentLanguage.countryCode;
    for (int i = 0, length = _list.length; i < length; i++) {
      _list[i].isSelected = (_list[i].countryCode == language);
    }
  }

  @override
  Widget build(BuildContext context) {
    ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          IntlUtil.getString(context, Ids.titleLanguage),
          style: TextStyle(fontSize: 16.0),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: SizedBox(
              width: 64.0,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.indigoAccent,
                child: Text(
                  IntlUtil.getString(context, Ids.save),
                  style: TextStyle(fontSize: 12.0),
                ),
                onPressed: () {
                  SpUtil.putObject(
                      Constant.keyLanguage,
                      ObjectUtil.isEmpty(_currentLanguage.languageCode)
                          ? null
                          : _currentLanguage);
                  bloc.sendAppEvent(Constant.type_sys_update);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          LanguageModel model = _list[index];
          return ListTile(
            title: Text(
              (model.titleId == Ids.languageAuto
                  ? IntlUtil.getString(
                      context,
                      model.titleId,
                    )
                  : IntlUtil.getString(
                      context,
                      model.titleId,
                      languageCode: 'zh',
                      countryCode: 'CH',
                    )),
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),
            trailing: Radio(
              value: true,
              groupValue: model.isSelected == true,
              activeColor: Colors.indigoAccent,
              onChanged: (value) {
                setState(
                  () {
                    _currentLanguage = model;
                    _updateData();
                  },
                );
              },
            ),
            onTap: () {
              setState(
                () {
                  _currentLanguage = model;
                  _updateData();
                },
              );
            },
          );
        },
      ),
    );
  }
}
