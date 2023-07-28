import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sunrule/presentation/home/home_screen.dart';
import 'package:sunrule/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
        builder: (context) =>const HomeScreen(),
      ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}
