import 'package:flutter/material.dart';

class AnimatedGridBackground extends StatelessWidget {
  final Widget child;

  const AnimatedGridBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Primary color background
        Container(
          color: const Color(0xFF0F172A), // Set primary color as the base background
        ),
        // Static grid overlay
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: GridPainter(),
        ),
        // Main content passed to the widget
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}

// CustomPainter class to draw the grid lines
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05) // Light color for grid lines
      ..strokeWidth = 0.5;

    // Draw vertical grid lines
    for (double x = 0; x <= size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal grid lines
    for (double y = 0; y <= size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint as the grid is static
  }
}
