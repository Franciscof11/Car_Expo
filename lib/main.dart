import 'package:car_expo/modules/cars/data/cars_repository.dart';
import 'package:car_expo/modules/cars/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'config/database/user/user_database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userDB = await UserDatabaseService().database;

  runApp(MainApp(userDB: userDB));
}

class MainApp extends StatelessWidget {
  final userDB;
  const MainApp({super.key, this.userDB});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CarsRepository(),
      child: MaterialApp(
        title: 'Car Expo',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(userDB: userDB),
      ),
    );
  }
}
