import '../ui/bloc_display_widget.dart';
import 'package:flutter/material.dart';

class CalendarTitleView extends StatelessWidget {
  CalendarTitleView({
    required this.displayMonth,
    Key? key,
  }) : super(key: key);

  final Map displayMonth;

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

    return Container(
        alignment: Alignment.center,
        child: Text(
          "${monthStrings[displayMonth["date"].month - 1]}, ${displayMonth["date"].year}",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
        ));
  }
}
