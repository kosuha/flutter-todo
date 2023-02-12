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
    TextStyle textStyle = TextStyle(fontSize: (16 / 797 * Constant.kHeight));
    if (widget.todo.done == 1) {
      textStyle = TextStyle(
          color: Color(0xffffffff),
          fontSize: (18 / 797 * Constant.kHeight),
          decoration: TextDecoration.lineThrough);
    } else {
      textStyle = TextStyle(
          color: Color(0xffffffff), fontSize: (18 / 797 * Constant.kHeight));
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
            vertical: 3 / 797 * Constant.kHeight,
            horizontal: 5 / 797 * Constant.kHeight),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(10 / 797 * Constant.kHeight)),
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
