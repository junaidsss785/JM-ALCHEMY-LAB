import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const JMAlchemyLabApp());
}

class JMAlchemyLabApp extends StatelessWidget {
  const JMAlchemyLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JM Alchemy Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F141C),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
