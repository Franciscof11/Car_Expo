import 'package:dio/dio.dart';

import '../domain/car.dart';

class CarsRepository {
  Future<List<Car>> getAllCars() async {
    final dio = Dio();

    final response = await dio.get('https://wswork.com.br/cars.json');

    final responseMap = response.data['cars'];

    final carsList = responseMap.map<Car>((car) => Car.fromMap(car)).toList();

    return carsList;
  }
}
