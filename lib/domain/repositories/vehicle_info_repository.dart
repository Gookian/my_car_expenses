import 'package:my_car_expenses/data/models/car/automobile_model.dart';
import 'package:my_car_expenses/data/models/car/car_make_model.dart';
import 'package:my_car_expenses/data/models/car/fuel_type_model.dart';

abstract interface class VehicleInfoRepository {
  List<FuelTypeModel> getFuelTypes();
  List<AutomobileModel> getModels();
  List<CarMakeModel> getMakes();
  int getModelIdByName(String value);
  int getMakeIdByName(String value);
  int getFuelTypeIdByName(String value);
  String getModelNameById(int id);
  String getMakeNameById(int id);
  String getFuelTypeNameById(int id);
}