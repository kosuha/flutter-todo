import 'package:flutter/material.dart';
import 'database/Todo.dart';
import 'database/TodoProvider.dart';

class WriteModalWidget extends StatefulWidget {
  const WriteModalWidget(
      {Key? key,
      // required this.setAddState,
      required this.setTodoList,
      required this.todoListScrollController,
      required this.year,
      required this.month,
      required this.day})
      : super(key: key);

  // final Function setAddState;
  final Function setTodoList;
  final ScrollController todoListScrollController;
  final int year;
  final int month;
  final int day;

  @override
  State<WriteModalWidget> createState() => _WriteModalWidgetState();
}

class _WriteModalWidgetState extends State<WriteModalWidget> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: TextField(
        controller: _textEditingController,
        keyboardType: TextInputType.text,
        autofocus: true,
        onEditingComplete: submit,
      ),
    );
  }

  submit() {
    if (_textEditingController.text.trim() == "") return;
    TodoProvider todoProvider = TodoProvider();
    todoProvider.insert(Todo(
        id: 0,
        date: DateTime(widget.year, widget.month, widget.day),
        done: 0,
        data: _textEditingController.text));
    widget.setTodoList();
    widget.todoListScrollController.animateTo(
        widget.todoListScrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease);
  }
}
