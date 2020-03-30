import 'package:flutter/material.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/utils/navigator_util.dart';

class MessageItem extends StatelessWidget {
  const MessageItem(
    this.model, {
    this.labelId,
    Key key,
    this.isHome,
  }) : super(key: key);
  final String labelId;
  final ProjectModel model;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorUtil.pushWeb(context,
            title: model.title, url: model.link, isHome: isHome);
      },
      child: Container(
        height: 100.0,
        padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(),
            ),
          ],
        ),
      ),
    );
  }
}
