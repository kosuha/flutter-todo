import 'package:flutter/material.dart';
import 'MonthTitleWidget.dart';
import 'MonthBodyWidget.dart';

class CalendarWidget extends StatefulWidget {
  // const CalendarWidget({super.key});
  const CalendarWidget(
      {Key? key, required this.year, required this.month, required this.day})
      : super(key: key);

  final int year;
  final int month;
  final int day;

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
  // static DateTime now = DateTime.now();
  // int year = 0;
  // int month = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   year = now.year;
  //   month = now.month;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top) *
          0.5,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: MonthTitleWidget(
              year: widget.year,
              monthString: months[widget.month - 1],
            ),
          ),
          MonthBodyWidget(
            year: widget.year,
            month: widget.month,
            weekdays: weekdays,
            months: months,
          ),
        ],
      ),
    );
  }

  // void setYear(int yearTo) {
  //   setState(() {
  //     year = yearTo;
  //   });
  // }

  // void setMonth(int monthTo) {
  //   setState(() {
  //     month = monthTo;
  //   });
  // }
}
