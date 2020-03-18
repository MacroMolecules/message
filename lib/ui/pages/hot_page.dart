import 'package:flutter/material.dart';

class HotPage extends StatefulWidget {
  HotPage({Key key, this.labelId}) : super(key: key);

  String labelId;

  @override
  _HotPageState createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('热门'),),
    );
  }
}