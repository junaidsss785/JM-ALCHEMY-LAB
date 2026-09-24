import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabExperimentScreen extends StatefulWidget {
  const LabExperimentScreen({super.key});

  @override
  State<LabExperimentScreen> createState() => _LabExperimentScreenState();
}

class _LabExperimentScreenState extends State<LabExperimentScreen> {
  List<dynamic> allElements = [];
  Map<String, String> reactions = {};

  String statusMessage = 'ایک ایلیمنٹ کو دوسرے ایلیمنٹ پر ڈریگ (Drag) کر کے رکھیں۔';
  String reactionResult = '';

  @override
  void initState() {
    super.initState();
    _loadFullLabData();
  }

  Future<void> _loadFullLabData() async {
    try {
      final String response = await rootBundle.loadString('assets/data/reactions.json');
      final data = json.decode(response);

      setState(() {
        allElements = data['elements'] ?? _getFallbackElements();
        
        if (data['reactions'] != null) {
          for (var r in data['reactions']) {
            String key1 = "${r['reactants'][0]}+${r['reactants'][1]}";
            String key2 = "${r['reactants'][1]}+${r['reactants'][0]}";
            String val = "${r['product']} (${r['formula'] ?? ''})";
            reactions[key1] = val;
            reactions[key2] = val;
          }
        }
      });
    } catch (e) {
      setState(() {
        allElements = _getFallbackElements();
        reactions = _getFallbackReactions();
      });
    }
  }

  List<dynamic> _getFallbackElements() {
    return [
      {'name': 'Hydrogen', 'symbol': 'H', 'number': 1},
      {'name': 'Helium', 'symbol': 'He', 'number': 2},
      {'name': 'Lithium', 'symbol': 'Li', 'number': 3},
      {'name': 'Carbon', 'symbol': 'C', 'number': 6},
      {'name': 'Nitrogen', 'symbol': 'N', 'number': 7},
      {'name': 'Oxygen', 'symbol': 'O', 'number': 8},
      {'name': 'Sodium', 'symbol': 'Na', 'number': 11},
      {'name': 'Magnesium', 'symbol': 'Mg', 'number': 12},
      {'name': 'Aluminum', 'symbol': 'Al', 'number': 13},
      {'name': 'Silicon', 'symbol': 'Si', 'number': 14},
      {'name': 'Phosphorus', 'symbol': 'P', 'number': 15},
      {'name': 'Sulfur', 'symbol': 'S', 'number': 16},
      {'name': 'Chlorine', 'symbol': 'Cl', 'number': 17},
      {'name': 'Potassium', 'symbol': 'K', 'number': 19},
      {'name': 'Calcium', 'symbol': 'Ca', 'number': 20},
      {'name': 'Iron', 'symbol': 'Fe', 'number': 26},
      {'name': 'Copper', 'symbol': 'Cu', 'number': 29},
      {'name': 'Gold', 'symbol': 'Au', 'number': 79},
    ];
  }

  Map<String, String> _getFallbackReactions() {
    return {
      'H+O': 'Water (H₂O)',
      'O+H': 'Water (H₂O)',
      'Na+Cl': 'Salt (NaCl)',
      'Cl+Na': 'Salt (NaCl)',
      'C+O': 'Carbon Dioxide (CO₂)',
      'O+C': 'Carbon Dioxide (CO₂)',
      'Fe+O': 'Rust (Fe₂O₃)',
      'O+Fe': 'Rust (Fe₂O₃)',
      'H+Cl': 'Hydrochloric Acid (HCl)',
      'Cl+H': 'Hydrochloric Acid (HCl)',
    };
  }

  void _handleReaction(dynamic draggedElement, dynamic targetElement) {
    if (draggedElement == targetElement) return;

    String sym1 = draggedElement['symbol'];
    String sym2 = targetElement['symbol'];
    String key = "$sym1+$sym2";

    setState(() {
      if (reactions.containsKey(key)) {
        statusMessage = 'Reaction Successful! 🎉';
        reactionResult = '${draggedElement['name']} + ${targetElement['name']}\n➜ ${reactions[key]}';
      } else {
        statusMessage = 'No Reaction Occurred 🔬';
        reactionResult = '${draggedElement['name']} and ${targetElement['name']} do not react.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alchemy Lab Bench'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Status Display Box
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.cyanAccent),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      statusMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.cyanAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (reactionResult.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        reactionResult,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: allElements.length,
                itemBuilder: (context, index) {
                  final item = allElements[index];

                  return DragTarget<dynamic>(
                    onAcceptWithDetails: (details) {
                      _handleReaction(details.data, item);
                    },
                    builder: (context, candidateData, rejectedData) {
                      final isHovered = candidateData.isNotEmpty;

                      return Draggable<dynamic>(
                        data: item,
                        feedback: Material(
                          color: Colors.transparent,
                          child: _buildElementBox(item, isDragging: true),
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.3,
                          child: _buildElementBox(item),
                        ),
                        child: _buildElementBox(
                          item,
                          isHighlighted: isHovered,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildElementBox(dynamic item, {bool isDragging = false, bool isHighlighted = false}) {
    return Container(
      width: isDragging ? 90 : null,
      height: isDragging ? 90 : null,
      decoration: BoxDecoration(
        color: isHighlighted
            ? Colors.cyanAccent.withOpacity(0.4)
            : (isDragging ? Colors.cyanAccent.withOpacity(0.8) : Colors.white.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlighted || isDragging ? Colors.cyanAccent : Colors.white24,
          width: isHighlighted || isDragging ? 2 : 1,
        ),
        boxShadow: isDragging
            ? [
                BoxShadow(
                  color: Colors.cyanAccent.withOpacity(0.5),
                  blurRadius: 15,
                  spreadRadius: 2,
                )
              ]
            : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item['symbol'] ?? '?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDragging ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item['name'] ?? '',
            style: TextStyle(
              fontSize: 11,
              color: isDragging ? Colors.black87 : Colors.white70,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
