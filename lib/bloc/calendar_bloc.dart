import 'dart:async';

class CalendarBloc {
  late DateTime _selectedDate;
  late DateTime _displayMonth;

  CalendarBloc() {
    DateTime now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    _displayMonth = DateTime(now.year, now.month, 1);
  }

  final StreamController _displayMonthSubject = StreamController.broadcast();
  final StreamController _selectedDateSubject = StreamController.broadcast();

  Stream get displayMonth => _displayMonthSubject.stream;
  Stream get selectedDate => _selectedDateSubject.stream;

  addDisplayMonth() {
    _displayMonth = DateTime(_displayMonth.year, _displayMonth.month + 1, 1);
    _displayMonthSubject.sink.add(_displayMonth);
  }

  subtractDisplayMonth() {
    _displayMonth = DateTime(_displayMonth.year, _displayMonth.month - 1, 1);
    _displayMonthSubject.sink.add(_displayMonth);
  }

  setDisplayMonth(int yearTo, int monthTo) {
    _displayMonth = DateTime(yearTo, monthTo, 1);
    _displayMonthSubject.sink.add(_displayMonth);
  }

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
