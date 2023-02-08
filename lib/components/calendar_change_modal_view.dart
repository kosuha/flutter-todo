import '../ui/bloc_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../bloc/calendar_bloc.dart';

class CalendarChangeModalView extends StatefulWidget {
  const CalendarChangeModalView({Key? key}) : super(key: key);

  @override
  _CalendarChangeModalViewState createState() =>
      _CalendarChangeModalViewState();
}

class _CalendarChangeModalViewState extends State<CalendarChangeModalView> {
  int yearTo = 0;
  int monthTo = 0;

  @override
  void initState() {
    super.initState();
    DateTime selectedDate = calendarBloc.getSelectedDate();
    yearTo = selectedDate.year;
    monthTo = selectedDate.month;
  }

  @override
  void dispose() {
    super.dispose();
  }

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
      // height: 200,
      padding: EdgeInsets.fromLTRB(15, 10, 15, 50),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            // decoration: BoxDecoration(
            //     border: Border.all(color: Color(0xff000000))),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Color(0xff8b8b8b),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            // decoration: BoxDecoration(
            //     border: Border.all(color: Color(0xff000000))),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
            alignment: Alignment.center,
            child: Column(children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: yearToChangeRow(),
                ),
              ),
              Column(
                children: monthsRow(monthStrings),
              )
            ]),
          ),
          Container(
            height: 56,
            child: CupertinoButton(
                color: Color(0xff000000),
                minSize: MediaQuery.of(context).size.width,
                onPressed: () {
                  calendarBloc.setDisplayMonth(yearTo, monthTo);
                  Navigator.pop(context);
                },
                child: Text('확인')),
          ),
        ],
      ),
    );
  }

  List<Row> monthsRow(List<String> months) {
    List<Row> res = [];
    Color borderColor = Color(0x00000000);

    for (int i = 0; i < 3; i++) {
      List<GestureDetector> textButtons = [];
      for (int j = 0; j < 4; j++) {
        String monthSymbol = months[i * 4 + j].substring(0, 3).toUpperCase();
        if (i * 4 + j + 1 == monthTo) {
          borderColor = Color(0xff000000);
        } else {
          borderColor = Color(0x00000000);
        }
        textButtons.add(GestureDetector(
          onTap: () {
            setState(() {
              monthTo = i * 4 + j + 1;
            });
          },
          child: Container(
              alignment: Alignment.center,
              width: 75,
              height: 50,
              // padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                monthSymbol,
                style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )),
        ));
      }
      res.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: textButtons,
      ));
    }
    return res;
  }

  List<GestureDetector> yearToChangeRow() {
    List<GestureDetector> res = [];

    res.add(GestureDetector(
      onTap: () {
        setState(() {
          yearTo--;
        });
      },
      child: Container(
          padding: EdgeInsets.all(10),
          decoration:
              BoxDecoration(border: Border.all(color: Color(0x00000000))),
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff000000),
          )),
    ));
    res.add(GestureDetector(
      onDoubleTap: () {
        setState(() {
          yearTo = calendarBloc.getSelectedDate().year;
          monthTo = calendarBloc.getSelectedDate().month;
        });
      },
      child: Text(
        "$yearTo",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      ),
    ));
    res.add(GestureDetector(
      onTap: () {
        setState(() {
          yearTo++;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Color(0x00000000))),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Color(0xff000000),
        ),
      ),
    ));

    return res;
  }
}
