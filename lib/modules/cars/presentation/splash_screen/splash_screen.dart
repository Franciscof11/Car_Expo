import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:car_expo/config/database/leads/leads_db.dart';
import 'package:car_expo/config/database/user/user_db.dart';
import 'package:car_expo/modules/cars/data/cars_repository.dart';
import 'package:car_expo/modules/cars/data/leads_repository.dart';
import 'package:car_expo/modules/cars/presentation/auth_page/auth_page.dart';
import 'package:car_expo/modules/cars/presentation/home_page/cubit/cars_list_cubit.dart';
import 'package:car_expo/modules/cars/presentation/profile_page/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../../domain/lead.dart';
import '../home_page/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  deploymentRoutine() {
    final leadDb = LeadsDB();

    final leadsRepository = LeadsRepository();

    Timer.periodic(
      const Duration(minutes: 10),
      (timer) async {
        final List<Lead> leads = await leadDb.getAll();

        await leadsRepository.postLeads(leads);

        debugPrint('#Sucess deploy routine!');
        debugPrint(leads.toString());
        debugPrint('');
        debugPrint('#Cleaning leads table...');

        await leadDb.clearTable();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    deploymentRoutine();
  }

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
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider(create: (context) => CarsListCubit(repository: context.read<CarsRepository>())..getAllCars()),
                        BlocProvider(create: (context) => UserCubit(userDB)..getUser()),
                      ],
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

            return const SizedBox.shrink();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
