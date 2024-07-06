part of 'cars_list_cubit.dart';

@freezed
class CarsListState with _$CarsListState {
  const factory CarsListState.initial() = _Initial;
  const factory CarsListState.loading() = _Loading;
  const factory CarsListState.data({required List<Car> cars}) = _Data;
  const factory CarsListState.error({required String message}) = _Error;
}
