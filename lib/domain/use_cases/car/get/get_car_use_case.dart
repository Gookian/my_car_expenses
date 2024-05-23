import 'package:my_car_expenses/domain/entities/car.dart';

abstract interface class GetCarUseCase {
  Future<Car> invoke(int id);
}