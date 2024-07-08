import 'package:sqflite/sqflite.dart';

import '../../../modules/cars/domain/user.dart';
import 'user_database_service.dart';

class UserDB {
  final tableName = 'user';

  Future<void> createTable(Database database) async {
    await database.execute(
      """CREATE TABLE IF NOT EXISTS $tableName (
  "userId" INTEGER NOT NULL,
  "name" TEXT NOT NULL,
  "email" TEXT NOT NULL,
   PRIMARY KEY("userId" AUTOINCREMENT)
    );""",
    );
  }

  Future<int> createUser({
    required String name,
    required String email,
  }) async {
    final database = await UserDatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (name, email) VALUES (?,?)''',
      [name, email],
    );
  }

  Future<User> getUser() async {
    final database = await UserDatabaseService().database;
    final user = await database.rawQuery(
      '''SELECT * from $tableName''',
    );
    return user.map((user) => User.fromDatabase(user)).toList().first;
  }

  Future<void> clearTable() async {
    final database = await UserDatabaseService().database;
    await database.execute('DELETE FROM $tableName');
  }

  Future<bool> hasUser() async {
    final database = await UserDatabaseService().database;
    final userList = await database.rawQuery('''SELECT * from $tableName''');
    return userList.isNotEmpty;
  }
}
