import 'package:car_expo/modules/cars/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Car Expo',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
