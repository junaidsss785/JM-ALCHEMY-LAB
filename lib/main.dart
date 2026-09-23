import 'package:flutter/material.dart';
import 'data/chemistry_database.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // JSON سے تمام کیمیکل ردِعمل اور ایلیمنٹس لوڈ کریں
  await JMAlchemyDatabase.loadDatabase();
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
