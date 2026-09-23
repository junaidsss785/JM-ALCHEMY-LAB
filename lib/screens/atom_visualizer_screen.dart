import 'package:flutter/material.dart';

class ElementData {
  final String name;
  final String symbol;
  final int number;
  final Color themeColor;

  ElementData({
    required this.name,
    required this.symbol,
    required this.number,
    required this.themeColor,
  });
}

class AtomVisualizerScreen extends StatelessWidget {
  const AtomVisualizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleElement = ElementData(
      name: 'Hydrogen',
      symbol: 'H',
      number: 1,
      themeColor: Colors.cyanAccent,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0F2027),
      appBar: AppBar(
        title: Text(
          '${sampleElement.name} Atom',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              size: const Size(250, 250),
              painter: AtomPainter(element: sampleElement),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: Column(
                children: [
                  Text(
                    sampleElement.symbol,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: sampleElement.themeColor,
                    ),
                  ),
                  Text(
                    'Atomic Number: ${sampleElement.number}',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AtomPainter extends CustomPainter {
  final ElementData element;

  AtomPainter({required this.element});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final orbitPaint = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final nucleusPaint = Paint()
      ..color = element.themeColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 80.0, orbitPaint);
    canvas.drawCircle(center, 25.0, nucleusPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
