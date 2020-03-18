import 'package:flutter/material.dart';

class SystemPage extends StatefulWidget {
  SystemPage({Key key, this.labelId}) : super(key: key);

  String labelId;

  @override
  _SystemPageState createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('体系'),),
    );
  }
}