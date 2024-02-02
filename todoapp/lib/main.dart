import 'package:flutter/material.dart';
import 'package:todoapp/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDoApp',
      theme: ThemeData(
          primarySwatch: const MaterialColor(0xFF2196F3, {
        50: Color(0xFFE3F2FD), // Lightest shade
        100: Color(0xFFBBDEFB),
        200: Color(0xFF90CAF9),
        300: Color(0xFF64B5F6),
        400: Color(0xFF42A5F5),
        500: Color(0xFF2196F3), // Primary shade
        600: Color(0xFF1E88E5),
        700: Color(0xFF1976D2),
        800: Color(0xFF1565C0),
        900: Color(0xFF0D47A1),
      })),
      debugShowCheckedModeBanner: false,
      home:  MyHomePage(),
    );
  }
}
