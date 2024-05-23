import 'package:my_car_expenses/data/data_sources/vehicle_info/vehicle_info_data_source.dart';
import 'package:my_car_expenses/data/models/car/automobile_model.dart';
import 'package:my_car_expenses/data/models/car/car_make_model.dart';
import 'package:my_car_expenses/data/models/car/fuel_type_model.dart';
import 'package:my_car_expenses/domain/repositories/vehicle_info_repository.dart';

class VehicleInfoRepositoryImpl implements VehicleInfoRepository {
  final VehicleInfoDataSource dataSource;

  VehicleInfoRepositoryImpl({required this.dataSource});

  @override
  List<FuelTypeModel> getFuelTypes() => dataSource.getFuelTypes();

  @override
  List<AutomobileModel> getModels() => dataSource.getModels();

  @override
  List<CarMakeModel> getMakes() => dataSource.getMakes();

  @override
  int getModelIdByName(String value) => dataSource.getModelIdByName(value);

  @override
  int getMakeIdByName(String value) => dataSource.getMakeIdByName(value);

  @override
  int getFuelTypeIdByName(String value) => dataSource.getFuelTypeIdByName(value);

  @override
  String getModelNameById(int id) => dataSource.getModelNameById(id);

  @override
  String getMakeNameById(int id) => dataSource.getMakeNameById(id);

  @override
  String getFuelTypeNameById(int id) => dataSource.getFuelTypeNameById(id);
}