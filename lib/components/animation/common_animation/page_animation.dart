import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension PageAnimation on Widget {
  Widget get pageAnimation {
    return animate(
      key: UniqueKey(),
      autoPlay: true,
    ).fadeIn(duration: 900.ms).slide(
          curve: Curves.easeInOutSine,
          end: const Offset(0, 0),
          duration: 1000.ms,
          begin: const Offset(1, 0),
        );
  }
}
