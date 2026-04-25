import 'package:flutter/material.dart';

class LaserScannerAnimation extends StatefulWidget {
  const LaserScannerAnimation({super.key});

  @override
  State<LaserScannerAnimation> createState() => _LaserScannerAnimationState();
}

class _LaserScannerAnimationState extends State<LaserScannerAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Animasi naik-turun dengan durasi 1.5 detik
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(double.infinity, 300),
          painter: _ScannerPainter(_controller.value),
        );
      },
    );
  }
}

class _ScannerPainter extends CustomPainter {
  final double animationValue;

  _ScannerPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height * animationValue;

    // Garis Laser Utama
    final paint = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4); // Memberikan efek glow

    canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);

    // Gradien Laser (Cahaya menyebar ke bawah)
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.cyanAccent.withOpacity(0.0),
          Colors.cyanAccent.withOpacity(0.3),
          Colors.cyanAccent.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, y - 30, size.width, 60));

    canvas.drawRect(Rect.fromLTWH(0, y - 30, size.width, 60), gradientPaint);
  }

  @override
  bool shouldRepaint(covariant _ScannerPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
