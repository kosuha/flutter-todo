import 'package:flutter/material.dart';
import '../ui/bloc_display_widget.dart';
import 'calendar_day_dot_view.dart';
import '../model/todo.dart';

class CalendarDayView extends StatelessWidget {
  const CalendarDayView({
    Key? key,
    required this.displayMonth,
    required this.day,
    required this.onTabEvent,
  }) : super(key: key);

  final Map displayMonth;
  final Map day;
  final Function onTabEvent;

  @override
  Widget build(BuildContext context) {
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
    Color dayColor = Color(0xff000000);

    if (weekday == 7 || weekday == 6) {
      dayColor = Color(0xff808080);
    } else {
      dayColor = Color(0xff000000);
    }

    TextStyle textStyle =
        TextStyle(color: dayColor, fontSize: 16, fontWeight: FontWeight.w400);
    BoxDecoration boxDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0x00000000),
    );

    if (isSelectedDay) {
      boxDecoration = BoxDecoration(
          color: Color(0xffffffff),
          shape: BoxShape.circle,
          border: Border.all(color: Color(0xff000000)));
    }

    if (isToday) {
      textStyle = TextStyle(
        color: Color(0xffff0000),
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );
    }

    if (!day["inMonth"]) {
      boxDecoration = BoxDecoration(color: Color(0x00000000));
      textStyle = TextStyle(color: Color(0x00000000), fontSize: 16);
    }

    return GestureDetector(
      onTap: () {
        if (day["inMonth"]) {
          onTabEvent(DateTime(day["year"], day["month"], day["day"]));
        }
      },
      child: Container(
          alignment: Alignment.center,
          height: 50,
          width: 50,
          margin: EdgeInsets.all(1.0),
          decoration: boxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(color: Color(0x00000000)),
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
