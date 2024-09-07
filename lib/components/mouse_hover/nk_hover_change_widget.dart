// import 'package:flutter/material.dart';
//
// class NkHoverChangeWidget extends StatelessWidget {
//   const NkHoverChangeWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return;
//   }
// }

import 'package:hovering/hovering.dart';
import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

//////// Handle [Web] Hover Effect
class NkHoverChangeWidget {
  static Widget hoverCrossFadeWidget({
    required final Widget firstChild,
    required final Widget secondChild,
    AlignmentGeometry alignmentry = Alignment.center,
  }) {
    return HoverCrossFadeWidget(
      firstChild: firstChild,
      secondChild: secondChild,
      duration: NkGeneralSize.nkCommonDuration,
      alignmentry: alignmentry,
      firstCurve: Curves.fastOutSlowIn,
      secondCurve: Curves.fastOutSlowIn,
      sizeCurve: Curves.fastOutSlowIn,
    );
  }

  static Widget hoverToOverlay({
    required final Widget child,
    required final Widget overlayChild,
    AlignmentGeometry alignmentry = Alignment.center,
  }) {
    final childData = child;
    return HoverWidget(
        hoverChild: Stack(
          alignment: alignmentry,
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(child: childData),
            Positioned.fill(
              child: ColoredBox(
                  color: secondaryColor.withOpacity(0.5), child: overlayChild),
            ),
          ],
        ),
        onHover: (val) {},
        child: childData);
  }
}
