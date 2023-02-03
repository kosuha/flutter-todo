import 'package:flutter/material.dart';

class WriteTodoWidget extends StatelessWidget {
  const WriteTodoWidget({super.key});

  // const WriteTodoWidget({Key? key, required this.setAddState})
  //     : super(key: key);

  // final Function setAddState;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      // margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              autofocus: true,
            ),
          ),
          IconButton(onPressed: null, icon: Icon(Icons.arrow_upward))
        ],
      ),
    );
  }
}
