import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({Key key, this.labelId}) : super(key: key);

  String labelId;

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('项目'),),
    );
  }
}