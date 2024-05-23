import 'package:my_car_expenses/domain/repositories/vehicle_info_repository.dart';

abstract interface class GetModelIdByNameUseCase {
  int invoke(String value);
}

class GetModelIdByNameUseCaseImpl implements GetModelIdByNameUseCase {
  final VehicleInfoRepository repository;

  GetModelIdByNameUseCaseImpl({
    required this.repository
  });

  @override
  int invoke(String value) => repository.getModelIdByName(value);
}