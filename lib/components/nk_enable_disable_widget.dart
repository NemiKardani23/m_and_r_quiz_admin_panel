import 'package:flutter/material.dart';

class NkEnableDisableWidget extends StatelessWidget {
  final bool isEnable;
  final Widget child;
  const NkEnableDisableWidget(
      {super.key, this.isEnable = true, required this.child});

  @override
  Widget build(BuildContext context) {
    if (isEnable) {
      return child;
    } else {
      return Opacity(
        opacity: 0.5,
        child: IgnorePointer(
          ignoring: true,
          child: child,
        ),
      );
    }
  }
}
