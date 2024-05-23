import 'package:my_car_expenses/domain/converters/car_converter.dart';
import 'package:my_car_expenses/domain/entities/car.dart';
import 'package:my_car_expenses/domain/repositories/car_repository.dart';
import 'package:my_car_expenses/domain/use_cases/car/get/get_all_car_use_case.dart';

class GetAllCarUseCaseImpl implements GetAllCarUseCase {
  final CarRepository repository;
  final CarConverter converter;

  GetAllCarUseCaseImpl({
    required this.repository,
    required this.converter
  });

  @override
  Future<List<Car>> invoke() async {
    var list = await repository.getAll();
    var resultList = list.map((item) => converter.toCar(item)).toList();
    return resultList;
  }
}