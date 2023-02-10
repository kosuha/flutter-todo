import 'package:flutter/material.dart';

import '../bloc/constants.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x00ffffff),
          elevation: 0,
          title: Text(
            "문의하기",
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
                _sendEmail(context);
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
                    Text(
                      "E-mail",
                      style: TextStyle(
                        fontSize: 18 / 797 * Constant.kHeight,
                      ),
                    ),
                    Text(
                      "studio.laum@gmail.com",
                      style: TextStyle(
                        fontSize: 16 / 797 * Constant.kHeight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void _sendEmail(BuildContext context) async {
    final Email email = Email(
      body: '',
      subject: '[TODO 문의]',
      recipients: ["studio.laum@gmail.com"],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    try {
      _showErrorAlert(context);
    } catch (error) {
      // await FlutterEmailSender.send(email);
    }
  }

  Future<void> _showErrorAlert(BuildContext context) async {
    return showDialog<void>(
      //다이얼로그 위젯 소환
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('제목'),
          content: SingleChildScrollView(
            child: ListBody(
              //List Body를 기준으로 Text 설정
              children: <Widget>[
                Text('Alert Dialog 입니다'),
                Text('OK를 눌러 닫습니다'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

/*

bloc: 데이터 처리


components: 처리된 데이터를 ui에 보내주기


ui: 화면을 그려줌

*/
