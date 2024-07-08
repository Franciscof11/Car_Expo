import 'package:bloc_test/bloc_test.dart';
import 'package:car_expo/modules/cars/data/cars_repository.dart';
import 'package:car_expo/modules/cars/domain/car.dart';
import 'package:car_expo/modules/cars/presentation/home_page/cubit/cars_list_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCarRepository extends Mock implements CarsRepository {}

void main() {
  late MockCarRepository repository;

  late CarsListCubit cubit;

  late List<Car> cars;

  setUp(
    () {
      repository = MockCarRepository();
      cubit = CarsListCubit(repository: repository);
      cars = [
        Car.empty(),
        Car.empty(),
      ];
    },
  );

  blocTest<CarsListCubit, CarsListState>(
    'Test the get list of cars function from bloc and repository instance.',
    setUp: () {
      when(() => repository.getAllCars()).thenAnswer(
        (invocation) async => cars,
      );
    },
    build: () => cubit,
    act: (bloc) => cubit.getAllCars(),
    expect: () => [
      const CarsListState.loading(),
      CarsListState.data(cars: cars),
    ],
  );
}
