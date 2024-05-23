import 'package:my_car_expenses/data/data_sources/database/car/car_data_source.dart';
import 'package:my_car_expenses/data/models/car/car_model.dart';
import 'package:my_car_expenses/domain/repositories/car_repository.dart';

class CarRepositoryImpl implements CarRepository {
  final CarDataSource dataSource;

  CarRepositoryImpl({required this.dataSource});

  @override
  Future<int> add(CarModel carModel) => dataSource.create(carModel: carModel);

  @override
  Future<List<CarModel>> getAll() => dataSource.fetchAll();

  @override
  Future<CarModel?> getById(int id) => dataSource.fetchById(id);

  @override
  Future<int> updateCurrentMillage(int id, int mileage) => dataSource.update(id: id, currentMileage: mileage);
}