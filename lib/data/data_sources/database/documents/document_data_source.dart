import 'package:flutter/cupertino.dart';
import 'package:my_car_expenses/data/data_sources/database/database_service.dart';
import 'package:my_car_expenses/data/models/documents/document_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class DocumentDataSource {
  Future<int> create({required DocumentModel documentModel});
  Future<int> delete(int id);
  Future<List<DocumentModel>> fetchByCarId(int id);
  Future<DocumentModel?> fetchById(int id);
}

class DocumentDataSourceImpl implements DocumentDataSource {
  final tableName = "documents";
  DatabaseService service;

  DocumentDataSourceImpl({required this.service}) {
    service.onCreation + (args) => createTable(args!.database);
  }

  Future<void> createTable(Database database) async {
    debugPrint("create table $tableName start");
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        car_id INTEGER NOT NULL,
        type TEXT NOT NULL,
        series INTEGER NOT NULL,
        number INTEGER NOT NULL,
        date_of_issue TEXT NOT NULL,
        additional_fields TEXT NOT NULL,
        FOREIGN KEY (car_id) REFERENCES cars (id) ON DELETE NO ACTION ON UPDATE NO ACTION
      );""");
    debugPrint("create table $tableName success");
  }

  @override
  Future<int> create({required DocumentModel documentModel}) async {
    var database = await service.database;
    return await database.rawInsert(
        '''INSERT INTO $tableName (car_id, type, series, number, date_of_issue, additional_fields) VALUES (?,?,?,?,?,?)''',
        [
          documentModel.carId,
          documentModel.type,
          documentModel.series,
          documentModel.number,
          documentModel.dateOfIssue.toString(),
          documentModel.additionalFields
        ]
    );
  }

  @override
  Future<int> delete(int id) async {
    var database = await service.database;
    return await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }

  @override
  Future<List<DocumentModel>> fetchByCarId(int id) async {
    var database = await service.database;
    final documents = await database.rawQuery(
        '''SELECT * FROM $tableName WHERE car_id = ? ''',
        [id]
    );
    return documents.map((document) => DocumentModel.fromSqfliteDatabase(document)).toList();
  }

  @override
  Future<DocumentModel?> fetchById(int id) async {
    var database = await service.database;
    final document = await database.rawQuery(
        '''SELECT * FROM $tableName WHERE id = ?''',
        [id]
    );
    return DocumentModel.fromSqfliteDatabase(document.first);
  }
}