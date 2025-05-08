import 'package:flutter/material.dart';
import 'package:medmobileapp_ing/screens/home_screen.dart';
//import 'package:medmobileapp_ing/screens/loginscreen.dart';
//import 'package:medmobileapp_ing/screens/register.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: HomeScreen(),
        ),
      ),
    );
  }
}
