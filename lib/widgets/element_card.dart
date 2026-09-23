import 'package:flutter/material.dart';
import '../models/element_model.dart';
import '../screens/atom_visualizer_screen.dart';

class ElementCard extends StatelessWidget {
  final ElementModel element;
  final VoidCallback onTap;

  const ElementCard({
    super.key,
    required this.element,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AtomVisualizerScreen(element: element),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E2530),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: element.themeColor.withOpacity(0.4), width: 1.5),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(element.iconSymbol, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 6),
            Text(
              element.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Text(
              element.formula,
              style: TextStyle(
                color: element.themeColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
