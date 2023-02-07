import 'package:flutter/material.dart';
import '../ui/bloc_display_widget.dart';
import '../model/todo.dart';
import '../model/todo_provider.dart';

class DailyListView extends StatelessWidget {
  const DailyListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setInitialDailyList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Todo> todos = snapshot.data;

          return StreamBuilder(
            stream: dailyListBloc.dailyList,
            initialData: todos,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<Widget> listTodo = [];

                for (Todo todo in snapshot.data) {
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
                            dailyListBloc.getDailyList(todo.date);
                          }),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              todo.data,
                              // style: textStyle,
                            )),
                      ),
                    ],
                  ));
                }
                return Column(
                  children: listTodo,
                );
              }
              return Text("loading...");
            },
          );
        }
        return Text("loading...");
      },
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
