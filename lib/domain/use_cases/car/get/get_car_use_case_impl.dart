import 'package:my_car_expenses/domain/converters/car_converter.dart';
import 'package:my_car_expenses/domain/entities/car.dart';
import 'package:my_car_expenses/domain/repositories/car_repository.dart';
import 'package:my_car_expenses/domain/use_cases/car/get/get_car_use_case.dart';
import 'package:my_car_expenses/until/exception/not_find_exception.dart';

class GetCarUseCaseImpl implements GetCarUseCase {
  final CarRepository repository;
  final CarConverter converter;

  GetCarUseCaseImpl({
    required this.repository,
    required this.converter
  });

  @override
  Future<Car> invoke(int id) async {
    var carModel = await repository.getById(id);
    if (carModel != null) {
      var convertedCar = converter.toCar(carModel);
      return convertedCar;
    } else {
      throw NotFindException("Не удалось найти машину");
    }
  }
}