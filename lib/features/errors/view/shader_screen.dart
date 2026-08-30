import 'dart:math' as math;
import 'package:flutter/material.dart';

class ShaderScreen extends StatefulWidget {
  const ShaderScreen({super.key});

  @override
  State<ShaderScreen> createState() => _ShaderScreenState();
}

class _ShaderScreenState extends State<ShaderScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _PulseShaderPainter(_controller.value * 2 * math.pi),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _PulseShaderPainter extends CustomPainter {
  final double time;

  _PulseShaderPainter(this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final Color color1 = const Color(0xFF003ec7);
    final Color color2 = const Color(0xFF0D0D33);
    
    final pulse = 0.5 + 0.5 * math.sin(time * 2.0);

    final Rect rect = Offset.zero & size;

    final Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.lerp(color2, color1, 0.2 + pulse * 0.1)!,
          Color.lerp(color2, color1, 0.8 + pulse * 0.1)!,
        ],
      ).createShader(rect);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant _PulseShaderPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}
