import 'package:event/event.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Database? _database;

  Event<CreatingDatabaseEventArgs> onCreation = Event<CreatingDatabaseEventArgs>();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = "my_car_expenses.db";
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true
    );
    return database;
  }

  Future<void> create(Database database, int version) async {
    onCreation.broadcast(CreatingDatabaseEventArgs(database));
  }
}

class CreatingDatabaseEventArgs extends EventArgs {
  Database database;
  CreatingDatabaseEventArgs(this.database);
}