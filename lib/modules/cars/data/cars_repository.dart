import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../domain/car.dart';

class CarsRepository {
  Future<List<Car>> getAllCars() async {
    try {
      final dio = Dio();

      final response = await dio.get('https://wswork.com.br/cars.json');

      final responseMap = response.data['cars'];

      final carsList = responseMap.map<Car>((car) => Car.fromMap(car)).toList();

      return carsList;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        debugPrint('Server Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint('Connection Timeout Error');
      }

      rethrow;
    } catch (e) {
      debugPrint('Unexpected Error: $e');

      return [];
    }
  }
}
