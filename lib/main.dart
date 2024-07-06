import 'package:car_expo/modules/cars/data/cars_repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final carsRepository = CarsRepository();

    getCars() async {
      final cars = await carsRepository.getAllCars();

      print(cars);
    }

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () => getCars(),
            child: const Text('KATIAU'),
          ),
        ),
      ),
    );
  }
}
