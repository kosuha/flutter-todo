import 'dart:async';
import 'package:flutter/material.dart';
import '../ui/bloc_display_widget.dart';
import '../model/todo.dart';
import '../bloc/constants.dart';

class TextInputView extends StatefulWidget {
  const TextInputView({
    required this.dailyListScrollController,
    required this.setTextWriteState,
    Key? key,
  }) : super(key: key);

  final ScrollController dailyListScrollController;
  final Function setTextWriteState;

  @override
  _TextInputViewState createState() => _TextInputViewState();
}

class _TextInputViewState extends State<TextInputView> {
  final _textEditingController = TextEditingController();
  final _textFieldFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            activeColor: Color(0x00ffffff),
            checkColor: Color(0xff00ff00),
            side: BorderSide(color: Color(0xffffffff)),
            value: false,
            onChanged: null),
        Expanded(
          child: Container(
              margin: EdgeInsets.only(right: (10 / 797 * Constant.kHeight)),
              child: TextField(
                focusNode: _textFieldFocus,
                controller: _textEditingController,
                style: TextStyle(
                    fontSize: (18 / 797 * Constant.kHeight),
                    color: Color(0xffffffff)),
                keyboardType: TextInputType.text,
                autocorrect: false,
                enableSuggestions: false,
                autofocus: true,
                cursorColor: Color(0x55ffffff),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffffffff)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffffffff)),
                  ),
                ),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                  widget.setTextWriteState(false);
                },
                onEditingComplete: submitEvent,
              )),
        ),
      ],
    );
  }

  submitEvent() {
    if (_textEditingController.text.trim() == "") return;
    DateTime selectedDate = calendarBloc.getSelectedDate();

    calendarBloc.insertTodo(Todo(
        id: 0,
        date: DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
        done: 0,
        data: _textEditingController.text,
        since: DateTime.now().millisecondsSinceEpoch));

    _textEditingController.text = "";

    Timer(Duration(milliseconds: 100), () {
      widget.dailyListScrollController.animateTo(
          widget.dailyListScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
    });
  }
}
