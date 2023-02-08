import 'package:flutter/material.dart';
import '../ui/bloc_display_widget.dart';
import '../model/todo.dart';
import '../model/todo_provider.dart';
import 'text_input_view.dart';

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
    return SingleChildScrollView(
      controller: dailyListScrollController,
      child: StreamBuilder(
        stream: dailyListBloc.dailyList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Widget> listTodo = [];

            for (Todo todo in snapshot.data) {
              TextStyle textStyle = TextStyle(fontSize: 16);
              if (todo.done == 1) {
                textStyle = TextStyle(
                    fontSize: 16, decoration: TextDecoration.lineThrough);
              } else {
                TextStyle(fontSize: 16);
              }

              listTodo.add(Row(
                children: [
                  Checkbox(
                      activeColor: Color(0x00000000),
                      checkColor: Color(0xff00ff00),
                      side: BorderSide(color: Color(0xff000000)),
                      value: isTrue(todo.done),
                      onChanged: (value) {
                        int checked = 0;
                        if (value == true) {
                          checked = 1;
                        } else {
                          checked = 0;
                        }
                        dailyListBloc.setDone(todo.id, checked);
                      }),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          todo.data,
                          style: textStyle,
                        )),
                  ),
                ],
              ));
            }
            if (textWriteState) {
              listTodo.add(TextInputView(
                  dailyListScrollController: dailyListScrollController,
                  setTextWriteState: setTextWriteState));
            }
            return Column(
              children: listTodo,
            );
          }
          return Text("loading...");
        },
      ),
    );
  }

  Future<List<Todo>> setInitialDailyList() async {
    TodoProvider todoProvider = TodoProvider();
    DateTime now = DateTime.now();

    final List<Todo> todos = await todoProvider
        .getListByDate(DateTime(now.year, now.month, now.day).toString());
    return todos;
  }

  bool isTrue(int n) {
    if (n == 0) {
      return false;
    } else {
      return true;
    }
  }
}
