import 'package:flutter/material.dart';

class USizes {
  static const double s10 = 10.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;

  static double deviceHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double deviceWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }
}
