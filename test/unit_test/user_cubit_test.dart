import 'package:bloc_test/bloc_test.dart';
import 'package:car_expo/config/database/user/user_db.dart';

import 'package:car_expo/modules/cars/domain/user.dart';
import 'package:car_expo/modules/cars/presentation/profile_page/cubit/user_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserDB extends Mock implements UserDB {}

void main() {
  late MockUserDB mockDb;

  late UserCubit cubit;

  late User user;

  setUp(
    () {
      mockDb = MockUserDB();
      cubit = UserCubit(mockDb);
      user = User.empty();
    },
  );

  blocTest<UserCubit, UserState>(
    'Test the get user function from database instance.',
    setUp: () {
      when(() => mockDb.getUser()).thenAnswer(
        (invocation) async => user,
      );
    },
    build: () => cubit,
    act: (bloc) => cubit.getUser(),
    expect: () => [
      const UserState.loading(),
      UserState.data(user: user),
    ],
  );
}
