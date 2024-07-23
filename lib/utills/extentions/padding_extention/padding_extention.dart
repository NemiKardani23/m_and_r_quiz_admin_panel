import 'package:flutter/material.dart';

extension PaddingExtension on num {
  EdgeInsets get all => EdgeInsets.all(toDouble());

  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get symmetric =>
      EdgeInsets.symmetric(horizontal: toDouble(), vertical: toDouble());

  EdgeInsets get onlyTop => EdgeInsets.only(top: toDouble());
  EdgeInsets get onlyBottom => EdgeInsets.only(bottom: toDouble());
  EdgeInsets get onlyLeft => EdgeInsets.only(left: toDouble());
  EdgeInsets get onlyRight => EdgeInsets.only(right: toDouble());
}
