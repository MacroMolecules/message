import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/res/strings.dart';
import 'package:message/utils/navigator_util.dart';
import 'package:message/utils/utils.dart';

class TreeItem extends StatelessWidget {
  TreeItem(
    this.model, {
    Key key,
  }) : super(key: key);

  final TreeModel model;

  @override
  Widget build(BuildContext context) {
    final List<Widget> chips = model.children.map<Widget>((TreeModel _model) {
      return Chip(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        key: ValueKey<String>(_model.name),
        backgroundColor: Utils.getChipBgColor(_model.name),
        label: Text(
          _model.name,
          style: TextStyle(fontSize: 14.0),
        ),
      );
    }).toList();

    return InkWell(
      onTap: () {
        NavigatorUtil.pushRecommendPage(context,
            labelId: Ids.titleSystemTree, title: model.name, treeModel: model);
      },
      child: _ChipsTile(
        label: model.name,
        children: chips,
      ),
    );
  }
}

class _ChipsTile extends StatelessWidget {
  _ChipsTile({
    Key key,
    this.label,
    this.children,
  }) : super(key: key);

  final String label;
  final List<Widget> children;

  // 包装一个列表
  @override
  Widget build(BuildContext context) {
    List<Widget> cardChildren = <Widget>[
      Text(
        label,
        style: TextStyles.listTitle,
      ),
      Gaps.vGap10
    ];
    cardChildren.add(
      Wrap(
        children: children.map((Widget chip) {
          return Padding(
            padding: EdgeInsets.all(3.0),
            child: chip,
          );
        }).toList(),
      ),
    );

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: cardChildren,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.33, color: Colours.divider),
        ),
      ),
    );
  }
}
