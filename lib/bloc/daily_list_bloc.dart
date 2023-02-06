import 'dart:async';
import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../model/todo_provider.dart';

// 비즈니스 로직 분리
class DailyListBloc {
  List<Todo> _dailyList = [];

  // StreamController을 통해 여러 이벤트를 처리
  final StreamController __dailyListSubject = StreamController.broadcast();

  // count는 _countSubject.stream 을 구독하고 있는 모든 위젯에게 변경된 상태를 알림
  Stream get dailyList => __dailyListSubject.stream;

  // getDailyList(DateTime date) {
  //   TodoProvider todoProvider = TodoProvider();

  //   _dailyList = todoProvider.getListByDate(date.toString()) as List<Todo>;
  // }

  getDailyList(DateTime date) async {
    TodoProvider todoProvider = TodoProvider();

    _dailyList = await todoProvider
        .getListByDate(DateTime(date.year, date.month, date.day).toString());

    __dailyListSubject.sink.add(_dailyList);
  }

  setDone(int id, int done) {
    TodoProvider todoProvider = TodoProvider();

    todoProvider.setDoneById(id, done);
    for (Todo todo in _dailyList) {
      if (todo.id == id) {
        todo.done = done;
      }
    }

    __dailyListSubject.sink.add(_dailyList);
  }

  // insertTodo() async {
  //   TodoProvider todoProvider = TodoProvider();

  //   todoProvider.insert(todo);
  //   _dailyList.add(todo);
  //   __dailyListSubject.sink.add(_dailyList);
  // }

  dispose() {
    __dailyListSubject.close();
  }
}
