import 'package:my_car_expenses/domain/entities/car.dart';

abstract interface class CreatingUseCase {
  void invoke(Map<String, dynamic> map);
}