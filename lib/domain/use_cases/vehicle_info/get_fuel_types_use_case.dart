import 'package:my_car_expenses/domain/entities/car.dart';

abstract interface class GetFuelTypesUseCase {
  List<String> invoke();
}