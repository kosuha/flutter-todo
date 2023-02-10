import 'package:flutter/material.dart';
import 'contact_widget.dart';
import 'bloc_display_widget.dart';
import '../bloc/constants.dart';
import 'opensource_widget.dart';

class SettingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x00ffffff),
          elevation: 0,
          title: Text(
            "설정",
            style: TextStyle(
                color: Color(0xff000000), fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff333333),
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
                margin: EdgeInsets.symmetric(
                    horizontal: 20 / 797 * Constant.kHeight),
                height: 60 / 797 * Constant.kHeight,
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0x11000000)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("문의하기",
                        style: TextStyle(
                          fontSize: 18 / 797 * Constant.kHeight,
                        )),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15 / 797 * Constant.kHeight,
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
                margin: EdgeInsets.symmetric(
                    horizontal: 20 / 797 * Constant.kHeight),
                height: 60 / 797 * Constant.kHeight,
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0x11000000)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("오픈소스",
                        style: TextStyle(
                          fontSize: 18 / 797 * Constant.kHeight,
                        )),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15 / 797 * Constant.kHeight,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 20 / 797 * Constant.kHeight),
              height: 60 / 797 * Constant.kHeight,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0x11000000)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "버전",
                    style: TextStyle(
                      fontSize: 18 / 797 * Constant.kHeight,
                    ),
                  ),
                  Text(
                    "1.0.0",
                    style: TextStyle(
                      fontSize: 16 / 797 * Constant.kHeight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

/*

bloc: 데이터 처리


components: 처리된 데이터를 ui에 보내주기


ui: 화면을 그려줌

*/
