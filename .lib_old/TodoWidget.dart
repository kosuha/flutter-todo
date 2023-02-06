import 'package:flutter/material.dart';
import 'TodoListWidget.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({
    Key? key,
    required this.getTodoList,
    required this.setTodoChecked,
    required this.todoListScrollController,
    required this.addState,
  }) : super(key: key);

  final Function getTodoList;
  final Function setTodoChecked;
  final ScrollController todoListScrollController;
  final bool addState;

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
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
      child: SingleChildScrollView(
        controller: widget.todoListScrollController,
        child: TodoListWidget(
          getTodoList: widget.getTodoList,
          setTodoChecked: widget.setTodoChecked,
        ),
      ),
    );
  }
}
