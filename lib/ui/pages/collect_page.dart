import 'package:flutter/material.dart';

class CollectPage extends StatelessWidget {
  CollectPage({Key key, this.labelId}) : super(key: key);

  final String labelId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('收藏'),
      ),
    );
  }
}
