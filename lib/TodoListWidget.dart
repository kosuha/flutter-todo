import 'package:flutter/material.dart';
import 'database/Todo.dart';
import 'TodoRowWidget.dart';
import 'database/TodoProvider.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget(
      {Key? key,
      required this.getTodoList,
      required this.setTodoChecked,
      required this.year,
      required this.month,
      required this.day})
      : super(key: key);

  final Function getTodoList;
  final Function setTodoChecked;
  final int year;
  final int month;
  final int day;

  @override
  Widget build(BuildContext context) {
    List<Widget> todoList = [];
    final List<Todo> todos = getTodoList();

    for (Todo t in todos) {
      todoList.add(TodoRowWidget(
        todo: t,
        setTodoChecked: setTodoChecked,
      ));
    }

    todoList.add(Container(
      height: MediaQuery.of(context).padding.top,
    ));

    return Column(
      children: todoList,
    );
  }
}
