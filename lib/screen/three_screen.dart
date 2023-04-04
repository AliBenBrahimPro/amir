import 'package:flutter/material.dart';

class ThreeScreen extends StatefulWidget {
  const ThreeScreen({super.key});

  @override
  State<ThreeScreen> createState() => _ThreeScreenState();
}

class _ThreeScreenState extends State<ThreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Three")),);
  }
}