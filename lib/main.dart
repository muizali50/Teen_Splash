import 'package:flutter/material.dart';
import 'package:teen_splash/features/users/views/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teen Splash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF999999),
          primary: Color(0xFF272575),
          secondary: Color(0xFF00BFFF),
          tertiary: Color(0xFFFF69B4),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
