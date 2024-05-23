import 'package:my_car_expenses/data/models/car/car_make_model.dart';
import 'package:my_car_expenses/domain/repositories/vehicle_info_repository.dart';

abstract interface class GetMakesUseCase {
  List<CarMakeModel> invoke();
}

class GetMakesUseCaseImpl implements GetMakesUseCase {
  final VehicleInfoRepository repository;

  GetMakesUseCaseImpl({
    required this.repository
  });

  @override
  List<CarMakeModel> invoke() => repository.getMakes();
}