import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bloc/constants.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff252525),
        appBar: AppBar(
          backgroundColor: Color(0x00ffffff),
          elevation: 0,
          title: Text(
            "문의하기",
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
                _sendEmail(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Constant.getSize(20.0),
                ),
                height: Constant.getSize(60.0),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0x11ffffff)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "E-mail",
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: Constant.getSize(18.0),
                      ),
                    ),
                    Text(
                      Constant.kEmail,
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: Constant.getSize(16.0),
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
      recipients: [Constant.kEmail],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      _showErrorAlert(context);
    }
  }

  Future<void> _showErrorAlert(BuildContext context) async {
    return showDialog<void>(
      //다이얼로그 위젯 소환
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("알림"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('사용 가능한 메일 앱이 없습니다.'),
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
