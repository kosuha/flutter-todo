import 'package:flutter/widgets.dart';

class Constant {
  static late double kWidth;
  static late double kHeight;

  static init(BuildContext context) {
    kWidth = MediaQuery.of(context).size.width;
    kHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    print("$kWidth, $kHeight");
    // 390 797
  }
}
