import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startFadeIn();
  }

  void _startFadeIn() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      _checkUserStatus(); // Check user authentication status
    });
  }

  void _checkUserStatus() {
    User? user = FirebaseAuth.instance.currentUser; // Get the current user

    if (user != null) {
      // If the user is signed in, navigate to home page
      Get.offNamed('/home');
    } else {
      // If the user is not signed in, navigate to onboarding page
      Get.offNamed('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1),
          child: Image.asset(
            'assets/images/Logo 1.png',
            // Optionally specify height and width
            // height: 100,
            // width: 100,
          ),
        ),
      ),
    );
  }
}
