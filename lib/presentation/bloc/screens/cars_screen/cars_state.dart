import 'package:my_car_expenses/domain/entities/car.dart';

abstract class CarsState {}

class CarsLoadingState extends CarsState {}

class CarsLoadedState extends CarsState {
  final List<Car> cars;

  CarsLoadedState({
    required this.cars
  });
}

class CarsEmptyState extends CarsState {}