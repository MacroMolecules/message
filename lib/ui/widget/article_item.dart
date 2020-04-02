import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:message/data/protocol/modeels.dart';
import 'package:message/ui/widget/widgets.dart';
import 'package:message/utils/navigator_util.dart';
import 'package:message/utils/utils.dart';

// 文章
class ArticleItem extends StatelessWidget {
  ArticleItem(
    this.model, {
    Key key,
    this.labelId,
    this.isHome,
  }) : super(key: key);
  final ProjectModel model;
  final String labelId;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorUtil.pushWeb(
          context,
          title: model.title,
          url: model.link,
          isHome: isHome,
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.listTitle,
                ),
                Gaps.vGap10,
                Text(
                  model.desc,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.listContent,
                ),
                Gaps.vGap5,
                Row(
                  children: <Widget>[
                    LikeBtn(
                      labelId: labelId,
                      id: model.originId ?? model.id,
                      isLike: model.collect,
                    ),
                    Gaps.hGap10,
                    Text(
                      model.author,
                      style: TextStyles.listExtra,
                    ),
                    Gaps.hGap10,
                    Text(
                      Utils.getTimeLine(context, model.publishTime),
                      style: TextStyles.listExtra,
                    ),
                  ],
                )
              ],
            )),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 12.0),
              child: CircleAvatar(
                radius: 28.0,
                backgroundColor:
                    Utils.getCircleBg(model.superChapterName ?? "公众号"),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    model.superChapterName ?? "文章",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 11.0),
                  ),
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.33, color: Colours.divider),
        ),
      ),
    );
  }
}
