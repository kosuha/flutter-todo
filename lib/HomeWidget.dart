import 'package:flutter/material.dart';
import 'CalendarWidget.dart';
import 'TodoWidget.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flex(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      direction: Axis.vertical,
      children: [
        CalendarWidget(),
        TodoWidget(),
      ],
    );
  }
}
