import 'dart:math';
import 'package:flutter/material.dart';
import '../models/element_model.dart';

class AtomVisualizerScreen extends StatefulWidget {
  final ElementModel element;

  const AtomVisualizerScreen({super.key, required this.element});

  @override
  State<AtomVisualizerScreen> createState() => _AtomVisualizerScreenState();
}

class _AtomVisualizerScreenState extends State<AtomVisualizerScreen>
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

  List<int> _calculateShells(int atomicNumber) {
    List<int> maxShellCapacity = [2, 8, 18, 32, 50, 72, 98];
    List<int> shells = [];
    int remaining = atomicNumber;

    for (int capacity in maxShellCapacity) {
      if (remaining <= 0) break;
      if (remaining >= capacity) {
        shells.add(capacity);
        remaining -= capacity;
      } else {
        shells.add(remaining);
        remaining = 0;
      }
    }
    return shells;
  }

  @override
  Widget build(BuildContext context) {
    final shells = _calculateShells(widget.element.atomicNumber);

    return Scaffold(
      backgroundColor: const Color(0xFF0F141C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161B22),
        elevation: 0,
        title: Text(
          '${widget.element.name} (${widget.element.formula}) - Atomic Structure',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    size: const Size(300, 300),
                    painter: AtomPainter(
                      element: widget.element,
                      shells: shells,
                      angle: _controller.value * 2 * pi,
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF161B22),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.element.name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: widget.element.themeColor,
                      ),
                    ),
                    Chip(
                      backgroundColor: widget.element.themeColor.withOpacity(0.2),
                      label: Text(
                        widget.element.category,
                        style: TextStyle(color: widget.element.themeColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Atomic Number: ${widget.element.atomicNumber} | Atomic Mass: ${widget.element.atomicMass} u',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                Text(
                  'State: ${widget.element.stateOfMatter} | Bonding: ${widget.element.bondingType}',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Real-World Application:',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.element.realWorldUse,
                  style: const TextStyle(color: Colors.white60, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AtomPainter extends CustomPainter {
  final ElementModel element;
  final List<int> shells;
  final double angle;

  AtomPainter({
    required this.element,
    required this.shells,
    required this.angle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final nucleusPaint = Paint()
      color = element.themeColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 18, nucleusPaint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: element.formula,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );

    final orbitPaint = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final electronPaint = Paint()
      ..color = const Color(0xFF00B4D8)
      ..style = PaintingStyle.fill;

    double radius = 40.0;
    for (int i = 0; i < shells.length; i++) {
      canvas.drawCircle(center, radius, orbitPaint);

      int electronsCount = shells[i];
      double speedMultiplier = (i % 2 == 0) ? 1.0 : -1.0;

      for (int j = 0; j < electronsCount; j++) {
        double electronAngle = (2 * pi / electronsCount) * j + (angle * speedMultiplier);
        double x = center.dx + radius * cos(electronAngle);
        double y = center.dy + radius * sin(electronAngle);

        canvas.drawCircle(Offset(x, y), 4.5, electronPaint);
      }
      radius += 30.0;
    }
  }

  @override
  bool shouldRepaint(covariant AtomPainter oldDelegate) => true;
}
