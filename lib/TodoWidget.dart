import 'package:flutter/material.dart';

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
      //   border: Border(top: BorderSide(color: Color(0xff000000))),
      // ),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Text("Todo..."),
        ],
      ),
    );
  }
}
