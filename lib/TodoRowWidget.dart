import 'package:flutter/material.dart';
import 'database/Todo.dart';
import 'database/TodoProvider.dart';

class TodoRowWidget extends StatefulWidget {
  // const TodoRowWidget({super.key});
  const TodoRowWidget({
    Key? key,
    required this.todo,
    required this.setTodoChecked,
  }) : super(key: key);

  final Todo todo;
  final Function setTodoChecked;

  @override
  State<TodoRowWidget> createState() => TodoRowWidgetState();
}

class TodoRowWidgetState extends State<TodoRowWidget> {
  @override
  void initState() {
    super.initState();
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

    return Flex(
      direction: Axis.horizontal,
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
              widget.setTodoChecked(widget.todo.id, checked);
            }),
        Expanded(
          child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Text(
                widget.todo.data,
                style: textStyle,
              )),
        ),
      ],
    );
  }

  bool isTrue(int n) {
    if (n == 0) {
      return false;
    } else {
      return true;
    }
  }
}
