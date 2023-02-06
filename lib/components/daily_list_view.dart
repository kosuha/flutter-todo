import 'package:flutter/material.dart';
import '../ui/bloc_display_widget.dart';
import '../bloc/todo.dart';
import '../bloc/todo_provider.dart';

class DailyListView extends StatelessWidget {
  const DailyListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: dailyListBloc.dailyList,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Widget> listTodo = [];
            print("[snapshot.data]");
            print(snapshot.data);
            for (Todo todo in snapshot.data) {
              listTodo.add(Text(todo.data));
            }
            return Column(
              children: listTodo,
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
