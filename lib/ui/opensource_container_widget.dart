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
      margin: EdgeInsets.symmetric(
        horizontal: Constant.getSize(20.0),
      ),
      height: Constant.getSize(60.0),
      child: Text(
        name,
        style: TextStyle(
          color: Color(0xffffffff),
          fontSize: Constant.getSize(18.0),
        ),
      ),
    );
  }
}
