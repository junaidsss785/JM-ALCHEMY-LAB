import 'package:flutter/material.dart';

class ElementData {
  final String name;
  final Color themeColor;

  ElementData({required this.name, required this.themeColor});
}

class AtomVisualizerScreen extends StatelessWidget {
  const AtomVisualizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleElement = ElementData(name: 'Hydrogen', themeColor: Colors.blueAccent);

    return Scaffold(
      appBar: AppBar(
        title: Text(sampleElement.name),
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(300, 300),
          painter: AtomPainter(element: sampleElement),
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

    final nucleusPaint = Paint()
      ..color = element.themeColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 20.0, nucleusPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
