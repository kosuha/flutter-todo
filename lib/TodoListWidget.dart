import 'package:flutter/material.dart';
import 'database/Todo.dart';
import 'TodoRowWidget.dart';
import 'database/TodoProvider.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget(
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
  Widget build(BuildContext context) {
    List<Widget> todoList = [];

    final List<Todo> todos = getTodoList();
    bool doneBool;

    for (Todo t in todos) {
      if (t.done == 1) {
        doneBool = true;
      } else {
        doneBool = false;
      }
      todoList.add(TodoRowWidget(done: doneBool, text: t.data));
    }

    todoList.add(Container(
      height: MediaQuery.of(context).padding.top,
    ));

    return Column(
      children: todoList,
    );
  }

  Future _future(context) async {
    List<Widget> todoList = [];
    TodoProvider todoProvider = TodoProvider();

    final Future<List<Todo>> todos =
        todoProvider.getDB(DateTime(year, month, day).toString());
    bool doneBool;

    for (Todo t in (await todos)) {
      if (t.done == 1) {
        doneBool = true;
      } else {
        doneBool = false;
      }
      todoList.add(TodoRowWidget(done: doneBool, text: t.data));
    }

    todoList.add(Container(
      height: MediaQuery.of(context).padding.top,
    ));
    return Column(
      children: todoList,
    );
  }
}
