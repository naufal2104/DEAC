import 'package:flutter/material.dart';

import 'presentation/splash/screen/splash_screen.dart';
import 'util/ucolors.dart';
import 'util/ufont.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:  Color(0xFF88D8FF)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: UFont.poppins,
      ),
      home: const Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
