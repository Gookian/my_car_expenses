import 'package:my_car_expenses/data/models/structure/base_structure_model.dart';
import 'package:my_car_expenses/data/models/structure/structure_type_model.dart';

abstract interface class StructureRepository {
  List<BaseStructureItemModel> getStructure(StructureTypeModel type);
}