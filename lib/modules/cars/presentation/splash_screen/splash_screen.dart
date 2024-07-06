import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:car_expo/modules/cars/presentation/auth_page/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/splash_screen.json'),
      pageTransitionType: PageTransitionType.fade,
      splashTransition: SplashTransition.fadeTransition,
      duration: 4100,
      backgroundColor: const Color.fromRGBO(228, 240, 246, 1),
      splashIconSize: 80000,
      nextScreen: const AuthPage(),
    );
  }
}
