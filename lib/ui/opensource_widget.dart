import 'package:flutter/material.dart';
import '../bloc/constants.dart';
import 'opensource_container_widget.dart';

class OpensourceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff252525),
        appBar: AppBar(
          backgroundColor: Color(0x00ffffff),
          elevation: 0,
          title: Text(
            "라이선스",
            style: TextStyle(
                color: Color(0xffffffff), fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff777777),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: ListView(
          children: [
            OpensourceContainerWidget(name: "flutter"),
            OpensourceContainerWidget(name: "sqflite"),
            OpensourceContainerWidget(name: "path"),
            OpensourceContainerWidget(name: "path_provider"),
            OpensourceContainerWidget(name: "flutter_slidable"),
            OpensourceContainerWidget(name: "Pretendard (Font)"),
          ],
        ));
  }
}

/*

bloc: 데이터 처리


components: 처리된 데이터를 ui에 보내주기


ui: 화면을 그려줌

*/
