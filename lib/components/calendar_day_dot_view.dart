import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../bloc/constants.dart';

class CalendarDayDotView extends StatefulWidget {
  const CalendarDayDotView({
    Key? key,
    required this.dailyList,
  }) : super(key: key);

  final List<Todo> dailyList;

  @override
  _CalendarDayDotViewState createState() => _CalendarDayDotViewState();
}

class _CalendarDayDotViewState extends State<CalendarDayDotView> {
  bool isList = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color listInDayColor = Color(0x00ffffff);
    if (widget.dailyList.isNotEmpty) {
      listInDayColor = Color(0xffffffff);
    }
    return Container(
      margin: EdgeInsets.only(
        top: Constant.getSize(3.0),
      ),
      width: Constant.getSize(5.0),
      height: Constant.getSize(5.0),
      decoration: BoxDecoration(color: listInDayColor),
    );
  }
}
