import 'package:flutter/material.dart';
import '../ui/bloc_display_widget.dart';
import 'calendar_title_widget.dart';
import 'calendar_body_widget.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({
    Key? key,
    required this.onTabEvent,
  }) : super(key: key);

  final Function onTabEvent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: calendarBloc.displayMonth,
        initialData: DateTime.now(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                CalendarTitleWidget(displayMonth: snapshot.data),
                CalendarBodyWidget(
                  displayMonth: snapshot.data,
                  onTabEvent: onTabEvent,
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
