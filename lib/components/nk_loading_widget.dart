import 'package:flutter/cupertino.dart';
import 'package:m_and_r_quiz_admin_panel/theme/color/colors.dart';

class NkLoadingWidget extends StatelessWidget {
  final Color color;
  final double radius;
  final bool animating;
  const NkLoadingWidget(
      {super.key,
      this.color = progressBarColor,
      this.radius = 10,
      this.animating = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: color,
        radius: radius,
        animating: animating,
      ),
    );
  }

  NkLoadingWidget.partiallyRevealed(
      {super.key,
      required double progress,
      this.color = progressBarColor,
      this.radius = 10,
      this.animating = true}) {
    Center(
      child: CupertinoActivityIndicator.partiallyRevealed(
        progress: progress / 100,
        color: color,
        radius: radius,
      ),
    );
  }
}
