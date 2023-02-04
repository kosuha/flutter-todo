import 'package:flutter/material.dart';
import 'TodoListWidget.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget(
      {Key? key,
      required this.getTodoList,
      required this.year,
      required this.month,
      required this.day})
      : super(key: key);

  final Function getTodoList;
  final int year;
  final int month;
  final int day;

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
      height: (MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top) *
          0.5,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Color(0xffff0000)),
      // ),

      child: SingleChildScrollView(
        child: TodoListWidget(
          getTodoList: widget.getTodoList,
          year: widget.year,
          month: widget.month,
          day: widget.day,
        ),
      ),
    );
  }
}
