import 'package:my_car_expenses/data/models/car/car_model.dart';

abstract interface class CarRepository {
  Future<int> add(CarModel carModel);
  Future<List<CarModel>> getAll();
  Future<CarModel?> getById(int id);
  Future<int> updateCurrentMillage(int id, int mileage);
}