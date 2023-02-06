import 'package:flutter/material.dart';
import 'MonthTitleWidget.dart';
import 'MonthBodyWidget.dart';

class CalendarWidget extends StatefulWidget {
  // const CalendarWidget({super.key});
  const CalendarWidget(
      {Key? key,
      required this.setDate,
      required this.year,
      required this.month,
      required this.day})
      : super(key: key);

  final Function setDate;
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
            setDate: widget.setDate,
            year: widget.year,
            month: widget.month,
            day: widget.day,
            weekdays: weekdays,
            months: months,
          ),
        ],
      ),
    );
  }
}
