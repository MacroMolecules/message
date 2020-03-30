import 'package:flutter/material.dart';

class DynamicPage extends StatelessWidget {
  DynamicPage({
    Key key,
    this.labelId,
  }) : super(key: key);

  final String labelId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('动态'),
      ),
    );
  }
}
