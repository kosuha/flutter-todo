import 'package:flutter/material.dart';

class MonthTitleWidget extends StatelessWidget {
  const MonthTitleWidget({
    Key? key,
    required this.year,
    required this.monthString,
  }) : super(key: key);

  final int year;
  final String monthString;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.center,
        direction: Axis.horizontal,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              monthString,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              "$year",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
