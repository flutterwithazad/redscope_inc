import 'dart:async';
import 'package:flutter/material.dart';
import 'package:redscope_inc/screens/bottom_navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..forward();

    Timer(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const BottomNavigationBarScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Center(
            child: Text(
              '🙌',
              style: TextStyle(fontSize: 50),
            ),
          ),
          const SizedBox(height: 20),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            strokeWidth: 4.0,
          ),
          const SizedBox(height: 10),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(seconds: 7),
            builder: (context, value, child) {
              int percentage = (value * 100).toInt();

              return Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              );
            },
          ),
          const Spacer(),
          const Text(
            'by Azad Ali',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
