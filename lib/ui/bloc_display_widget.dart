import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:laum/components/calendar_body_view.dart';
import '../bloc/calendar_bloc.dart';
// import '../bloc/daily_list_bloc.dart';
import '../components/calendar_title_view.dart';
import '../components/daily_list_view.dart';
import '../components/calendar_change_modal_view.dart';

late CalendarBloc calendarBloc;
// late DailyListBloc dailyListBloc;

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
    // dailyListBloc = DailyListBloc();
  }

  @override
  void dispose() {
    super.dispose();
    calendarBloc.dispose();
    // dailyListBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: calendarBloc.displayMonth,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            double dailyListContainerHeight =
                MediaQuery.of(context).size.height * 0.5;
            Container monthContainer = Container(
              // margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: calendarChangeButtonEvent,
                    child: CalendarTitleView(displayMonth: snapshot.data),
                  ),
                  GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails details) {
                      if (details.primaryVelocity! > 0) {
                        calendarBloc.subtractDisplayMonth();
                      } else if (details.primaryVelocity! < 0) {
                        calendarBloc.addDisplayMonth();
                      }
                    },
                    child: CalendarBodyView(
                        displayMonth: snapshot.data,
                        onTapEvent: onTapDateEvent),
                  ),
                ],
              ),
              // child: CalendarView(onTabEvent: onTapDateEvent),
            );
            if (textWriteState) {
              monthContainer = Container();
              dailyListContainerHeight = MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top;
            }

            return Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  Container(
                    child: Column(children: [
                      monthContainer,
                      Container(
                        height: dailyListContainerHeight,
                        padding: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 10),
                        child: DailyListView(
                            displayMonth: snapshot.data,
                            textWriteState: textWriteState,
                            setTextWriteState: setTextWriteState),
                      ),
                    ]),
                  )
                ],
              ),
            );
          }
          return Text("Loading...");
        },
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

  onTapDateEvent(DateTime tapDate) {
    calendarBloc.setSelectedDate(tapDate);
    // dailyListBloc.setDailyList(tabDate);
  }

  setTextWriteState(bool newTextWriteState) {
    setState(() {
      textWriteState = newTextWriteState;
    });
  }

  void calendarChangeButtonEvent() {
    showModalBottomSheet(
        backgroundColor: Color(0xffffffff),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        )),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter bottomState) {
            return CalendarChangeModalView();
          });
        });
  }
}
