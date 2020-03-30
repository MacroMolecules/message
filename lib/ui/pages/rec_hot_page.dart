import 'package:flutter/material.dart';

class RecHotPage extends StatelessWidget {
  RecHotPage({
    Key key,
    this.title,
    this.titleId,
  }) : super(key: key);

  final String title;
  final String titleId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
      ),
    );
  }
}
