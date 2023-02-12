import '../ui/bloc_display_widget.dart';
import 'package:flutter/material.dart';
import '../bloc/constants.dart';

class CalendarTitleView extends StatelessWidget {
  CalendarTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map displayMonth = calendarBloc.getDisplayMonth();

    return Container(
        padding: EdgeInsets.all(10 / 797 * Constant.kHeight),
        alignment: Alignment.center,
        child: Text(
          "${Constant.monthStrings[displayMonth["selectedDate"].month - 1].substring(0, 3).toUpperCase()} ${displayMonth["selectedDate"].day}, ${displayMonth["selectedDate"].year}",
          style: TextStyle(
              color: Color(0xffffffff),
              letterSpacing: 0.05,
              fontSize: (24 / 797 * Constant.kHeight),
              fontWeight: FontWeight.w900),
        ));
  }
}
