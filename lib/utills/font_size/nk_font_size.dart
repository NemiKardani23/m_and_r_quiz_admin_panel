import 'package:flutter/cupertino.dart';
import 'package:m_and_r_quiz_admin_panel/utills/extentions/size_extention/size_extention.dart';

class NkFontSize {
  static BuildContext? context;
  NkFontSize.init(BuildContext ctx) {
    context = ctx;
    // nkDevPrint("FONTS SIZES ${toString()}");
  }
  static final double extraSmallFont = 8.0.sp;
  static final double smallFont = 12.sp;
  static final double mediumFont = 16.sp;
  static final double regularFont = 16.sp;
  static final double headingFont = 20.sp;
  static final double largeFont = 24.sp;
  static final double extraLargeFont = 32.sp;

  // static double _textScaleFactor({double maxTextScaleFactor = 2}) {
  //   double val =
  //       ((AppRoutes.navigatorKey!.currentContext?.width ?? context!.width) /
  //               1400) *
  //           maxTextScaleFactor;
  //   return max(1, min(val, maxTextScaleFactor));
  // }

  @override
  String toString() {
    return "\n ExtraSmallFont:$extraSmallFont \n SmallFont: $smallFont \n mediumFont: $mediumFont \n regularFont: $regularFont \n largeFont: $largeFont \n extraLargeFont: $extraLargeFont";
  }
}
