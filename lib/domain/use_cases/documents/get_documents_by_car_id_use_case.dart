import 'package:my_car_expenses/domain/converters/document_converter.dart';
import 'package:my_car_expenses/domain/entities/document.dart';
import 'package:my_car_expenses/domain/repositories/documents_repository.dart';

abstract interface class GetDocumentsByCarIdUseCase {
  Future<List<Document>> invoke(int carId);
}

class GetDocumentsByCarIdUseCaseImpl implements GetDocumentsByCarIdUseCase {
  final DocumentRepository repository;
  final DocumentConverter converter;

  GetDocumentsByCarIdUseCaseImpl({
    required this.repository,
    required this.converter
  });

  @override
  Future<List<Document>> invoke(int carId) async {
    final models = await repository.getByCarId(carId);
    final convertedEntity = converter.toDocuments(models);

    return convertedEntity;
  }
}