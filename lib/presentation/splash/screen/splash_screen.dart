import 'dart:async';
import 'package:flutter/material.dart';
import '../../onboard/screen/onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  nextScreen() async {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Lapisan 1: Background putih
          Container(
            color: Colors.white,
          ),

          // Lapisan 2: Background gambar
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // logo
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                width: double.infinity,
                child: Image.asset(
                  'assets/images/splash.png',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
