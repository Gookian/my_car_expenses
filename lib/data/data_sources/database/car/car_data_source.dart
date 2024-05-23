import 'package:flutter/cupertino.dart';
import 'package:my_car_expenses/data/data_sources/database/database_service.dart';
import 'package:my_car_expenses/data/models/car/car_model.dart';
import 'package:my_car_expenses/data/models/car/car_update_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class CarDataSource {
  Future<int> create({required CarModel carModel});
  Future<int> update({
    required int id,
    CarUpdateModel? carUpdateModel,
    int? currentMileage,
    int? fuelConsumption,
    int? averageMonthlyMileage
  });
  Future<int> delete(int id);
  Future<List<CarModel>> fetchAll();
  Future<CarModel?> fetchById(int id);
}

class CarDataSourceImpl implements CarDataSource {
  final tableName = "cars";
  DatabaseService service;

  CarDataSourceImpl({required this.service}) {
    service.onCreation + (args) => createTable(args!.database);
  }

  Future<void> createTable(Database database) async {
    debugPrint("create table $tableName start");
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        model_id INTEGER NOT NULL,
        make_id INTEGER NOT NULL,
        fuel_type_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        year_of_issue INTEGER NOT NULL,
        start_mileage INTEGER NOT NULL,
        current_mileage INTEGER NOT NULL,
        fuel_consumption INTEGER,
        average_monthly_mileage INTEGER
      );""");
    debugPrint("create table $tableName success");
  }

  @override
  Future<int> create({required CarModel carModel}) async {
    var database = await service.database;
    return await database.rawInsert(
        '''INSERT INTO $tableName (model_id, make_id, fuel_type_id, name, year_of_issue, start_mileage, current_mileage) VALUES (?,?,?,?,?,?,?)''',
        [
          carModel.modelId,
          carModel.makeId,
          carModel.fuelTypeId,
          carModel.name,
          carModel.yearOfIssue,
          carModel.startMileage,
          carModel.currentMileage
        ]
    );
  }

  @override
  Future<int> update({
    required int id,
    CarUpdateModel? carUpdateModel,
    int? currentMileage,
    int? fuelConsumption,
    int? averageMonthlyMileage
  }) async {
    var database = await service.database;
    return await database.update(
        tableName,
        {
          'id': id,
          if (carUpdateModel != null) 'make_id': carUpdateModel.modelId,
          if (carUpdateModel != null) 'make_id': carUpdateModel.makeId,
          if (carUpdateModel != null) 'fuel_type_id': carUpdateModel.fuelTypeId,
          if (carUpdateModel != null) 'name': carUpdateModel.name,
          if (carUpdateModel != null) 'year_of_issue': carUpdateModel.yearOfIssue,
          if (carUpdateModel != null) 'start_mileage': carUpdateModel.startMileage,
          if (currentMileage != null) 'current_mileage': currentMileage,
          if (fuelConsumption != null) 'fuel_consumption': fuelConsumption,
          if (averageMonthlyMileage != null) 'average_monthly_mileage': averageMonthlyMileage,
        },
        where: 'id = ?',
        conflictAlgorithm: ConflictAlgorithm.rollback,
        whereArgs: [id]
    );
  }

  @override
  Future<int> delete(int id) async {
    var database = await service.database;
    return await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }

  @override
  Future<List<CarModel>> fetchAll() async {
    var database = await service.database;
    final cars = await database.rawQuery(
        '''SELECT * FROM $tableName''' // ORDER BY COALESCE()
    );
    return cars.map((car) => CarModel.fromSqfliteDatabase(car)).toList();
  }

  @override
  Future<CarModel?> fetchById(int id) async {
    var database = await service.database;
    final car = await database.rawQuery(
        '''SELECT * FROM $tableName WHERE id = ?''',
        [id]
    );
    return CarModel.fromSqfliteDatabase(car.first);
  }
}