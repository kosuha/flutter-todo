import 'package:flutter/cupertino.dart';

class CalendarTitleWidget extends StatelessWidget {
  const CalendarTitleWidget({
    Key? key,
    required this.displayMonth,
  }) : super(key: key);

  final DateTime displayMonth;

  @override
  Widget build(BuildContext context) {
    final List<String> monthStrings = [
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
    return Center(
        child: Text(
      "${monthStrings[displayMonth.month - 1]}, ${displayMonth.year}",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
    ));
  }
}
