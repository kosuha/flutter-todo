import 'package:flutter/widgets.dart';

class Constant {
  static const String kVersion = "1.0.0";
  static const String kEmail = "studio.laum@gmail.com";
  static const List<String> kWeekdayStrings = [
    "SUN",
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT"
  ];
  static const List<String> kMonthStrings = [
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

  static late double kWidth;
  static late double kHeight;
  static late double kPaddingTop;

  static init(BuildContext context) {
    kWidth = MediaQuery.of(context).size.width;
    kHeight = MediaQuery.of(context).size.height;
    kPaddingTop = MediaQuery.of(context).padding.top;
    if (kWidth / kHeight < 9 / 19.5) {
      kHeight = (kWidth / 9) * 19.5;
    }
  }

  static getSize(double size) {
    if ((kWidth / kHeight).toStringAsFixed(2) == (9 / 16).toStringAsFixed(2)) {
      return size / 390.0 * Constant.kWidth;
    }
    if ((kWidth / kHeight).toStringAsFixed(2) ==
        (9 / 19.5).toStringAsFixed(2)) {
      return size / 844.0 * Constant.kHeight;
    }
    return size / 844.0 * Constant.kHeight;
  }
}
