// import 'dart:async';
// import '../model/todo.dart';
// import '../model/todo_provider.dart';

// class DailyListBloc {
//   List<Todo> _dailyList = [];

//   DailyListBloc() {
//     // print("init DailyListBloc");
//     DateTime now = DateTime.now();
//     initDailyList(DateTime(now.year, now.month, now.day));
//   }

//   final StreamController _dailyListSubject = StreamController.broadcast();

//   Stream get dailyList => _dailyListSubject.stream;

//   initDailyList(DateTime date) async {
//     TodoProvider todoProvider = TodoProvider();

//     _dailyList = await todoProvider.getListByDay(date);
//     _dailyListSubject.sink.add(_dailyList);
//   }

//   isDailyList(DateTime date) async {
//     TodoProvider todoProvider = TodoProvider();

//     List<Todo> temp = await todoProvider.getListByDay(date);
//     return temp.isNotEmpty;
//   }

//   getDailyList() {
//     return _dailyList;
//   }

//   setDailyList(DateTime date) async {
//     TodoProvider todoProvider = TodoProvider();

//     _dailyList = await todoProvider.getListByDay(date);
//     _dailyListSubject.sink.add(_dailyList);
//   }

//   deleteTodo(int id) {
//     TodoProvider todoProvider = TodoProvider();

//     todoProvider.deleteTodoById(id);
//     _dailyList.removeWhere((todo) => todo.id == id);
//     print(_dailyList);
//     _dailyListSubject.sink.add(_dailyList);
//   }

//   setDone(int id, int done) {
//     TodoProvider todoProvider = TodoProvider();
//     todoProvider.setDoneById(id, done);
//     for (Todo todo in _dailyList) {
//       if (todo.id == id) {
//         todo.done = done;
//         break;
//       }
//     }
//     _dailyListSubject.sink.add(_dailyList);
//   }

//   insertTodo(Todo todo) {
//     TodoProvider todoProvider = TodoProvider();

//     _dailyList.add(todo);
//     todoProvider.insert(todo);
//     _dailyListSubject.sink.add(_dailyList);
//   }

//   dispose() {
//     _dailyListSubject.close();
//   }
// }
