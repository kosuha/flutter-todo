import 'dart:async';
import 'package:flutter/material.dart';
import '../ui/bloc_display_widget.dart';
import '../model/todo.dart';
import '../bloc/constants.dart';

class DailyTodoView extends StatefulWidget {
  const DailyTodoView({
    required this.todo,
    // required this.setTextWriteState,
    Key? key,
  }) : super(key: key);

  final Todo todo;
  // final Function setTextWriteState;

  @override
  _DailyTodoViewState createState() => _DailyTodoViewState();
}

class _DailyTodoViewState extends State<DailyTodoView> {
  final _textEditingController = TextEditingController();
  bool optionState = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: (16 / 797 * Constant.kHeight));
    if (widget.todo.done == 1) {
      textStyle = TextStyle(
          fontSize: (16 / 797 * Constant.kHeight),
          decoration: TextDecoration.lineThrough);
    } else {
      TextStyle(fontSize: (16 / 797 * Constant.kHeight));
    }

    Color borderColor = Color(0xff000000);

    if (optionState) {
      borderColor = Color(0xff000000);
    } else {
      borderColor = Color(0x00000000);
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 1),
        padding: EdgeInsets.all(5 / 797 * Constant.kHeight),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(10 / 797 * Constant.kHeight)),
        child: Row(
          children: [
            Checkbox(
                activeColor: Color(0x00000000),
                checkColor: Color(0xff00ff00),
                side: BorderSide(color: Color(0xff000000)),
                value: isTrue(widget.todo.done),
                onChanged: (value) {
                  int checked = 0;
                  if (value == true) {
                    checked = 1;
                  } else {
                    checked = 0;
                  }
                  calendarBloc.setDone(widget.todo.since, checked);
                }),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _textEditingController.text = widget.todo.data;
                  showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Color(0xffffffff),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                        top: Radius.circular((30 / 797 * Constant.kHeight)),
                      )),
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                              padding:
                                  EdgeInsets.all((10 / 797 * Constant.kHeight)),
                              child: TextField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                                enableSuggestions: false,
                                autofocus: true,
                                cursorColor: Color(0x55000000),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff000000)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff000000)),
                                  ),
                                ),
                                onEditingComplete: () {
                                  if (_textEditingController.text.trim() == "")
                                    return;
                                  submit();
                                  Navigator.pop(context);
                                },
                              )),
                        );
                      });
                },
                child: Container(
                    margin:
                        EdgeInsets.only(right: (10 / 797 * Constant.kHeight)),
                    child: Text(
                      widget.todo.data,
                      style: textStyle,
                    )),
              ),
            ),
          ],
        ));
  }

  submit() {
    widget.todo.data = _textEditingController.text;
    calendarBloc.editTodo(widget.todo);
  }

  bool isTrue(int n) {
    if (n == 0) {
      return false;
    } else {
      return true;
    }
  }
}
