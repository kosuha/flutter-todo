import '../ui/bloc_display_widget.dart';
import 'package:flutter/material.dart';

class CalendarTitleView extends StatelessWidget {
  const CalendarTitleView({
    Key? key,
  }) : super(key: key);

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
      child: StreamBuilder(
        stream: calendarBloc.displayMonth,
        initialData: DateTime.now(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Text(
              "${monthStrings[snapshot.data.month - 1]}, ${snapshot.data.year}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
