import 'package:flutter/material.dart';

class AddTodoWidget extends StatelessWidget {
  const AddTodoWidget({Key? key, required this.setAddState}) : super(key: key);

  final Function setAddState;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        setAddState(true);
      },
      backgroundColor: Color(0xffffffff),
      foregroundColor: Color(0xff000000),
      child: Icon(Icons.add),
    );
  }
}
