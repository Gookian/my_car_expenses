import 'package:flutter/cupertino.dart';
import 'package:my_car_expenses/data/data_sources/database/database_service.dart';
import 'package:my_car_expenses/data/models/notification/notification_model.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class NotificationDataSource {
  Future<int> create({required NotificationModel notificationModel});
  Future<int> delete(int id);
  Future<List<NotificationModel>> fetchAll();
  Future<NotificationModel?> fetchById(int id);
}

class NotificationDataSourceImpl implements NotificationDataSource {
  final tableName = "notification";
  DatabaseService service;

  NotificationDataSourceImpl({required this.service}) {
    service.onCreation + (args) => createTable(args!.database);
  }

  Future<void> createTable(Database database) async {
    debugPrint("create table $tableName start");
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        document_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        date TEXT NOT NULL,
        FOREIGN KEY (document_id) REFERENCES documents (id) ON DELETE NO ACTION ON UPDATE NO ACTION
      );""");
    debugPrint("create table $tableName success");
  }

  @override
  Future<int> create({required NotificationModel notificationModel}) async {
    var database = await service.database;
    return await database.rawInsert(
        '''INSERT INTO $tableName (document_id, title, description, date) VALUES (?,?,?,?)''',
        [
          notificationModel.documentId,
          notificationModel.title,
          notificationModel.description,
          notificationModel.date.toString()
        ]
    );
  }

  @override
  Future<int> delete(int id) async {
    var database = await service.database;
    return await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }

  @override
  Future<List<NotificationModel>> fetchAll() async {
    var database = await service.database;
    final notifications = await database.rawQuery(
        '''SELECT * FROM $tableName''' // ORDER BY COALESCE()
    );
    return notifications.map((notification) => NotificationModel.fromSqfliteDatabase(notification)).toList();
  }

  @override
  Future<NotificationModel?> fetchById(int id) async {
    var database = await service.database;
    final notification = await database.rawQuery(
        '''SELECT * FROM $tableName WHERE id = ?''',
        [id]
    );
    return NotificationModel.fromSqfliteDatabase(notification.first);
  }
}