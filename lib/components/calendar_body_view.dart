import 'package:flutter/material.dart';
import '../ui/bloc_display_widget.dart';
import 'calendar_day_view.dart';

// count만을 보여주는 코드
class CalendarBodyView extends StatelessWidget {
  const CalendarBodyView({
    Key? key,
    required this.onTabEvent,
  }) : super(key: key);

  final Function onTabEvent;

  @override
  Widget build(BuildContext context) {
    final List<String> weekdayStrings = [
      "SUN",
      "MON",
      "TUE",
      "WED",
      "THU",
      "FRI",
      "SAT"
    ];

    return Center(
      child: StreamBuilder(
        stream: calendarBloc.displayMonth,
        initialData: DateTime.now(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> dates = [];
            List<Row> rows = [];

            int year = snapshot.data.year;
            int month = snapshot.data.month;

            for (int i = 1; i <= DateTime(year, month + 1, 0).day; i++) {
              dates.add({
                "year": year,
                "month": month,
                "day": i,
                "inMonth": true,
              });
            }

            if (DateTime(year, month, 1).weekday != 7) {
              List<Map<String, dynamic>> temps = [];
              int prevLastDay = DateTime(year, month, 0).day;
              for (int i = DateTime(year, month, 1).weekday - 1; i >= 0; i--) {
                temps.add({
                  "year": year,
                  "month": month - 1,
                  "day": prevLastDay - i,
                  "inMonth": false,
                });
              }
              dates = [...temps, ...dates];
            }

            List<Map<String, dynamic>> temps = [];
            int maxIndex = 6 - DateTime(year, month + 1, 0).weekday;
            if (maxIndex == -1) {
              maxIndex = 6;
            }
            for (int i = 1; i <= maxIndex; i++) {
              temps.add({
                "year": year,
                "month": month + 1,
                "day": i,
                "inMonth": false,
              });
            }
            dates = [...dates, ...temps];

            int rowsLength = dates.length ~/ 7;
            for (int i = 0; i < rowsLength; i++) {
              List<Widget> temps = [];
              for (int j = 0; j < 7; j++) {
                temps.add(CalendarDayView(
                  day: dates[i * 7 + j],
                  onTabEvent: onTabEvent,
                ));
              }
              rows.add(Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: temps,
              ));
            }

            return Flex(direction: Axis.vertical, children: [
              Container(
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xff000000)))),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: weekdaysText(weekdayStrings),
                ),
              ),
              Flex(
                direction: Axis.vertical,
                children: rows,
              )
            ]);
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

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

  List<Container> weekdaysText(List<String> weekdays) {
    List<Container> res = [];
    Color dayColor = Color(0xff000000);

    for (int i = 0; i < weekdays.length; i++) {
      if (i == 0 || i == 6) {
        dayColor = Color(0xff808080);
      } else {
        dayColor = Color(0xff000000);
      }
      res.add(Container(
        alignment: Alignment.center,
        width: 50,
        margin: EdgeInsets.fromLTRB(1.0, 10, 1.0, 10),
        child: Text(
          weekdays[i],
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: dayColor),
        ),
      ));
    }
    return res;
  }
}
