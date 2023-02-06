import 'package:flutter/material.dart';
import '../bloc/calendar_bloc.dart';
import '../bloc/daily_list_bloc.dart';
import '../components/calendar_view.dart';
import '../components/daily_list_view.dart';
import 'package:laum/model/todo.dart';
import '../model/todo_provider.dart';

late CalendarBloc calendarBloc;
late DailyListBloc dailyListBloc;

class BlocDisplayWidget extends StatefulWidget {
  const BlocDisplayWidget({Key? key}) : super(key: key);

  @override
  _BlocDisplayWidgetState createState() => _BlocDisplayWidgetState();
}

class _BlocDisplayWidgetState extends State<BlocDisplayWidget> {
  // initState() : 위젯이 생성될 때 처음으로 호출되는 메서드
  // initState()을 통해 CountBloc()을 생성
  // late List<Todo> initialDailyList;

  @override
  void initState() {
    super.initState();
    calendarBloc = CalendarBloc();
    dailyListBloc = DailyListBloc();
    // setInitialDailyList();
  }

  // dispose(): 위젯이 종료될 때 호출되는 메서드
  // dispose()을 통해 countBloc을 종료시켜 메모리 누수를 방지한다.
  @override
  void dispose() {
    super.dispose();
    calendarBloc.dispose();
    dailyListBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            Container(
              child: Column(children: [
                CalendarView(onTabEvent: onTapDateEvent),
                DailyListView(),
              ]),
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              calendarBloc.addDisplayMonth();
            },
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              calendarBloc.subtractDisplayMonth();
            },
          )
        ],
      ),
    );
  }

  void onTapDateEvent(DateTime tabDate) {
    calendarBloc.setSelectedDate(tabDate);
    dailyListBloc.getDailyList(tabDate);
  }

  // void setInitialDailyList() async {
  //   TodoProvider todoProvider = TodoProvider();

  //   final Future<List<Todo>> todos =
  //       todoProvider.getListByDate(DateTime.now().toString());
  //   List<Todo> newTodoList = [];

  //   for (Todo t in (await todos)) {
  //     newTodoList.add(t);
  //   }
  //   setState(() {
  //     initialDailyList = newTodoList;
  //   });
  // }
}
