import 'package:flutter/widgets.dart';

class Constant {
  static late double kWidth;
  static late double kHeight;
  static const String version = "1.0.0";
  static const String email = "studio.laum@gmail.com";
  static const List<String> weekdayStrings = [
    "SUN",
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT"
  ];
  static const List<String> monthStrings = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  static init(BuildContext context) {
    kWidth = MediaQuery.of(context).size.width;
    kHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    if (kWidth / kHeight < 9 / 19.5) {
      kHeight = (kWidth / 9) * 19.5;
    }
  }
}
