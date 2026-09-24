import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'lab_experiment_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<dynamic>> _loadElements() async {
    try {
      final String response = await rootBundle.loadString('assets/data/reactions.json');
      final data = await json.decode(response);
      if (data != null && data['elements'] != null) {
        return List<dynamic>.from(data['elements']);
      }
    } catch (e) {
      debugPrint('Error loading JSON: $e');
    }

    // ڈیفالٹ ایلیمنٹس اگر JSON لوڈ نہ ہو سکے
    return [
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.cyanAccent.withOpacity(0.1),
                      border: Border.all(color: Colors.cyanAccent, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.science_rounded,
                      size: 80,
                      color: Colors.cyanAccent,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'JM ALCHEMY LAB',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Explore Elements & Chemical Reactions',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () async {
                      final elements = await _loadElements();
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LabExperimentScreen(elements: elements),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                      shadowColor: Colors.cyanAccent.withOpacity(0.5),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Start Experiment',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
