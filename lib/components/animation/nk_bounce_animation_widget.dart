import 'package:flutter/material.dart';
import 'package:m_and_r_quiz_admin_panel/theme/color/colors.dart';

class NkBouncingWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPress;

  const NkBouncingWidget({required this.child, super.key, this.onPress});

  @override
  State<NkBouncingWidget> createState() => _NkBouncingWidgetState();
}

class _NkBouncingWidgetState extends State<NkBouncingWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.9)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onPress == null) {
      return widget.child;
    } else {
      return InkWell(
        hoverColor: transparent,
        highlightColor: transparent,
        splashFactory: NoSplash.splashFactory,
        onTapDown: (TapDownDetails event) {
          _controller.forward();
        },
        onTapUp: (event) {
          _controller.reverse();
          if (widget.onPress == null) return;
          widget.onPress?.call();
        },
        child: ScaleTransition(
          scale: _scale,
          child: widget.child,
        ),
      );
    }
  }
}
