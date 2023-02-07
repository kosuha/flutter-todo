import 'package:flutter/material.dart';
import 'package:laum/components/calendar_body_view.dart';
import '../bloc/calendar_bloc.dart';
import '../bloc/daily_list_bloc.dart';
import '../components/calendar_title_view.dart';
import '../components/daily_list_view.dart';
import 'package:laum/model/todo.dart';
import '../model/todo_provider.dart';

late CalendarBloc calendarBloc;
late DailyListBloc dailyListBloc;

class BlocDisplayWidget extends StatefulWidget {
  const BlocDisplayWidget({Key? key}) : super(key: key);

  @override
  _BlocDisplayWidgetState createState() => _BlocDisplayWidgetState();
}

class _BlocDisplayWidgetState extends State<BlocDisplayWidget> {
  bool textWriteState = false;
  final _textEditingController = TextEditingController();

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
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: SingleChildScrollView(
                      child: DailyListView(),
                    )),
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
      bottomSheet: textFieldWidget(),
    );
  }

  onTapDateEvent(DateTime tabDate) {
    calendarBloc.setSelectedDate(tabDate);
    dailyListBloc.getDailyList(tabDate);
  }

  textFieldWidget() {
    if (textWriteState) {
      return Container(
          padding: EdgeInsets.fromLTRB(
              10, 10, 10, 10 + MediaQuery.of(context).viewInsets.bottom),
          // decoration: BoxDecoration(
          //     border: Border.all(color: Color(0xff000000)),
          //     color: Color(0x11000000)),
          child: TextField(
            controller: _textEditingController,
            autofocus: true,
            cursorColor: Color(0x55000000),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff000000)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff000000)),
              ),
            ),
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
              setState(() {
                textWriteState = false;
              });
            },
            onEditingComplete: submit,
          ));
    }
    return null;
  }

  submit() {
    if (_textEditingController.text.trim() == "") return;

    DateTime selectedDate = calendarBloc.getSelectedDate();

    FocusScope.of(context).unfocus();
    setState(() {
      textWriteState = false;
    });
    dailyListBloc.insertTodo(Todo(
        id: 0,
        date: DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
        done: 0,
        data: _textEditingController.text));
    dailyListBloc.getDailyList(selectedDate);
  }
}
