import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:message/res/strings.dart';

class SharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          IntlUtil.getString(context, Ids.titleShare),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
    );
  }
}
