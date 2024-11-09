import 'package:flutter/material.dart';
import 'package:redscope_inc/screens/bottom_navigation_bar.dart';
import 'package:redscope_inc/screens/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
