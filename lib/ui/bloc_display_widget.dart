import 'package:flutter/material.dart';
import '../components/calendar_body_view.dart';
import '../bloc/calendar_bloc.dart';
import '../components/calendar_title_view.dart';
import '../components/daily_list_view.dart';
import '../components/calendar_change_modal_view.dart';
import '../bloc/constants.dart';
import 'setting_widget.dart';

late CalendarBloc calendarBloc;

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
  }

  @override
  void dispose() {
    super.dispose();
    calendarBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Constant.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff252525),
      body: StreamBuilder(
        stream: calendarBloc.displayMonth,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            double monthContainerHeight =
                getMonthContainerHeight(snapshot.data["selectedDate"]);
            double dailyListContainerHeight =
                Constant.kHeight - Constant.kPaddingTop - monthContainerHeight;

            Container monthContainer = Container(
              height: monthContainerHeight,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0x22ffffff)))),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Constant.getSize(15.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: calendarChangeButtonEvent,
                          child: CalendarTitleView(),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SettingWidget(),
                                  ));
                            },
                            icon: Icon(
                              Icons.settings,
                              color: Color(0xff777777),
                            ))
                      ],
                    ),
                  ),
                  GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails details) {
                      if (details.primaryVelocity! > 0) {
                        calendarBloc.subtractDisplayMonth();
                      } else if (details.primaryVelocity! < 0) {
                        calendarBloc.addDisplayMonth();
                      }
                    },
                    child: CalendarBodyView(onTapEvent: onTapDateEvent),
                  ),
                ],
              ),
            );

            if (textWriteState) {
              monthContainer = Container();
              dailyListContainerHeight =
                  Constant.kHeight - Constant.kPaddingTop;
            }

            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: Constant.kPaddingTop),
              child: Column(
                children: [
                  Container(
                    width: Constant.kWidth,
                    child: Column(children: [
                      monthContainer,
                      Container(
                        height: dailyListContainerHeight,
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom +
                              Constant.getSize(10.0),
                        ),
                        child: DailyListView(
                            textWriteState: textWriteState,
                            setTextWriteState: setTextWriteState),
                      ),
                    ]),
                  )
                ],
              ),
            );
          }

          return Center(child: Text("Loading..."));
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
          top: Radius.circular(Constant.getSize(30.0)),
        )),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter bottomState) {
            return CalendarChangeModalView();
          });
        });
  }

  double getMonthContainerHeight(DateTime month) {
    int firstDay = DateTime(month.year, month.month, 1).weekday;
    // print(firstDay);
    if (month.month == 1 ||
        month.month == 3 ||
        month.month == 5 ||
        month.month == 7 ||
        month.month == 8 ||
        month.month == 10 ||
        month.month == 12) {
      if (firstDay == 5 || firstDay == 6) {
        // return 410.0;
        return Constant.getSize(410.0);
      }
    } else {
      if (firstDay == 6) {
        return Constant.getSize(410.0);
      }
    }
    return Constant.getSize(360.0);
  }
}
