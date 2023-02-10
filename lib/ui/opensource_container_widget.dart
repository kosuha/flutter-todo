import 'package:flutter/material.dart';
import '../bloc/constants.dart';

class OpensourceContainerWidget extends StatelessWidget {
  const OpensourceContainerWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 20 / 797 * Constant.kHeight),
      height: 60 / 797 * Constant.kHeight,
      child: Text(
        name,
        style: TextStyle(
          fontSize: 18 / 797 * Constant.kHeight,
        ),
      ),
    );
  }
}
