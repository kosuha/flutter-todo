import 'package:flutter/material.dart';
import 'package:laum/model/todo.dart';
import '../ui/bloc_display_widget.dart';

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
    // setIsDailyList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color listInDayColor = Color(0x00000000);
    print(widget.dailyList);
    if (widget.dailyList.isNotEmpty) {
      listInDayColor = Color(0x33000000);
    }
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(color: listInDayColor),
    );
  }

  // setIsDailyList() async {
  //   bool temp = await dailyListBloc.isDailyList(
  //       DateTime(widget.day["year"], widget.day["month"], widget.day["day"]));
  //   setState(() {
  //     isList = temp;
  //   });
  // }
}
