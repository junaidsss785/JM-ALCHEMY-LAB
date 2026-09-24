import 'package:flutter/material.dart';

class LabExperimentScreen extends StatefulWidget {
  const LabExperimentScreen({super.key});

  @override
  State<LabExperimentScreen> createState() => _LabExperimentScreenState();
}

class _LabExperimentScreenState extends State<LabExperimentScreen> {
  String statusMessage = 'Drag an element onto another element.';
  String reactionResult = '';

  final List<Map<String, dynamic>> allElements = const [
    {'name': 'Hydrogen', 'symbol': 'H', 'number': 1},
    {'name': 'Helium', 'symbol': 'He', 'number': 2},
    {'name': 'Lithium', 'symbol': 'Li', 'number': 3},
    {'name': 'Beryllium', 'symbol': 'Be', 'number': 4},
    {'name': 'Boron', 'symbol': 'B', 'number': 5},
    {'name': 'Carbon', 'symbol': 'C', 'number': 6},
    {'name': 'Nitrogen', 'symbol': 'N', 'number': 7},
    {'name': 'Oxygen', 'symbol': 'O', 'number': 8},
    {'name': 'Fluorine', 'symbol': 'F', 'number': 9},
    {'name': 'Neon', 'symbol': 'Ne', 'number': 10},
    {'name': 'Sodium', 'symbol': 'Na', 'number': 11},
    {'name': 'Magnesium', 'symbol': 'Mg', 'number': 12},
    {'name': 'Aluminum', 'symbol': 'Al', 'number': 13},
    {'name': 'Silicon', 'symbol': 'Si', 'number': 14},
    {'name': 'Phosphorus', 'symbol': 'P', 'number': 15},
    {'name': 'Sulfur', 'symbol': 'S', 'number': 16},
    {'name': 'Chlorine', 'symbol': 'Cl', 'number': 17},
    {'name': 'Argon', 'symbol': 'Ar', 'number': 18},
    {'name': 'Potassium', 'symbol': 'K', 'number': 19},
    {'name': 'Calcium', 'symbol': 'Ca', 'number': 20},
    {'name': 'Iron', 'symbol': 'Fe', 'number': 26},
    {'name': 'Copper', 'symbol': 'Cu', 'number': 29},
    {'name': 'Zinc', 'symbol': 'Zn', 'number': 30},
    {'name': 'Gold', 'symbol': 'Au', 'number': 79},
  ];

  final Map<String, String> specificReactions = const {
    'H+O': 'Water (H₂O)',
    'H+Cl': 'Hydrochloric Acid (HCl)',
    'H+F': 'Hydrogen Fluoride (HF)',
    'Na+Cl': 'Sodium Chloride / Salt (NaCl)',
    'K+Cl': 'Potassium Chloride (KCl)',
    'C+O': 'Carbon Dioxide (CO₂)',
    'S+O': 'Sulfur Dioxide (SO₂)',
    'N+O': 'Nitric Oxide (NO)',
    'Mg+O': 'Magnesium Oxide (MgO)',
    'Ca+O': 'Calcium Oxide (CaO)',
    'Fe+O': 'Iron Oxide / Rust (Fe₂O₃)',
    'Cu+O': 'Copper Oxide (CuO)',
    'Zn+O': 'Zinc Oxide (ZnO)',
    'Al+O': 'Aluminum Oxide (Al₂O₃)',
  };

  void _handleReaction(Map<String, dynamic> dragged, Map<String, dynamic> target) {
    if (dragged['symbol'] == target['symbol']) return;

    String s1 = dragged['symbol'];
    String s2 = target['symbol'];
    String key1 = "$s1+$s2";
    String key2 = "$s2+$s1";

    setState(() {
      if (specificReactions.containsKey(key1)) {
        statusMessage = 'Reaction Successful!';
        reactionResult = '${dragged['name']} + ${target['name']}\n➜ ${specificReactions[key1]}';
      } else if (specificReactions.containsKey(key2)) {
        statusMessage = 'Reaction Successful!';
        reactionResult = '${dragged['name']} + ${target['name']}\n➜ ${specificReactions[key2]}';
      } else {
        String product = _generateDynamicReaction(dragged, target);
        statusMessage = 'Reaction Formed!';
        reactionResult = '${dragged['name']} + ${target['name']}\n➜ $product';
      }
    });
  }

  String _generateDynamicReaction(Map<String, dynamic> e1, Map<String, dynamic> e2) {
    String sym1 = e1['symbol'];
    String sym2 = e2['symbol'];

    if (['He', 'Ne', 'Ar'].contains(sym1) || ['He', 'Ne', 'Ar'].contains(sym2)) {
      return 'Inert Mixture (No Bond Formed)';
    }

    return '$sym1$sym2 Binary Compound (${e1['name']} ${e2['name']} Complex)';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alchemy Lab Bench (${allElements.length} Elements)'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
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

                  return DragTarget<Map<String, dynamic>>(
                    onAcceptWithDetails: (details) {
                      _handleReaction(details.data, item);
                    },
                    builder: (context, candidateData, rejectedData) {
                      final isHovered = candidateData.isNotEmpty;

                      return Draggable<Map<String, dynamic>>(
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

  Widget _buildElementBox(Map<String, dynamic> item,
      {bool isDragging = false, bool isHighlighted = false}) {
    return Container(
      width: isDragging ? 90 : null,
      height: isDragging ? 90 : null,
      decoration: BoxDecoration(
        color: isHighlighted
            ? Colors.cyanAccent.withOpacity(0.4)
            : (isDragging
                ? Colors.cyanAccent.withOpacity(0.8)
                : Colors.white.withOpacity(0.05)),
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
