import 'package:flutter/material.dart';
import 'database/Todo.dart';
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
  final ScrollController todoListScrollController = ScrollController();
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
          setDate: setDate,
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
          todoListScrollController: todoListScrollController,
          addState: addState,
        ),
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity! > 0) {
              setDate(year, month, day - 1);
            } else if (details.primaryVelocity! < 0) {
              setDate(year, month, day + 1);
            }
          },
          child: Column(
            children: childrenList,
          ),
        ),
      ),
      floatingActionButton: AddTodoWidget(
        setAddState: setAddState,
        getTodoList: getTodoList,
        setTodoList: setTodoList,
        todoListScrollController: todoListScrollController,
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

  void setDate(int yearTo, int monthTo, int dayTo) {
    DateTime date = DateTime(yearTo, monthTo, dayTo);

    setState(() {
      year = date.year;
      month = date.month;
      day = date.day;
    });
    setTodoList();
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
      addState = addState;
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
