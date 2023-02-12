import 'package:flutter/material.dart';
import '../ui/bloc_display_widget.dart';
import 'calendar_day_dot_view.dart';
import '../model/todo.dart';
import '../bloc/constants.dart';

class CalendarDayView extends StatelessWidget {
  const CalendarDayView({
    Key? key,
    required this.day,
    required this.onTabEvent,
  }) : super(key: key);

  final Map day;
  final Function onTabEvent;

  @override
  Widget build(BuildContext context) {
    Map displayMonth = calendarBloc.getDisplayMonth();
    bool isSelectedDay = false;
    List<Todo> dailyList = [];

    isSelectedDay = (displayMonth["selectedDate"].year == day["year"] &&
        displayMonth["selectedDate"].month == day["month"] &&
        displayMonth["selectedDate"].day == day["day"]);
    for (Todo todo in displayMonth["list"]) {
      if (todo.date.year == day["year"] &&
          todo.date.month == day["month"] &&
          todo.date.day == day["day"]) {
        dailyList.add(todo);
      }
    }

    DateTime now = DateTime.now();
    bool isToday = (now.year == day["year"] &&
        now.month == day["month"] &&
        now.day == day["day"]);
    int weekday = DateTime(day["year"], day["month"], day["day"]).weekday;
    Color dayColor = Color(0xffffffff);

    if (weekday == 7 || weekday == 6) {
      dayColor = Color(0xff808080);
    } else {
      dayColor = Color(0xffffffff);
    }

    TextStyle textStyle = TextStyle(
        color: dayColor,
        fontSize: Constant.getSize(16.0),
        fontWeight: FontWeight.w400);
    BoxDecoration boxDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0x00ffffff),
    );

    if (isSelectedDay) {
      boxDecoration = BoxDecoration(
          color: Color(0x00ffffff),
          shape: BoxShape.circle,
          border: Border.all(color: Color(0xffffffff)));
    }

    if (isToday) {
      textStyle = TextStyle(
        color: Color(0xff00ff00),
        fontSize: Constant.getSize(16.0),
        fontWeight: FontWeight.w700,
      );
    }

    if (!day["inMonth"]) {
      boxDecoration = BoxDecoration(color: Color(0x00ffffff));
      textStyle =
          TextStyle(color: Color(0x00ffffff), fontSize: Constant.getSize(16.0));
    }

    return GestureDetector(
      onTap: () {
        if (day["inMonth"]) {
          onTabEvent(DateTime(day["year"], day["month"], day["day"]));
        }
      },
      child: Container(
          alignment: Alignment.center,
          height: Constant.getSize(50.0),
          width: Constant.getSize(50.0),
          margin: EdgeInsets.all(Constant.getSize(1.0)),
          decoration: boxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: Constant.getSize(3.0)),
                width: Constant.getSize(5.0),
                height: Constant.getSize(5.0),
                decoration: BoxDecoration(color: Color(0x00ffffff)),
              ),
              Text(
                "${day["day"]}",
                style: textStyle,
              ),
              CalendarDayDotView(
                dailyList: dailyList,
              ),
            ],
          )),
    );
  }
}
