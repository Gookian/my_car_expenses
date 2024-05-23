import 'package:my_car_expenses/data/models/structure/base_structure_model.dart';
import 'package:my_car_expenses/data/models/structure/structure_type_model.dart';
import 'package:my_car_expenses/domain/converters/structure_converter.dart';
import 'package:my_car_expenses/domain/entities/category_type.dart';
import 'package:my_car_expenses/domain/repositories/structure_repository.dart';
import 'package:my_car_expenses/domain/use_cases/structure/get_structure_use_case.dart';
import 'package:my_car_expenses/presentation/screens/create_screen.dart';

class GetStructureExpenseUseCaseImpl implements GetStructureUseCase {
  final StructureRepository repository;
  final StructureConverter converter;
  final CategoryType type;

  GetStructureExpenseUseCaseImpl({
    required this.repository,
    required this.converter,
    required this.type
  });

  @override
  List<BaseStructureItem> invoke() {
    switch (type) {
      case CategoryType.fuelExpense:
        return converter.convert(repository.getStructure(StructureTypeModel.fuelExpense));
      case CategoryType.washExpense:
        return converter.convert(repository.getStructure(StructureTypeModel.washExpense));
      case CategoryType.consumableExpense:
        return converter.convert(repository.getStructure(StructureTypeModel.consumableExpense));
      case CategoryType.repairExpense:
        return converter.convert(repository.getStructure(StructureTypeModel.repairExpense));
      case CategoryType.towTruckExpense:
        return converter.convert(repository.getStructure(StructureTypeModel.towTruckExpense));
      case CategoryType.serviceExpense:
        return converter.convert(repository.getStructure(StructureTypeModel.serviceExpense));
      case CategoryType.tuningExpense:
        return converter.convert(repository.getStructure(StructureTypeModel.tuningExpense));
      case CategoryType.parkingExpense:
        return converter.convert(repository.getStructure(StructureTypeModel.parkingExpense));
      case CategoryType.tollRoadExpense:
        return converter.convert(repository.getStructure(StructureTypeModel.tollRoadExpense));
      case CategoryType.otherExpense:
        return converter.convert(repository.getStructure(StructureTypeModel.otherExpense));
    }
  }
}
