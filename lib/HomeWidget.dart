import 'package:flutter/material.dart';
import 'package:laum/database/Todo.dart';
import 'CalendarWidget.dart';
import 'TodoWidget.dart';
import 'AddTodoWidget.dart';
import 'database/TodoProvider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  static DateTime now = DateTime.now();
  int year = 0;
  int month = 0;
  int day = 0;
  bool addState = false;
  List<Todo> todoList = [];

  @override
  void initState() {
    super.initState();
    year = now.year;
    month = now.month;
    day = now.day;
    addState = false;

    setTodoList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenList = [
      Container(
        height: MediaQuery.of(context).padding.top,
      ),
      Offstage(
        offstage: addState,
        child: CalendarWidget(
          year: year,
          month: month,
          day: day,
        ),
      ),
      GestureDetector(
        onTap: () {
          setAddState(false);
        },
        child: TodoWidget(
          getTodoList: getTodoList,
          setTodoChecked: setTodoChecked,
          year: year,
          month: month,
          day: day,
        ),
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: childrenList,
        ),
      ),
      floatingActionButton: AddTodoWidget(
        setAddState: setAddState,
        getTodoList: getTodoList,
        setTodoList: setTodoList,
        year: year,
        month: month,
        day: day,
      ),
    );
  }

  void setAddState(bool state) {
    setState(() {
      addState = state;
    });
  }

  void setYear(int yearTo) {
    setState(() {
      year = yearTo;
    });
  }

  void setMonth(int monthTo) {
    setState(() {
      month = monthTo;
    });
  }

  void setDay(int dayTo) {
    setState(() {
      day = dayTo;
    });
  }

  void setTodoList() async {
    TodoProvider todoProvider = TodoProvider();

    final Future<List<Todo>> todos =
        todoProvider.getListByDate(DateTime(year, month, day).toString());
    List<Todo> newTodoList = [];

    for (Todo t in (await todos)) {
      newTodoList.add(t);
    }
    setState(() {
      todoList = newTodoList;
    });
  }

  List<Todo> getTodoList() {
    return todoList;
  }

  void setTodoChecked(int id, int checked) {
    for (Todo e in todoList) {
      if (e.id == id) {
        TodoProvider todoProvider = TodoProvider();
        setState(() {
          e.done = checked;
        });
        todoProvider.setDoneById(id, checked);
        return;
      }
    }
  }
}
