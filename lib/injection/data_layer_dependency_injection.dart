import 'package:get_it/get_it.dart';
import 'package:my_car_expenses/data/data_sources/categories/categories_data_source.dart';
import 'package:my_car_expenses/data/data_sources/database/car/car_data_source.dart';
import 'package:my_car_expenses/data/data_sources/database/database_service.dart';
import 'package:my_car_expenses/data/data_sources/database/documents/document_data_source.dart';
import 'package:my_car_expenses/data/data_sources/database/expenses/expense_data_source.dart';
import 'package:my_car_expenses/data/data_sources/database/notification/notification_data_source.dart';
import 'package:my_car_expenses/data/data_sources/structure/structure_data_source.dart';
import 'package:my_car_expenses/data/data_sources/vehicle_info/vehicle_info_data_source.dart';
import 'package:my_car_expenses/data/repositories/car_repository_impl.dart';
import 'package:my_car_expenses/data/repositories/category_repository_impl.dart';
import 'package:my_car_expenses/data/repositories/documents_repository_impl.dart';
import 'package:my_car_expenses/data/repositories/expense_repository_impl.dart';
import 'package:my_car_expenses/data/repositories/notification_repository_impl.dart';
import 'package:my_car_expenses/data/repositories/structure_repository_impl.dart';
import 'package:my_car_expenses/data/repositories/vehicle_info_repository_impl.dart';
import 'package:my_car_expenses/domain/repositories/car_repository.dart';
import 'package:my_car_expenses/domain/repositories/category_repository.dart';
import 'package:my_car_expenses/domain/repositories/documents_repository.dart';
import 'package:my_car_expenses/domain/repositories/expense_repository.dart';
import 'package:my_car_expenses/domain/repositories/notification_repository.dart';
import 'package:my_car_expenses/domain/repositories/structure_repository.dart';
import 'package:my_car_expenses/domain/repositories/vehicle_info_repository.dart';

class DataLayerDependencyInjection {
  final getIt = GetIt.instance;

  void injection() {
    getIt.registerSingleton<CategoriesDataSource>(CategoriesDataSourceImpl());
    getIt.registerSingleton<CategoryRepository>(CategoryRepositoryImpl(dataSource: getIt<CategoriesDataSource>()));

    getIt.registerSingleton<DatabaseService>(DatabaseService());
    getIt.registerSingleton<CarDataSource>(CarDataSourceImpl(service: getIt<DatabaseService>()));
    getIt.registerSingleton<ExpenseDataSource>(ExpenseDataSourceImpl(service: getIt<DatabaseService>()));
    getIt.registerSingleton<DocumentDataSource>(DocumentDataSourceImpl(service: getIt<DatabaseService>()));
    getIt.registerSingleton<NotificationDataSource>(NotificationDataSourceImpl(service: getIt<DatabaseService>()));

    getIt.registerSingleton<CarRepository>(CarRepositoryImpl(dataSource: getIt<CarDataSource>()));
    getIt.registerSingleton<ExpenseRepository>(ExpenseRepositoryImpl(dataSource: getIt<ExpenseDataSource>()));
    getIt.registerSingleton<DocumentRepository>(DocumentRepositoryImpl(dataSource: getIt<DocumentDataSource>()));
    getIt.registerSingleton<NotificationRepository>(NotificationRepositoryImpl(dataSource: getIt<NotificationDataSource>()));

    getIt.registerSingleton<VehicleInfoDataSource>(VehicleInfoDataSourceImpl());
    getIt.registerSingleton<VehicleInfoRepository>(VehicleInfoRepositoryImpl(dataSource: getIt<VehicleInfoDataSource>()));

    getIt.registerSingleton<StructureDataSource>(StructureDataSourceImpl());
    getIt.registerSingleton<StructureRepository>(StructureRepositoryImpl(dataSource: getIt<StructureDataSource>()));
  }
}