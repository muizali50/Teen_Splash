import 'package:flutter/material.dart';

class ClothingScreen extends StatefulWidget {
  const ClothingScreen({super.key});

  @override
  State<ClothingScreen> createState() => _ClothingScreenState();
}

class _ClothingScreenState extends State<ClothingScreen> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: Center(
        child: Text('no data'),
      ),
    );
  }
}