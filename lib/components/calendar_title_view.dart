import '../ui/bloc_display_widget.dart';
import 'package:flutter/material.dart';
import '../bloc/constants.dart';

class CalendarTitleView extends StatelessWidget {
  CalendarTitleView({
    // required this.displayMonth,
    Key? key,
  }) : super(key: key);

  // final Map displayMonth;

  @override
  Widget build(BuildContext context) {
    Map displayMonth = calendarBloc.getDisplayMonth();

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
        padding: EdgeInsets.all(10 / 797 * Constant.kHeight),
        alignment: Alignment.center,
        child: Text(
          "${monthStrings[displayMonth["selectedDate"].month - 1]} ${displayMonth["selectedDate"].day}, ${displayMonth["selectedDate"].year}",
          style: TextStyle(
              fontSize: (24 / 797 * Constant.kHeight),
              fontWeight: FontWeight.w900),
        ));
  }
}
