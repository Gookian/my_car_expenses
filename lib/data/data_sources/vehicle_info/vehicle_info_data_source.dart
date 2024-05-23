import 'package:my_car_expenses/data/models/car/automobile_model.dart';
import 'package:my_car_expenses/data/models/car/car_make_model.dart';
import 'package:my_car_expenses/data/models/car/fuel_type_model.dart';

abstract interface class VehicleInfoDataSource {
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

class VehicleInfoDataSourceImpl implements VehicleInfoDataSource {
  List<FuelTypeModel> fuelTypes = [
    FuelTypeModel(id: 1, name: "Бензин"),
    FuelTypeModel(id: 2, name: "Электричество")
  ];

  List<AutomobileModel> carModels = [
    AutomobileModel(id: 1, name: "Lada"),
    AutomobileModel(id: 2, name: "Mitsubishi")
  ];

  List<CarMakeModel> catMakes = [
    CarMakeModel(id: 1, carModelId: 1, name: "Granta"),
    CarMakeModel(id: 2, carModelId: 1, name: "Vesta"),
    CarMakeModel(id: 3, carModelId: 2, name: "Lancer")
  ];

  @override
  List<FuelTypeModel> getFuelTypes() => fuelTypes;

  @override
  List<CarMakeModel> getMakes() => catMakes;

  @override
  List<AutomobileModel> getModels() => carModels;

  @override
  int getModelIdByName(String value) => carModels.firstWhere((carModel) => carModel.name == value).id;

  @override
  int getMakeIdByName(String value) => catMakes.firstWhere((catMake) => catMake.name == value).id;

  @override
  int getFuelTypeIdByName(String value) => fuelTypes.firstWhere((fuelType) => fuelType.name == value).id;

  @override
  String getModelNameById(int id) => carModels.firstWhere((carModel) => carModel.id == id).name;

  @override
  String getMakeNameById(int id) => catMakes.firstWhere((catMake) => catMake.id == id).name;

  @override
  String getFuelTypeNameById(int id) => fuelTypes.firstWhere((fuelType) => fuelType.id == id).name;
}