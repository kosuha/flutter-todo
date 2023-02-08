import 'package:flutter/material.dart';
import 'package:laum/components/calendar_body_view.dart';
import '../bloc/calendar_bloc.dart';
import '../bloc/daily_list_bloc.dart';
import '../components/calendar_title_view.dart';
import '../components/daily_list_view.dart';

late CalendarBloc calendarBloc;
late DailyListBloc dailyListBloc;

class BlocDisplayWidget extends StatefulWidget {
  const BlocDisplayWidget({Key? key}) : super(key: key);

  @override
  _BlocDisplayWidgetState createState() => _BlocDisplayWidgetState();
}

class _BlocDisplayWidgetState extends State<BlocDisplayWidget> {
  bool textWriteState = false;

  @override
  void initState() {
    super.initState();
    calendarBloc = CalendarBloc();
    dailyListBloc = DailyListBloc();
  }

  @override
  void dispose() {
    super.dispose();
    calendarBloc.dispose();
    dailyListBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double dailyListContainerHeight = MediaQuery.of(context).size.height * 0.5;
    if (textWriteState) {
      dailyListContainerHeight = MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            Container(
              child: Column(children: [
                Offstage(
                  offstage: textWriteState,
                  child: Container(
                    // margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        CalendarTitleView(),
                        CalendarBodyView(onTabEvent: onTapDateEvent),
                      ],
                    ),
                    // child: CalendarView(onTabEvent: onTapDateEvent),
                  ),
                ),
                Container(
                  height: dailyListContainerHeight,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                  child: DailyListView(
                      textWriteState: textWriteState,
                      setTextWriteState: setTextWriteState),
                ),
              ]),
            )
          ],
        ),
      ),
      floatingActionButton: Offstage(
        offstage: textWriteState,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              textWriteState = true;
            });
          },
          backgroundColor: Color(0xffffffff),
          foregroundColor: Color(0xff000000),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  onTapDateEvent(DateTime tabDate) {
    calendarBloc.setSelectedDate(tabDate);
    dailyListBloc.setDailyList(tabDate);
  }

  setTextWriteState(bool newTextWriteState) {
    setState(() {
      textWriteState = newTextWriteState;
    });
  }
}
