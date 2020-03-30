import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:message/res/strings.dart';

// 关于页面
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(IntlUtil.getString(context, Ids.titleAbout)),
        centerTitle: true,
      ),
    );
  }
}