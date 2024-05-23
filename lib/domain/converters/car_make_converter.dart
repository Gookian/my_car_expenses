import 'package:my_car_expenses/data/models/car/car_make_model.dart';
import 'package:my_car_expenses/domain/entities/car_make.dart';

class CarMakeConverter {
  List<CarMake> toCarMakes(List<CarMakeModel> models) => models.map((e) => toCarMake(e)).toList();

  CarMake toCarMake(CarMakeModel model) => CarMake(
      carModelId: model.carModelId,
      name: model.name
  );
}