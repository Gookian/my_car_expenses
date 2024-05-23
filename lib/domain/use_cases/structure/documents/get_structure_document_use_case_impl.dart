import 'package:my_car_expenses/data/models/structure/structure_type_model.dart';
import 'package:my_car_expenses/domain/converters/structure_converter.dart';
import 'package:my_car_expenses/domain/entities/document_type.dart';
import 'package:my_car_expenses/domain/repositories/structure_repository.dart';
import 'package:my_car_expenses/domain/use_cases/structure/get_structure_use_case.dart';
import 'package:my_car_expenses/presentation/screens/create_screen.dart';

class GetStructureDocumentUseCaseImpl implements GetStructureUseCase {
  final StructureRepository repository;
  final StructureConverter converter;
  final DocumentType type;

  GetStructureDocumentUseCaseImpl({
    required this.repository,
    required this.converter,
    required this.type
  });

  @override
  List<BaseStructureItem> invoke() {
    switch (type) {
      case DocumentType.vehicleRegistrationCertificate:
        return converter.convert(repository.getStructure(StructureTypeModel.vehicleRegistrationCertificate));
      case DocumentType.vehiclePassport:
        return converter.convert(repository.getStructure(StructureTypeModel.vehiclePassport));
      case DocumentType.insurance:
        return converter.convert(repository.getStructure(StructureTypeModel.insurance));
    }
  }
}
