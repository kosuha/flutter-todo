import 'package:flutter/material.dart';

class TodoRowWidget extends StatefulWidget {
  // const TodoRowWidget({super.key});
  const TodoRowWidget({Key? key, required this.done, required this.text})
      : super(key: key);

  final bool done;
  final String text;

  @override
  State<TodoRowWidget> createState() => TodoRowWidgetState();
}

class TodoRowWidgetState extends State<TodoRowWidget> {
  bool checked = false;

  @override
  void initState() {
    super.initState();
    checked = widget.done;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 16);
    if (checked == true) {
      textStyle =
          TextStyle(fontSize: 16, decoration: TextDecoration.lineThrough);
    } else {
      TextStyle(fontSize: 16);
    }

    return Flex(
      direction: Axis.horizontal,
      children: [
        Checkbox(
            activeColor: Color(0x00000000),
            checkColor: Color(0xff00ff00),
            side: BorderSide(color: Color(0xff000000)),
            value: checked,
            onChanged: (value) {
              if (value == true) {
                setState(() {
                  checked = true;
                });
              } else {
                setState(() {
                  checked = false;
                });
              }
            }),
        Expanded(
          child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Text(
                widget.text,
                style: textStyle,
              )),
        ),
      ],
    );
  }
}
