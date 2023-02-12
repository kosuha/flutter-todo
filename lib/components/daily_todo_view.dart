import 'package:flutter/material.dart';
import '../ui/bloc_display_widget.dart';
import '../model/todo.dart';
import '../bloc/constants.dart';

class DailyTodoView extends StatefulWidget {
  const DailyTodoView({
    required this.todo,
    Key? key,
  }) : super(key: key);

  final Todo todo;

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
    TextStyle textStyle = TextStyle(
      fontSize: Constant.getSize(16.0),
    );
    if (widget.todo.done == 1) {
      textStyle = TextStyle(
          color: Color(0xffffffff),
          fontSize: Constant.getSize(18.0),
          decoration: TextDecoration.lineThrough);
    } else {
      textStyle = TextStyle(
        color: Color(0xffffffff),
        fontSize: Constant.getSize(18.0),
      );
    }

    Color borderColor = Color(0xffffffff);

    if (optionState) {
      borderColor = Color(0xffffffff);
    } else {
      borderColor = Color(0x00ffffff);
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 1),
        padding: EdgeInsets.symmetric(
          vertical: Constant.getSize(3.0),
          horizontal: Constant.getSize(3.0),
        ),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(
              Constant.getSize(10.0),
            )),
        child: Row(
          children: [
            Checkbox(
                activeColor: Color(0x00ffffff),
                checkColor: Color(0xff00ff00),
                side: BorderSide(color: Color(0x77ffffff)),
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
                      backgroundColor: Color(0xff252525),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          Constant.getSize(30.0),
                        ),
                      )),
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                              padding: EdgeInsets.all(
                                Constant.getSize(10.0),
                              ),
                              child: TextField(
                                maxLength: 2000,
                                style: TextStyle(color: Color(0xffffffff)),
                                controller: _textEditingController,
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                                enableSuggestions: false,
                                autofocus: true,
                                cursorColor: Color(0x55ffffff),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffffffff)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffffffff)),
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
                    margin: EdgeInsets.only(
                      right: Constant.getSize(10.0),
                    ),
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
