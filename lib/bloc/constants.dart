import 'package:flutter/widgets.dart';

class Constant {
  static late double kWidth;
  static late double kHeight;

  static init(BuildContext context) {
    kWidth = MediaQuery.of(context).size.width;
    kHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    if (kWidth / kHeight < 9 / 19.5) {
      kHeight = (kWidth / 9) * 19.5;
    }
    // 390 797 = iPhone13
  }
}
