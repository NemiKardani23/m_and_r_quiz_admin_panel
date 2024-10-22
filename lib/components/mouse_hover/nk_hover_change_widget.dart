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

import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:m_and_r_quiz_admin_panel/utills/shape/nk_general_size.dart';

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
      firstCurve: Curves.easeInOutCubicEmphasized,
      secondCurve: Curves.easeInOutCubicEmphasized,
      sizeCurve: Curves.easeInOutCubicEmphasized,
    );
  }

  static Widget hoverWidget({
    required final Widget child,
    required final Widget hoverChild,
    AlignmentGeometry alignmentry = Alignment.center,
  }) {
    return HoverWidget(
      onHover: (event) {
        
      },
      hoverChild: hoverChild,
      child: child,
    );
  }
}
