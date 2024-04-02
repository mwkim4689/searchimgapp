import 'package:flutter/material.dart';

class AppUtils {
  static double getAppBarHeight(BuildContext context) {
    return AppBar().preferredSize.height;
  }

  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double get2BarHeight(BuildContext context) {
    return AppBar().preferredSize.height + MediaQuery.of(context).padding.top;
  }
}
