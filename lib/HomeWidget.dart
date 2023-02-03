import 'package:flutter/material.dart';
import 'CalendarWidget.dart';
import 'TodoWidget.dart';
import 'AddTodoWidget.dart';
import 'WriteTodoWidget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  bool addState = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenList = [
      CalendarWidget(),
      TodoWidget(),
    ];

    if (addState) {
      childrenList.add(WriteTodoWidget());
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: childrenList,
        ),
      ),
      floatingActionButton: Offstage(
          offstage: addState, child: AddTodoWidget(setAddState: setAddState)),
    );
  }

  void setAddState(bool state) {
    setState(() {
      addState = state;
    });
  }
}
