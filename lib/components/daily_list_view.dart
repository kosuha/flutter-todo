import 'package:flutter/material.dart';
import '../ui/bloc_display_widget.dart';
import '../model/todo.dart';
import '../model/todo_provider.dart';
import 'text_input_view.dart';
import 'daily_todo_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DailyListView extends StatelessWidget {
  const DailyListView({
    required this.textWriteState,
    required this.setTextWriteState,
    Key? key,
  }) : super(key: key);

  final Function setTextWriteState;
  final bool textWriteState;

  @override
  Widget build(BuildContext context) {
    final dailyListScrollController = ScrollController();
    Map displayMonth = calendarBloc.getDisplayMonth();
    int keyInt = 0;

    List<Widget> listTodo = [];

    for (Todo todo in displayMonth["list"]) {
      if (todo.date.year == displayMonth["selectedDate"].year &&
          todo.date.month == displayMonth["selectedDate"].month &&
          todo.date.day == displayMonth["selectedDate"].day) {
        listTodo.add(Slidable(
          key: Key("${DateTime.now().microsecondsSinceEpoch} ${keyInt++}"),
          endActionPane: ActionPane(
            extentRatio: 0.2,
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                autoClose: true,
                onPressed: (BuildContext context) {
                  calendarBloc.deleteTodo(todo.since);
                },
                backgroundColor: Color(0xffff0000),
                foregroundColor: Colors.white,
                icon: Icons.delete_forever_rounded,
              ),
            ],
          ),
          child: DailyTodoView(todo: todo),
        ));
      }
    }
    if (textWriteState) {
      listTodo.add(TextInputView(
          dailyListScrollController: dailyListScrollController,
          setTextWriteState: setTextWriteState));
    }
    return SingleChildScrollView(
        controller: dailyListScrollController,
        child: Column(
          children: listTodo,
        ));
  }

  Future<List<Todo>> setInitialDailyList() async {
    TodoProvider todoProvider = TodoProvider();
    DateTime now = DateTime.now();

    final List<Todo> todos = await todoProvider.getListByDay(now);
    return todos;
  }
}
