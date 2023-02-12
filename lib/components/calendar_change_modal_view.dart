import '../ui/bloc_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../bloc/constants.dart';

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
    DateTime displayMonth = calendarBloc.getDisplayMonth()["selectedDate"];

    yearTo = displayMonth.year;
    monthTo = displayMonth.month;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        Constant.getSize(15.0),
        Constant.getSize(15.0),
        Constant.getSize(15.0),
        Constant.getSize(15.0),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff252525),
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(
            Constant.getSize(16.0),
          ))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Color(0xff8b8b8b),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: Constant.getSize(20.0),
            ),
            alignment: Alignment.center,
            child: Column(children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                  Constant.getSize(20.0),
                  0,
                  Constant.getSize(20.0),
                  Constant.getSize(10.0),
                ),
                margin: EdgeInsets.fromLTRB(
                    Constant.getSize(10.0), 0, Constant.getSize(10.0), 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: yearToChangeRow(),
                ),
              ),
              Column(
                children: monthsRow(Constant.kMonthStrings),
              )
            ]),
          ),
          Container(
            height: Constant.getSize(56.0),
            child: CupertinoButton(
                color: Color(0xff00ff00),
                minSize: MediaQuery.of(context).size.width,
                onPressed: () {
                  calendarBloc.setDisplayMonth(yearTo, monthTo);
                  Navigator.pop(context);
                },
                child: Text(
                  '확인',
                  style: TextStyle(
                    fontSize: Constant.getSize(14),
                    color: Color(0xff000000),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  List<Row> monthsRow(List<String> months) {
    List<Row> res = [];
    Color borderColor = Color(0x00ffffff);

    for (int i = 0; i < 3; i++) {
      List<GestureDetector> textButtons = [];
      for (int j = 0; j < 4; j++) {
        String monthSymbol = months[i * 4 + j].substring(0, 3).toUpperCase();
        if (i * 4 + j + 1 == monthTo) {
          borderColor = Color(0xffffffff);
        } else {
          borderColor = Color(0x00ffffff);
        }
        textButtons.add(GestureDetector(
          onTap: () {
            setState(() {
              monthTo = i * 4 + j + 1;
            });
          },
          child: Container(
              alignment: Alignment.center,
              width: Constant.getSize(75.0),
              height: Constant.getSize(50.0),
              margin: EdgeInsets.all(
                Constant.getSize(2.0),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(
                  Constant.getSize(50.0),
                ),
              ),
              child: Text(
                monthSymbol,
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: Constant.getSize(16.0),
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
          if (yearTo > 1) yearTo--;
        });
      },
      child: Container(
          padding: EdgeInsets.all(
            Constant.getSize(10.0),
          ),
          decoration:
              BoxDecoration(border: Border.all(color: Color(0x00ffffff))),
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffffffff),
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
        style: TextStyle(
            color: Color(0xffffffff),
            fontSize: Constant.getSize(22.0),
            fontWeight: FontWeight.w700),
      ),
    ));
    res.add(GestureDetector(
      onTap: () {
        setState(() {
          if (yearTo < 9999) yearTo++;
        });
      },
      child: Container(
        padding: EdgeInsets.all(
          Constant.getSize(10.0),
        ),
        decoration: BoxDecoration(border: Border.all(color: Color(0x00ffffff))),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Color(0xffffffff),
        ),
      ),
    ));

    return res;
  }
}
