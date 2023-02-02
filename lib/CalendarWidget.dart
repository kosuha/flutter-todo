import 'package:flutter/material.dart';
import 'MonthTitleWidget.dart';
import 'MonthBodyWidget.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> {
  List<String> weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  static DateTime now = DateTime.now();
  int year = 0;
  int month = 0;

  @override
  void initState() {
    super.initState();
    year = now.year;
    month = now.month;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.fromLTRB(10, 60, 10, 0),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: MonthTitleWidget(
              year: year,
              monthString: months[month - 1],
            ),
          ),
          Container(
            child: GestureDetector(
              child: MonthBodyWidget(
                year: year,
                month: month,
                weekdays: weekdays,
                months: months,
              ),
            ),
          )
        ],
      ),
    );
  }

  void setYear(int yearTo) {
    setState(() {
      year = yearTo;
    });
  }

  void setMonth(int monthTo) {
    setState(() {
      month = monthTo;
    });
  }
}
