import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:m_and_r_quiz_admin_panel/utills/shape/nk_general_size.dart';

extension BasicAnimation on Widget {
  Widget get fadeRightAnimation {
    return animate(
      key: UniqueKey(),
      autoPlay: true,
    ).fadeIn(duration: NkGeneralSize.nkCommonDuration).slide(
          curve: Curves.easeInOutSine,
          end: const Offset(0, 0),
          duration: NkGeneralSize.nkCommonDuration,
          begin: const Offset(1, 0),
        );
  }

  Widget get fadeLeftAnimation {
    return animate(
      key: UniqueKey(),
      autoPlay: true,
    ).fadeIn(duration: NkGeneralSize.nkCommonDuration).slide(
          curve: Curves.easeInOutSine,
          end: const Offset(0, 0),
          duration: NkGeneralSize.nkCommonDuration,
          begin: const Offset(-1, 0),
        );
  }

  Widget get fadeUpAnimation {
    return animate(
      key: UniqueKey(),
      autoPlay: true,
    ).fadeIn(duration: NkGeneralSize.nkCommonDuration).slide(
          curve: Curves.easeInOutSine,
          end: const Offset(0, 0),
          duration: NkGeneralSize.nkCommonDuration,
          begin: const Offset(0, -1),
        );
  }

  Widget get fadeDownAnimation {
    return animate(
      key: UniqueKey(),
      autoPlay: true,
    ).fadeIn(duration: NkGeneralSize.nkCommonDuration).slide(
          curve: Curves.easeInOutSine,
          end: const Offset(0, 0),
          duration: NkGeneralSize.nkCommonDuration,
          begin: const Offset(0, 1),
        );
  }
}
