import 'package:my_car_expenses/data/data_sources/structure/structure_data_source.dart';
import 'package:my_car_expenses/data/models/structure/base_structure_model.dart';
import 'package:my_car_expenses/data/models/structure/structure_type_model.dart';
import 'package:my_car_expenses/domain/repositories/structure_repository.dart';

class StructureRepositoryImpl implements StructureRepository {
  final StructureDataSource dataSource;

  StructureRepositoryImpl({required this.dataSource});

  @override
  List<BaseStructureItemModel> getStructure(StructureTypeModel type) => dataSource.getStructure(type);
}