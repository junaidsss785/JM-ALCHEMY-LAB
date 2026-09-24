import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const JMAlchemyApp());
}

class JMAlchemyApp extends StatelessWidget {
  const JMAlchemyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JM Alchemy Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F2027),
        primaryColor: Colors.cyanAccent,
      ),
      home: const HomeScreen(),
    );
  }
}
