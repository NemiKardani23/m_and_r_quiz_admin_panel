import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension DialogAnimation on Widget {
  Widget get dialogAnimation {
    return animate(
      key: UniqueKey(),
      autoPlay: true,
    ).fadeIn(duration: 900.ms).flip(
          curve: Curves.fastEaseInToSlowEaseOut,
          end: 2,
          begin: 1,
          duration: 500.ms,
          perspective: 1.0,
        );
  }
}
