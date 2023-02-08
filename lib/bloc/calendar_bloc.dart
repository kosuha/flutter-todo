import 'dart:async';

// 비즈니스 로직 분리
class CalendarBloc {
  late DateTime _selectedDate;
  late DateTime _displayMonth;

  CalendarBloc() {
    DateTime now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    _displayMonth = DateTime(now.year, now.month, 1);
  }

  // StreamController을 통해 여러 이벤트를 처리
  final StreamController _displayMonthSubject = StreamController.broadcast();
  final StreamController _selectedDateSubject = StreamController.broadcast();

  // count는 _countSubject.stream 을 구독하고 있는 모든 위젯에게 변경된 상태를 알림
  Stream get displayMonth => _displayMonthSubject.stream;
  Stream get selectedDate => _selectedDateSubject.stream;

  addDisplayMonth() {
    _displayMonth = DateTime(_displayMonth.year, _displayMonth.month + 1, 1);
    _displayMonthSubject.sink.add(_displayMonth);
    // setDisplayDates();
  }

  subtractDisplayMonth() {
    _displayMonth = DateTime(_displayMonth.year, _displayMonth.month - 1, 1);
    _displayMonthSubject.sink.add(_displayMonth);
    // setDisplayDates();
  }

  setDisplayMonth(int yearTo, int monthTo) {
    _displayMonth = DateTime(yearTo, monthTo, 1);
    _displayMonthSubject.sink.add(_displayMonth);
  }

  // setDisplayDates() {
  //   int year = _displayMonth.year;
  //   int month = _displayMonth.month;
  //   List<Map<String, dynamic>> newDisplayDates = [];

  //   for (int i = 1; i <= DateTime(year, month + 1, 0).day; i++) {
  //     bool isToday =
  //         DateTime(year, month, i) == DateTime(_now.year, _now.month, _now.day);
  //     bool isSelectedDay = DateTime(year, month, i) ==
  //         DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);

  //     newDisplayDates.add({
  //       "year": year,
  //       "month": month,
  //       "day": i,
  //       "inMonth": true,
  //       "today": isToday,
  //       "selectedDay": isSelectedDay,
  //       "weekday": DateTime(year, month, i).weekday
  //     });
  //   }

  //   if (DateTime(year, month, 1).weekday != 7) {
  //     List<Map<String, dynamic>> temps = [];
  //     int prevLastDay = DateTime(year, month, 0).day;
  //     for (int i = DateTime(year, month, 1).weekday - 1; i >= 0; i--) {
  //       temps.add({
  //         "year": year,
  //         "month": month - 1,
  //         "day": prevLastDay - i,
  //         "inMonth": false,
  //         "today": false,
  //         "selectedDay": false,
  //         "weekday": DateTime(year, month, i).weekday
  //       });
  //     }
  //     newDisplayDates = [...temps, ...newDisplayDates];
  //   }

  //   List<Map<String, dynamic>> temps = [];
  //   int maxIndex = 6 - DateTime(year, month + 1, 0).weekday;
  //   if (maxIndex == -1) {
  //     maxIndex = 6;
  //   }
  //   for (int i = 1; i <= maxIndex; i++) {
  //     temps.add({
  //       "year": year,
  //       "month": month + 1,
  //       "day": i,
  //       "inMonth": false,
  //       "today": false,
  //       "selectedDay": false,
  //       "weekday": DateTime(year, month, i).weekday
  //     });
  //   }
  //   newDisplayDates = [...newDisplayDates, ...temps];

  //   return newDisplayDates;
  // }

  getSelectedDate() {
    return _selectedDate;
  }

  setSelectedDate(DateTime date_) {
    _selectedDate = DateTime(date_.year, date_.month, date_.day);
    _selectedDateSubject.sink.add(_selectedDate);
  }

  dispose() {
    _displayMonthSubject.close();
    _selectedDateSubject.close();
  }
}
