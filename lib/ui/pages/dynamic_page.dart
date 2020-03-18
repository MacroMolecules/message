import 'package:flutter/material.dart';

class DynamicPage extends StatefulWidget {
  DynamicPage({Key key, this.labelId}) : super(key: key);

  String labelId;

  @override
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('动态'),),
    );
  }
}