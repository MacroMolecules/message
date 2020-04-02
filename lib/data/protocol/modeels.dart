import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';


class ComData {
  int size;
  List datas;

  ComData.fromJson(Map<String, dynamic> json)
      : size = json['size'],
        datas = json['datas'];
}

class ComReq {
  int cid;

  ComReq(this.cid);

  ComReq.fromJson(Map<String, dynamic> json) : cid = json['cid'];

  Map<String, dynamic> toJson() => {
        'cid': cid,
      };
}

class ComListResp<T> {
  int status;
  List<T> list;

  ComListResp(this.status, this.list);
}

class ProjectModel {
  int id;
  int originId;
  String title;
  String desc;
  String author;
  String link;
  String projectLink;
  String envelopePic;
  String superChapterName;
  int publishTime;
  bool collect;

  int type; //1项目，2文章
  bool isShowHeader;

  ProjectModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        originId = json['originId'],
        title = json['title'],
        desc = json['desc'],
        author = json['author'],
        link = json['link'],
        projectLink = json['projectLink'],
        envelopePic = json['envelopePic'],
        superChapterName = json['superChapterName'],
        publishTime = json['publishTime'],
        collect = json['collect'],
        type = json['type'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'originId': originId,
        'title': title,
        'desc': desc,
        'author': author,
        'link': link,
        'projectLink': projectLink,
        'envelopePic': envelopePic,
        'superChapterName': superChapterName,
        'publishTime': publishTime,
        'collect': collect,
        'type': type,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"id\":$id");
    sb.write(",\"originId\":$originId");
    sb.write(",\"title\":\"$title\"");
    sb.write(",\"desc\":\"$desc\"");
    sb.write(",\"author\":\"$author\"");
    sb.write(",\"link\":\"$link\"");
    sb.write(",\"projectLink\":\"$projectLink\"");
    sb.write(",\"envelopePic\":\"$envelopePic\"");
    sb.write(",\"superChapterName\":\"$superChapterName\"");
    sb.write(",\"publishTime\":\"$publishTime\"");
    sb.write(",\"collect\":$collect");
    sb.write(",\"type\":$type");
    sb.write('}');
    return sb.toString();
  }
}

class BannerModel {
  String title;
  int id;
  String url;
  String imagePath;

  BannerModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'],
        url = json['url'],
        imagePath = json['imagePath'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'url': url,
        'imagePath': imagePath,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"id\":$id");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"imagePath\":\"$imagePath\"");
    sb.write('}');
    return sb.toString();
  }
}

class TreeModel extends ISuspensionBean {
  String name;
  int id;
  List<TreeModel> children;
  String tagIndex;

  TreeModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        children = (json['children'] as List)
            ?.map((e) => e == null
                ? null
                : TreeModel.fromJson(e as Map<String, dynamic>))
            ?.toList();

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'children': children,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"name\":\"$name\"");
    sb.write(",\"id\":$id");
    sb.write(",\"children\":$children");
    sb.write('}');
    return sb.toString();
  }

  @override
  String getSuspensionTag() {
    return tagIndex;
  }
}

class LoginReq {
  String username;
  String password;

  LoginReq(this.username, this.password);

  LoginReq.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };

  @override
  String toString() {
    return '{' +
        " \"username\":\"" +
        username +
        "\"" +
        ", \"password\":\"" +
        password +
        "\"" +
        '}';
  }
}

class RegisterReq {
  String username;
  String password;
  String repassword;

  RegisterReq(this.username, this.password, this.repassword);

  RegisterReq.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'],
        repassword = json['repassword'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'repassword': repassword,
      };

  @override
  String toString() {
    return '{' +
        " \"username\":\"" +
        username +
        "\"" +
        ", \"password\":\"" +
        password +
        "\"" +
        ", \"repassword\":\"" +
        repassword +
        "\"" +
        '}';
  }
}

class UserModel {
  String email;
  String icon;
  int id;
  String username;
  String password;

  UserModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        icon = json['icon'],
        id = json['id'],
        username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'icon': icon,
        'id': id,
        'username': username,
        'password': password,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"email\":\"$email\"");
    sb.write(",\"icon\":\"$icon\"");
    sb.write(",\"id\":$id");
    sb.write(",\"username\":\"$username\"");
    sb.write(",\"password\":\"$password\"");
    sb.write('}');
    return sb.toString();
  }
}

class LanguageModel {
  String titleId;
  String languageCode;
  String countryCode;
  bool isSelected;

  LanguageModel(this.titleId, this.languageCode, this.countryCode,
      {this.isSelected: false});

  LanguageModel.fromJson(Map<String, dynamic> json)
      : titleId = json['titleId'],
        languageCode = json['languageCode'],
        countryCode = json['countryCode'],
        isSelected = json['isSelected'];

  Map<String, dynamic> toJson() => {
        'titleId': titleId,
        'languageCode': languageCode,
        'countryCode': countryCode,
        'isSelected': isSelected,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"titleId\":\"$titleId\"");
    sb.write(",\"languageCode\":\"$languageCode\"");
    sb.write(",\"countryCode\":\"$countryCode\"");
    sb.write('}');
    return sb.toString();
  }
}

class SplashModel {
  String title;
  String content;
  String url;
  String imgUrl;

  SplashModel({this.title, this.content, this.url, this.imgUrl});

  SplashModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        url = json['url'],
        imgUrl = json['imgUrl'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'url': url,
        'imgUrl': imgUrl,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"content\":\"$content\"");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"imgUrl\":\"$imgUrl\"");
    sb.write('}');
    return sb.toString();
  }
}

class VersionModel {
  String title;
  String content;
  String url;
  String version;

  VersionModel({this.title, this.content, this.url, this.version});

  VersionModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        url = json['url'],
        version = json['version'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'url': url,
        'version': version,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"content\":\"$content\"");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"version\":\"$version\"");
    sb.write('}');
    return sb.toString();
  }
}

class ComModel {
  String version;
  String title;
  String content;
  String extra;
  String url;
  String imgUrl;
  String author;
  String updatedAt;

  int typeId;
  String titleId;

  Widget page;

  ComModel(
      {this.version,
      this.title,
      this.content,
      this.extra,
      this.url,
      this.imgUrl,
      this.author,
      this.updatedAt,
      this.typeId,
      this.titleId,
      this.page});

  ComModel.fromJson(Map<String, dynamic> json)
      : version = json['version'],
        title = json['title'],
        content = json['content'],
        extra = json['extra'],
        url = json['url'],
        imgUrl = json['imgUrl'],
        author = json['author'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() => {
        'version': version,
        'title': title,
        'content': content,
        'extra': extra,
        'url': url,
        'imgUrl': imgUrl,
        'author': author,
        'updatedAt': updatedAt,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"version\":\"$version\"");
    sb.write(",\"title\":\"$title\"");
    sb.write(",\"content\":\"$content\"");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"imgUrl\":\"$imgUrl\"");
    sb.write(",\"author\":\"$author\"");
    sb.write(",\"updatedAt\":\"$updatedAt\"");
    sb.write('}');
    return sb.toString();
  }
}