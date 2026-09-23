import 'package:flutter/material.dart';
import '../models/element_model.dart';

class WorkspaceSlot extends StatelessWidget {
  final ElementModel? element;
  final String label;
  final Function(ElementModel) onClearTap;

  const WorkspaceSlot({
    super.key,
    required this.element,
    required this.label,
    required this.onClearTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: element != null
            ? element!.themeColor.withOpacity(0.15)
            : const Color(0xFF1E2530),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: element != null ? element!.themeColor : Colors.white24,
          width: 2,
        ),
      ),
      child: element == null
          ? Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        element!.iconSymbol,
                        style: const TextStyle(fontSize: 28),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        element!.name,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        element!.formula,
                        style: TextStyle(
                          color: element!.themeColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => onClearTap(element!),
                    child: const Icon(
                      Icons.cancel,
                      size: 18,
                      color: Colors.white54,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
