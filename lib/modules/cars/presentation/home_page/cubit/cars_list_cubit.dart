import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:car_expo/modules/cars/data/cars_repository.dart';
import 'package:car_expo/modules/cars/domain/car.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cars_list_state.dart';
part 'cars_list_cubit.freezed.dart';

class CarsListCubit extends Cubit<CarsListState> {
  final CarsRepository _repository;

  CarsListCubit({required CarsRepository repository})
      : _repository = repository,
        super(const CarsListState.initial());

  Future<void> getAllCars() async {
    try {
      emit(const CarsListState.loading());

      final cars = await _repository.getAllCars();

      emit(CarsListState.data(cars: cars));
    } catch (e) {
      log(
        'Erro ao buscar carros disponíveis!',
        error: e,
      );
      emit(const CarsListState.error(message: 'Erro ao buscar carros disponíveis!'));
    }
  }

  Future<void> searchCar(String carName) async {
    try {
      final cars = await _repository.getAllCars();

      final filteredCars = cars.where((car) => car.nomeModelo.toLowerCase().contains(carName.toLowerCase())).toList();

      emit(CarsListState.data(cars: filteredCars));
    } catch (e) {
      log(
        'Erro ao buscar carros disponíveis!',
        error: e,
      );
      emit(const CarsListState.error(message: 'Erro ao buscar carros disponíveis!'));
    }
  }

  Future<void> filterByBrand(String brandIdd) async {
    try {
      emit(const CarsListState.loading());

      final cars = await _repository.getAllCars();

      String brandId = brandIdd;

      List<Car> filteredCars = cars;

      switch (brandId) {
        case "0":
          print('aha');

        case "1":
          filteredCars = cars.where((car) {
            if (car.id.toString() == "1") return true;
            return false;
          }).toList();

        case "2":
          filteredCars = cars.where((car) {
            if (car.id.toString() == "2") return true;
            return false;
          }).toList();

        case "3":
          filteredCars = cars.where((car) {
            if (car.id.toString() == "3") return true;
            return false;
          }).toList();
      }

      emit(CarsListState.data(cars: filteredCars));
    } catch (e) {}
  }
}
