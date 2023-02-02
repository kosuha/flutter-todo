import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomeWidget.dart';
import 'SettingWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Todo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MainWidget(),
    );
  }
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: HomeWidget(),
    );
  }
}
