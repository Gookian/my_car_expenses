import 'package:my_car_expenses/data/models/car/automobile_model.dart';
import 'package:my_car_expenses/domain/repositories/vehicle_info_repository.dart';

abstract interface class GetModelsUseCase {
  List<AutomobileModel> invoke();
}

class GetModelsUseCaseImpl implements GetModelsUseCase {
  final VehicleInfoRepository repository;

  GetModelsUseCaseImpl({
    required this.repository
  });

  @override
  List<AutomobileModel> invoke() => repository.getModels();
}