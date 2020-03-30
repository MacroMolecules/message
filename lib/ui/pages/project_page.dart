import 'package:flutter/material.dart';

class ProjectPage extends StatelessWidget {
  ProjectPage({Key key, this.labelId}) : super(key: key);

  final String labelId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('项目'),
      ),
    );
  }
}
