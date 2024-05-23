import 'package:my_car_expenses/data/models/car/automobile_model.dart';
import 'package:my_car_expenses/domain/entities/automobile.dart';

class CarModelConverter {
  List<Automobile> toAutomobiles(List<AutomobileModel> models) => models.map((e) => toAutomobile(e)).toList();

  Automobile toAutomobile(AutomobileModel model) => Automobile(
    id: model.id,
    name: model.name
  );
}