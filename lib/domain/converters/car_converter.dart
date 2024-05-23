import 'package:my_car_expenses/data/models/car/car_model.dart';
import 'package:my_car_expenses/domain/entities/car.dart';
import 'package:my_car_expenses/domain/repositories/vehicle_info_repository.dart';

class CarConverter {
  final VehicleInfoRepository repository;

  CarConverter({
    required this.repository
  });

  CarModel toModel(Car car) {
    return CarModel(
        id: 0,
        modelId: repository.getModelIdByName(car.model),
        makeId: repository.getMakeIdByName(car.make),
        fuelTypeId: repository.getFuelTypeIdByName(car.fuelType),
        name: car.name,
        yearOfIssue: car.yearOfIssue,
        startMileage: car.startMileage,
        currentMileage: car.currentMileage
    );
  }

  Car toCar(CarModel model) {
    return Car(
        id: model.id,
        model: repository.getModelNameById(model.modelId),
        make: repository.getMakeNameById(model.makeId),
        fuelType: repository.getFuelTypeNameById(model.fuelTypeId),
        name: model.name,
        yearOfIssue: model.yearOfIssue,
        startMileage: model.startMileage,
        //currentMileage: model.currentMileage
    );
  }
}