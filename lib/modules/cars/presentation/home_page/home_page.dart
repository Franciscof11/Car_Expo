import 'package:car_expo/modules/cars/data/cars_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final carsRepository = CarsRepository();

    getCars() async {
      final cars = await carsRepository.getAllCars();

      print(cars);
    }

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => getCars(),
          child: const Text('KATIAU'),
        ),
      ),
    );
  }
}
