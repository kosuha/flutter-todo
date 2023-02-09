import 'dart:async';
import 'package:flutter/material.dart';
import '../ui/bloc_display_widget.dart';
import '../model/todo.dart';

class DailyTodoView extends StatefulWidget {
  const DailyTodoView({
    required this.todo,
    // required this.setTextWriteState,
    Key? key,
  }) : super(key: key);

  final Todo todo;
  // final Function setTextWriteState;

  @override
  _DailyTodoViewState createState() => _DailyTodoViewState();
}

class _DailyTodoViewState extends State<DailyTodoView> {
  bool optionState = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 16);
    if (widget.todo.done == 1) {
      textStyle =
          TextStyle(fontSize: 16, decoration: TextDecoration.lineThrough);
    } else {
      TextStyle(fontSize: 16);
    }

    Color borderColor = Color(0xff000000);

    if (optionState) {
      borderColor = Color(0xff000000);
    } else {
      borderColor = Color(0x00000000);
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Checkbox(
                activeColor: Color(0x00000000),
                checkColor: Color(0xff00ff00),
                side: BorderSide(color: Color(0xff000000)),
                value: isTrue(widget.todo.done),
                onChanged: (value) {
                  int checked = 0;
                  if (value == true) {
                    checked = 1;
                  } else {
                    checked = 0;
                  }
                  calendarBloc.setDone(widget.todo.id, checked);
                }),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  print("edit");
                },
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      widget.todo.data,
                      style: textStyle,
                    )),
              ),
            ),
            // Offstage(
            //   offstage: !optionState,
            //   child: Container(
            //     padding: EdgeInsets.all(10),
            //     child: Row(
            //       children: [
            //         TextButton(onPressed: null, child: Text("Edit")),
            //         TextButton(
            //             onPressed: () {
            //               dailyListBloc.deleteTodo(widget.todo.id);
            //             },
            //             child: Text("Delete"))
            //       ],
            //     ),
            //   ),
            // )
          ],
        ));
  }

  bool isTrue(int n) {
    if (n == 0) {
      return false;
    } else {
      return true;
    }
  }
}