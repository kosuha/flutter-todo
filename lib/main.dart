import 'package:flutter/material.dart';
import 'ui/bloc_display_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Todo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: BlocDisplayWidget(),
    );
  }
}

/*

bloc: 데이터 처리


components: 처리된 데이터를 ui에 보내주기


ui: 화면을 그려줌

*/
