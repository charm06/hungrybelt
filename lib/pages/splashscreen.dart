import 'package:flutter/material.dart';
import 'package:hungrybelt/firebase_auth/auth_gate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0x00eeeded),
    body: Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splashscreen_logo.png',
                width: 150, 
                height: 150, 
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}