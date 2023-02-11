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
