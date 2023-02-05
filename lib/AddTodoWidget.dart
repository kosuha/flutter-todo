import 'package:flutter/material.dart';
import 'WriteModalWidget.dart';

class AddTodoWidget extends StatelessWidget {
  const AddTodoWidget(
      {Key? key,
      required this.setAddState,
      required this.setTodoList,
      required this.getTodoList,
      required this.todoListScrollController,
      required this.year,
      required this.month,
      required this.day})
      : super(key: key);

  final Function setTodoList;
  final Function setAddState;
  final Function getTodoList;
  final ScrollController todoListScrollController;
  final int year;
  final int month;
  final int day;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        setAddState(true);
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter bottomState) {
                return WriteModalWidget(
                  todoListScrollController: todoListScrollController,
                  year: year,
                  month: month,
                  day: day,
                  setTodoList: setTodoList,
                );
              });
            }).whenComplete(() {
          setAddState(false);
        });
      },
      backgroundColor: Color(0xffffffff),
      foregroundColor: Color(0xff000000),
      child: Icon(Icons.add),
    );
  }
}
