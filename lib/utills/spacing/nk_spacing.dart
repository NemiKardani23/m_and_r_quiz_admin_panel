import 'package:flutter/cupertino.dart';
import 'package:m_and_r_quiz_admin_panel/utills/extentions/size_extention/size_extention.dart';

const EdgeInsets nkSmallPadding = EdgeInsets.all(8.0);
const EdgeInsets nkMediumPadding = EdgeInsets.all(18.0);

const EdgeInsets nkRegularPadding =
    EdgeInsets.all(18.0); // It's Use For Common Padding
const EdgeInsets nkLargePadding = EdgeInsets.all(36.0);
const EdgeInsets nkExtraLargePadding = EdgeInsets.all(46.0);
const EdgeInsets nkHorizontalPadding = EdgeInsets.symmetric(horizontal: 18.0);
const EdgeInsets nkVerticalPadding = EdgeInsets.symmetric(vertical: 18.0);

final SizedBox nkExtraSmallSizedBox = SizedBox(
  height: 2.0.h,
  width: 2.0.w,
);

final SizedBox nkSmallSizedBox = SizedBox(
  height: 4.0.h,
  width: 4.0.w,
);
final SizedBox nkMediumSizedBox = SizedBox(
  height: 8.0.h,
  width: 8.0.w,
);
final SizedBox nkRegularSizedBox = SizedBox(
  height: 8.0.h,
  width: 8.0.w,
);
final SizedBox nkLargeSizedBox = SizedBox(
  height: 16.0.h,
  width: 16.0.w,
);
final SizedBox nkExtraLargeSizedBox = SizedBox(
  height: 23.0.h,
  width: 23.0.w,
);

extension NkAddWidgetInSpace on List<Widget> {
  List<Widget> addSpaceEveryWidget({required Widget space}) {
    return [
      for (int i = 0; i < length; i++) ...[
        if (i == length - 1) ...[
          this[i],
        ] else ...[
          this[i],
          space
        ],
      ]
    ];
  }
}
