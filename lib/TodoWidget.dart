import 'package:flutter/material.dart';
import 'TodoRowWidget.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({super.key});

  @override
  State<TodoWidget> createState() => TodoWidgetState();
}

class TodoWidgetState extends State<TodoWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Color(0xffff0000)),
      // ),
      child: Column(
        children: [
          TodoRowWidget(),
        ],
      ),
    );
  }
}
