part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.data({required User user}) = _Data;
  const factory UserState.error({required String message}) = _Error;
}
