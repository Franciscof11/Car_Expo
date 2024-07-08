import 'package:bloc/bloc.dart';
import 'package:car_expo/config/database/user/user_db.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/user.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  final UserDB _db;

  UserCubit(this._db) : super(const UserState.initial());

  Future<void> getUser() async {
    try {
      emit(const UserState.loading());

      final user = await _db.getUser();

      emit(UserState.data(user: user));
    } catch (e) {
      emit(const UserState.error(message: 'Erro ao buscar usuário!'));
    }
  }
}
