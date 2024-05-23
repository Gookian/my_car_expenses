import 'package:flutter/cupertino.dart';
import 'package:my_car_expenses/data/data_sources/database/database_service.dart';
import 'package:my_car_expenses/data/models/expenses/expense_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class ExpenseDataSource {
  Future<int> create({required ExpenseModel expenseModel});
  Future<int> delete(int id);
  Future<List<ExpenseModel>> fetchByCategoryAndCarId(String category, int carId);
  Future<ExpenseModel?> fetchById(int id);
}

class ExpenseDataSourceImpl implements ExpenseDataSource {
  final tableName = "expenses";
  DatabaseService service;

  ExpenseDataSourceImpl({required this.service}) {
    service.onCreation + (args) => createTable(args!.database);
  }

  Future<void> createTable(Database database) async {
    debugPrint("create table $tableName start");
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        car_id INTEGER NOT NULL,
        category TEXT NOT NULL,
        name TEXT NOT NULL,
        date TEXT NOT NULL,
        sum_expense INTEGER NOT NULL,
        current_mileage INTEGER NOT NULL,
        additional_fields TEXT NOT NULL,
        FOREIGN KEY (car_id) REFERENCES cars (id) ON DELETE NO ACTION ON UPDATE NO ACTION
      );""");
    debugPrint("create table $tableName success");
  }

  @override
  Future<int> create({required ExpenseModel expenseModel}) async {
    var database = await service.database;
    return await database.rawInsert(
        '''INSERT INTO $tableName (car_id, category, name, date, sum_expense, current_mileage, additional_fields) VALUES (?,?,?,?,?,?,?)''',
        [
          expenseModel.carId,
          expenseModel.category,
          expenseModel.name,
          expenseModel.date.toString(),
          expenseModel.sumExpense,
          expenseModel.currentMileage,
          expenseModel.additionalFields
        ]
    );
  }

  @override
  Future<int> delete(int id) async {
    var database = await service.database;
    return await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }

  @override
  Future<List<ExpenseModel>> fetchByCategoryAndCarId(String category, int carId) async {
    var database = await service.database;
    final expenses = await database.rawQuery(
        '''SELECT * FROM $tableName WHERE category = ? AND car_id = ?''',
        [category, carId]
    );
    return expenses.map((expense) => ExpenseModel.fromSqfliteDatabase(expense)).toList();
  }

  @override
  Future<ExpenseModel?> fetchById(int id) async {
    var database = await service.database;
    final expense = await database.rawQuery(
        '''SELECT * FROM $tableName WHERE id = ?''',
        [id]
    );
    return ExpenseModel.fromSqfliteDatabase(expense.first);
  }
}