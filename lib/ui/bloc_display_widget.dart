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
            double dailyListContainerHeight = 387 / 797 * Constant.kHeight;
            Container monthContainer = Container(
              height: 410 / 797 * Constant.kHeight,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0x22ffffff)))),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15 / 797 * Constant.kHeight),
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
              dailyListContainerHeight = Constant.kHeight;
            }

            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  Container(
                    width: (390 / 797 * Constant.kHeight),
                    child: Column(children: [
                      monthContainer,
                      Container(
                        height: dailyListContainerHeight,
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom +
                              (10 / 797 * Constant.kHeight),
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
          top: Radius.circular((30 / 797 * Constant.kHeight)),
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

/*
  TODO: 390 844(797)


*/
