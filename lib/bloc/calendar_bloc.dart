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
      "date": DateTime(now.year, now.month, 1),
      "selectedDate": DateTime(now.year, now.month, now.day),
      "list": <Todo>[],
    };
    _displayMonth["list"] =
        await todoProvider.getListByMonth(DateTime(now.year, now.month, 1));
    _displayMonthSubject.sink.add(_displayMonth);
  }

  addDisplayMonth() {
    _displayMonth["date"] = DateTime(
        _displayMonth["date"].year, _displayMonth["date"].month + 1, 1);
    _displayMonthSubject.sink.add(_displayMonth);
  }

  subtractDisplayMonth() {
    _displayMonth["date"] = DateTime(
        _displayMonth["date"].year, _displayMonth["date"].month - 1, 1);
    _displayMonthSubject.sink.add(_displayMonth);
  }

  setDisplayMonth(int yearTo, int monthTo) {
    _displayMonth["date"] = DateTime(yearTo, monthTo, 1);
    _displayMonthSubject.sink.add(_displayMonth);
  }

  getSelectedDate() {
    return _displayMonth["selectedDate"];
  }

  setSelectedDate(DateTime date) {
    _displayMonth["selectedDate"] = DateTime(date.year, date.month, date.day);
    _displayMonthSubject.sink.add(_displayMonth);
  }

  deleteTodo(int id) {
    TodoProvider todoProvider = TodoProvider();

    todoProvider.deleteTodoById(id);
    _displayMonth["list"].removeWhere((todo) => todo.id == id);
    _displayMonthSubject.sink.add(_displayMonth);
  }

  setDone(int id, int done) {
    TodoProvider todoProvider = TodoProvider();
    todoProvider.setDoneById(id, done);
    for (Todo todo in _displayMonth["list"]) {
      if (todo.id == id) {
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

  dispose() {
    _displayMonthSubject.close();
  }
}
