import 'package:my_car_expenses/domain/repositories/vehicle_info_repository.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_fuel_types_use_case.dart';

class GetFuelTypesUseCaseImpl implements GetFuelTypesUseCase {
  final VehicleInfoRepository repository;

  GetFuelTypesUseCaseImpl({
    required this.repository,
  });

  @override
  List<String> invoke() {
    var list = repository.getFuelTypes();
    var resultList = list.asMap().map((key, value) => MapEntry(key, value.name)).values.toList();
    return resultList;
  }
}