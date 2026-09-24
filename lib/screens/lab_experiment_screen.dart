import 'package:flutter/material.dart';

class LabExperimentScreen extends StatefulWidget {
  final List<dynamic> elements;

  const LabExperimentScreen({super.key, required this.elements});

  @override
  State<LabExperimentScreen> createState() => _LabExperimentScreenState();
}

class _LabExperimentScreenState extends State<LabExperimentScreen> {
  dynamic selectedElement1;
  dynamic selectedElement2;
  String result = 'Select two elements to mix';

  void _mixElements() {
    if (selectedElement1 != null && selectedElement2 != null) {
      setState(() {
        result = 'Combined: ${selectedElement1['name']} + ${selectedElement2['name']}';
      });
    }
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
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.cyanAccent),
              ),
              child: Center(
                child: Text(
                  result,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.cyanAccent, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _mixElements,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
              ),
              child: const Text('Mix Elements'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: widget.elements.length,
                itemBuilder: (context, index) {
                  final item = widget.elements[index];
                  final isSelected = selectedElement1 == item || selectedElement2 == item;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedElement1 == null) {
                          selectedElement1 = item;
                        } else if (selectedElement2 == null) {
                          selectedElement2 = item;
                        } else {
                          selectedElement1 = item;
                          selectedElement2 = null;
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.cyanAccent.withOpacity(0.3) : Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.cyanAccent : Colors.white24,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['symbol'] ?? '?',
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['name'] ?? '',
                            style: const TextStyle(fontSize: 11, color: Colors.white70),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
