import 'dart:async';
import '../model/todo.dart';
import '../model/todo_provider.dart';

class CalendarBloc {
  late Map _displayMonth;

  CalendarBloc() {
    initDisplayMonth();
  }

  final StreamController _displayMonthSubject = StreamController.broadcast();

  Stream get displayMonth => _displayMonthSubject.stream;

  initDisplayMonth() async {
    DateTime now = DateTime.now();
    TodoProvider todoProvider = TodoProvider();

    _displayMonth = {
      "selectedDate": DateTime(now.year, now.month, now.day),
      "list": <Todo>[],
    };
    _displayMonth["list"] =
        await todoProvider.getListByMonth(DateTime(now.year, now.month, 1));
    _displayMonthSubject.sink.add(_displayMonth);
  }

  addDisplayMonth() async {
    TodoProvider todoProvider = TodoProvider();
    DateTime now = DateTime.now();

    _displayMonth["selectedDate"] = DateTime(_displayMonth["selectedDate"].year,
        _displayMonth["selectedDate"].month + 1, 1);

    if (now.year == _displayMonth["selectedDate"].year &&
        now.month == _displayMonth["selectedDate"].month) {
      _displayMonth["selectedDate"] = DateTime(
          _displayMonth["selectedDate"].year,
          _displayMonth["selectedDate"].month,
          now.day);
    }

    _displayMonth["list"] = await todoProvider.getListByMonth(DateTime(
        _displayMonth["selectedDate"].year,
        _displayMonth["selectedDate"].month,
        _displayMonth["selectedDate"].day));

    _displayMonthSubject.sink.add(_displayMonth);
  }

  subtractDisplayMonth() async {
    TodoProvider todoProvider = TodoProvider();
    DateTime now = DateTime.now();
    _displayMonth["selectedDate"] = DateTime(_displayMonth["selectedDate"].year,
        _displayMonth["selectedDate"].month - 1, 1);

    if (now.year == _displayMonth["selectedDate"].year &&
        now.month == _displayMonth["selectedDate"].month) {
      _displayMonth["selectedDate"] = DateTime(
          _displayMonth["selectedDate"].year,
          _displayMonth["selectedDate"].month,
          now.day);
    }
    _displayMonth["list"] = await todoProvider.getListByMonth(DateTime(
        _displayMonth["selectedDate"].year,
        _displayMonth["selectedDate"].month,
        _displayMonth["selectedDate"].day));

    _displayMonthSubject.sink.add(_displayMonth);
  }

  setDisplayMonth(int yearTo, int monthTo) async {
    TodoProvider todoProvider = TodoProvider();
    DateTime now = DateTime.now();

    if (now.year == yearTo && now.month == monthTo) {
      _displayMonth["selectedDate"] = DateTime(yearTo, monthTo, now.day);
    } else {
      _displayMonth["selectedDate"] = DateTime(yearTo, monthTo, 1);
    }

    _displayMonth["list"] = await todoProvider.getListByMonth(DateTime(
        _displayMonth["selectedDate"].year,
        _displayMonth["selectedDate"].month,
        _displayMonth["selectedDate"].day));

    _displayMonthSubject.sink.add(_displayMonth);
  }

  getSelectedDate() {
    return _displayMonth["selectedDate"];
  }

  getDisplayMonth() {
    return _displayMonth;
  }

  setSelectedDate(DateTime date) {
    _displayMonth["selectedDate"] = DateTime(date.year, date.month, date.day);
    _displayMonthSubject.sink.add(_displayMonth);
  }

  deleteTodo(int since) {
    TodoProvider todoProvider = TodoProvider();

    todoProvider.deleteTodoBySince(since);
    _displayMonth["list"].removeWhere((todo) => todo.since == since);
    _displayMonthSubject.sink.add(_displayMonth);
  }

  setDone(int since, int done) {
    TodoProvider todoProvider = TodoProvider();
    todoProvider.setDoneBySince(since, done);
    for (Todo todo in _displayMonth["list"]) {
      if (todo.since == since) {
        todo.done = done;
        break;
      }
    }
    _displayMonthSubject.sink.add(_displayMonth);
  }

  insertTodo(Todo todo) {
    TodoProvider todoProvider = TodoProvider();

    _displayMonth["list"].add(todo);
    todoProvider.insert(todo);
    _displayMonthSubject.sink.add(_displayMonth);
  }

  editTodo(Todo editedTodo) {
    TodoProvider todoProvider = TodoProvider();

    todoProvider.editTodo(editedTodo);
    for (Todo todo in _displayMonth["list"]) {
      if (todo.since == editedTodo.since) {
        todo = editedTodo;
        break;
      }
    }
    _displayMonthSubject.sink.add(_displayMonth);
  }

  dispose() {
    _displayMonthSubject.close();
  }
}
