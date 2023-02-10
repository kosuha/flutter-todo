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
    Color listInDayColor = Color(0x00000000);
    if (widget.dailyList.isNotEmpty) {
      listInDayColor = Color(0x33000000);
    }
    return Container(
      width: (5 / 797 * Constant.kHeight),
      height: (5 / 797 * Constant.kHeight),
      decoration: BoxDecoration(color: listInDayColor),
    );
  }
}
