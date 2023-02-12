import 'package:flutter/material.dart';
import 'contact_widget.dart';
import '../bloc/constants.dart';
import 'opensource_widget.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff252525),
        appBar: AppBar(
          backgroundColor: Color(0x00252525),
          elevation: 0,
          title: Text(
            "설정",
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactWidget(),
                    ));
              },
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: Constant.getSize(20.0)),
                height: Constant.getSize(60.0),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0x11ffffff)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("문의하기",
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: Constant.getSize(18.0),
                        )),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: Constant.getSize(15.0),
                      color: Color(0xffffffff),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OpensourceWidget(),
                    ));
              },
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: Constant.getSize(20.0)),
                height: Constant.getSize(60.0),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0x11ffffff)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("오픈소스",
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: Constant.getSize(18.0),
                        )),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: Constant.getSize(15.0),
                      color: Color(0xffffffff),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Constant.getSize(20.0)),
              height: Constant.getSize(60.0),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0x11ffffff)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "버전",
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: Constant.getSize(18.0),
                    ),
                  ),
                  Text(
                    Constant.kVersion,
                    style: TextStyle(
                      fontSize: Constant.getSize(16.0),
                      color: Color(0xffffffff),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
