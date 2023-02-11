import 'package:flutter/material.dart';
import 'contact_widget.dart';
import '../bloc/constants.dart';
import 'opensource_widget.dart';

class SettingWidget extends StatelessWidget {
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
                margin: EdgeInsets.symmetric(
                    horizontal: 20 / 797 * Constant.kHeight),
                height: 60 / 797 * Constant.kHeight,
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
                          fontSize: 18 / 797 * Constant.kHeight,
                        )),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15 / 797 * Constant.kHeight,
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
                margin: EdgeInsets.symmetric(
                    horizontal: 20 / 797 * Constant.kHeight),
                height: 60 / 797 * Constant.kHeight,
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
                          fontSize: 18 / 797 * Constant.kHeight,
                        )),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15 / 797 * Constant.kHeight,
                      color: Color(0xffffffff),
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
                  border: Border(bottom: BorderSide(color: Color(0x11ffffff)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "버전",
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18 / 797 * Constant.kHeight,
                    ),
                  ),
                  Text(
                    Constant.version,
                    style: TextStyle(
                      fontSize: 16 / 797 * Constant.kHeight,
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

/*

bloc: 데이터 처리


components: 처리된 데이터를 ui에 보내주기


ui: 화면을 그려줌

*/
