import 'package:flutter/material.dart';
import '../ui/bloc_display_widget.dart';

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
    return StreamBuilder(
        stream: calendarBloc.selectedDate,
        initialData: DateTime.now(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          bool isSelectedDay = false;
          if (snapshot.hasData) {
            isSelectedDay = (snapshot.data.year == day["year"] &&
                snapshot.data.month == day["month"] &&
                snapshot.data.day == day["day"]);
          }

          DateTime now = DateTime.now();
          bool isToday = (now.year == day["year"] &&
              now.month == day["month"] &&
              now.day == day["day"]);
          int weekday = DateTime(day["year"], day["month"], day["day"]).weekday;
          Color dayColor = Color(0xff000000);
          Color listInDayColor = Color(0x33000000);

          if (weekday == 7 || weekday == 6) {
            dayColor = Color(0xff808080);
          } else {
            dayColor = Color(0xff000000);
          }

          TextStyle textStyle = TextStyle(
              color: dayColor, fontSize: 16, fontWeight: FontWeight.w400);
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
            listInDayColor = Color(0x00000000);
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
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(color: listInDayColor),
                    )
                  ],
                )),
          );
        });

    // GestureDetector dayContainer(
    //     Map<String, dynamic> dateMap, DateTime selectedDay) {
    //   DateTime now = DateTime.now();
    //   bool isToday = (now.year == dateMap["year"] &&
    //       now.month == dateMap["month"] &&
    //       now.day == dateMap["day"]);
    //   bool isSelectedDay = (selectedDay.year == dateMap["year"] &&
    //       selectedDay.month == dateMap["month"] &&
    //       selectedDay.day == dateMap["day"]);
    //   int weekday =
    //       DateTime(dateMap["year"], dateMap["month"], dateMap["day"]).weekday;
    //   Color dayColor = Color(0xff000000);

    //   if (weekday == 7 || weekday == 6) {
    //     dayColor = Color(0xff808080);
    //   } else {
    //     dayColor = Color(0xff000000);
    //   }

    //   TextStyle textStyle =
    //       TextStyle(color: dayColor, fontSize: 16, fontWeight: FontWeight.w400);
    //   BoxDecoration boxDecoration = BoxDecoration(
    //     shape: BoxShape.circle,
    //     color: Color(0x00000000),
    //   );

    //   if (isSelectedDay) {
    //     boxDecoration = BoxDecoration(
    //         color: Color(0xffffffff),
    //         shape: BoxShape.circle,
    //         border: Border.all(color: Color(0xff000000)));
    //   }

    //   if (isToday) {
    //     textStyle = TextStyle(
    //         color: dayColor,
    //         fontSize: 16,
    //         fontWeight: FontWeight.w900,
    //         decoration: TextDecoration.underline);
    //   }

    //   if (!dateMap["inMonth"]) {
    //     boxDecoration = BoxDecoration(color: Color(0x00000000));
    //     textStyle = TextStyle(color: Color(0x00000000), fontSize: 16);
    //   }

    //   return GestureDetector(
    //     onTap: () {
    //       if (dateMap["inMonth"]) {
    //         onTabEvent(
    //             DateTime(dateMap["year"], dateMap["month"], dateMap["day"]));
    //       }
    //     },
    //     child: Container(
    //       alignment: Alignment.center,
    //       height: 50,
    //       width: 50,
    //       margin: EdgeInsets.all(1.0),
    //       decoration: boxDecoration,
    //       child: Text(
    //         "${dateMap["day"]}",
    //         style: textStyle,
    //       ),
    //     ),
    //   );
    // }
  }
}
