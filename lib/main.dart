import 'package:car_expo/modules/cars/data/cars_repository.dart';
import 'package:car_expo/modules/cars/presentation/splash_screen/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CarsRepository(),
      child: MaterialApp(
        title: 'Car Expo',
        builder: DevicePreview.appBuilder,
        locale: DevicePreview.locale(context),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
