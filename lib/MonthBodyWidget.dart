import 'package:flutter/material.dart';

class MonthBodyWidget extends StatelessWidget {
  const MonthBodyWidget(
      {Key? key,
      required this.year,
      required this.month,
      required this.weekdays,
      required this.months})
      : super(key: key);

  final int year;
  final int month;
  final List<String> weekdays;
  final List<String> months;

  static DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dates = [];
    List<Row> rows = [];

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
      List<GestureDetector> temps = [];
      for (int j = 0; j < 7; j++) {
        temps.add(dayContainer(dates[i * 7 + j], context));
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: temps,
      ));
    }

    return Flex(direction: Axis.vertical, children: [
      Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xff000000)))),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          children: weekdaysText(weekdays),
        ),
      ),
      Flex(
        direction: Axis.vertical,
        children: rows,
      )
    ]);
  }

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

  GestureDetector dayContainer(
      Map<String, dynamic> dateMap, BuildContext context) {
    int date = dateMap["day"];
    bool isToday = (now.year == dateMap["year"] &&
        now.month == dateMap["month"] &&
        now.day == dateMap["day"]);
    int weekday =
        DateTime(dateMap["year"], dateMap["month"], dateMap["day"]).weekday;
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

    if (isToday) {
      isToday = true;
      boxDecoration = BoxDecoration(
          color: Color(0xffffffff),
          shape: BoxShape.circle,
          border: Border.all(color: Color(0xff000000)));
      textStyle =
          TextStyle(color: dayColor, fontSize: 16, fontWeight: FontWeight.w600);
    }

    if (!dateMap["inMonth"]) {
      boxDecoration = BoxDecoration(color: Color(0x00000000));
      textStyle = TextStyle(color: Color(0x00000000), fontSize: 16);
    }

    return GestureDetector(
      onTap: () {
        print("tab");
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        margin: EdgeInsets.all(1.0),
        decoration: boxDecoration,
        child: Text(
          "$date",
          style: textStyle,
        ),
      ),
    );
  }
}
