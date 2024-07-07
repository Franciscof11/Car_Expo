import 'package:car_expo/config/database/leads/database_service.dart';
import 'package:sqflite/sqflite.dart';

import '../../../modules/cars/domain/lead.dart';

class LeadsDB {
  final tableName = 'leads';

  Future<void> createTable(Database database) async {
    await database.execute(
      """CREATE TABLE IF NOT EXISTS $tableName (
  "leadId" INTEGER NOT NULL,
  "carId" INTEGER NOT NULL,
  "carName" TEXT NOT NULL,
  "userName" TEXT NOT NULL,
  "userEmail" TEXT NOT NULL,
   PRIMARY KEY("leadId" AUTOINCREMENT)
    );""",
    );
  }

  Future<int> create({
    required int carId,
    required String carName,
    required String userName,
    required String userEmail,
  }) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (carId, carName, userName, userEmail) VALUES (?,?,?,?)''',
      [carId, carName, userName, userEmail],
    );
  }

  Future<List<Lead>> getAll() async {
    final database = await DatabaseService().database;
    final leads = await database.rawQuery(
      '''SELECT * from $tableName''',
    );
    return leads.map((lead) => Lead.fromDatabase(lead)).toList();
  }
}
