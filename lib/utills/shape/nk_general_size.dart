import 'dart:io';

import 'package:flutter/material.dart';

class NkGeneralSize {
  static double nkIconSize({double? iconSize}) => iconSize ?? 24;

  static final BorderRadius nkCommonBorderRadius = BorderRadius.circular(16);

  static const BorderRadius nkCommonSmoothBorderRadius =
      BorderRadius.all(Radius.circular(8));

  static const double nkCommoElevation = 10;

  static const FontWeight nkMediumBoldFontWeight = FontWeight.w600;

  static const FontWeight nkBoldFontWeight = FontWeight.bold;

  static const Duration nkCommonDuration = Duration(milliseconds: 500);
  static const Duration nkCommonLongDuration = Duration(milliseconds: 1500);
  static const Duration nkCommonExtraLongDuration =
      Duration(milliseconds: 3500);

  static ScrollPhysics commonPysics({ScrollPhysics? physics}) =>
      Platform.isAndroid
          ? physics ?? const AlwaysScrollableScrollPhysics()
          : physics ?? const AlwaysScrollableScrollPhysics();
}
