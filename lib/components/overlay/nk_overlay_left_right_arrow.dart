import 'package:flutter/material.dart';
import 'package:m_and_r_quiz_admin_panel/components/my_common_container.dart';

import '../../theme/color/colors.dart';

class NkOverlayLeftRightArrow {
  static Widget leftArrow(BuildContext context, {void Function()? onPressed}) {
    return MyCommnonContainer(
      borderRadiusGeometry: BorderRadius.circular(0),
      gradient: LinearGradient(
          colors: [black.withOpacity(0.3), black.withOpacity(0.3)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight),
      child: IconButton(
        onPressed: () {
          onPressed?.call();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
    );
  }

  static Widget rightArrow(BuildContext context, {void Function()? onPressed}) {
    return MyCommnonContainer(
        borderRadiusGeometry: BorderRadius.circular(0),
        gradient: LinearGradient(
            colors: [black.withOpacity(0.3), black.withOpacity(0.3)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
        child: IconButton(
          onPressed: () {
            onPressed?.call();
          },
          icon: const Icon(Icons.arrow_forward_ios),
        ));
  }
}
