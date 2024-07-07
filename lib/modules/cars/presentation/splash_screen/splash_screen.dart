import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:car_expo/config/database/user/user_db.dart';
import 'package:car_expo/modules/cars/data/cars_repository.dart';
import 'package:car_expo/modules/cars/presentation/auth_page/auth_page.dart';
import 'package:car_expo/modules/cars/presentation/home_page/cubit/cars_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';

import '../home_page/home_page.dart';

class SplashScreen extends StatefulWidget {
  final Database userDB;
  const SplashScreen({super.key, required this.userDB});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final userDB = UserDB();

    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/splash_screen.json'),
      pageTransitionType: PageTransitionType.fade,
      splashTransition: SplashTransition.fadeTransition,
      duration: 4100,
      backgroundColor: const Color.fromRGBO(228, 240, 246, 1),
      splashIconSize: 80000,
      nextScreen: FutureBuilder<bool>(
        future: userDB.hasUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao fazer login: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            bool userExists = snapshot.data!;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (userExists) {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: BlocProvider(
                      create: (context) => CarsListCubit(repository: context.read<CarsRepository>())..getAllCars(),
                      child: const HomePage(),
                    ),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                );
              }
            });

            return Container();
          } else {
            return const Center(child: Text('No data found.'));
          }
        },
      ),
    );
  }
}
