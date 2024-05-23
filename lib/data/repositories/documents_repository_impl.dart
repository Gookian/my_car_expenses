import 'package:my_car_expenses/data/data_sources/database/documents/document_data_source.dart';
import 'package:my_car_expenses/data/models/documents/document_model.dart';
import 'package:my_car_expenses/domain/repositories/documents_repository.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentDataSource dataSource;

  DocumentRepositoryImpl({required this.dataSource});

  @override
  Future<int> add(DocumentModel documentModel) => dataSource.create(documentModel: documentModel);

  @override
  Future<List<DocumentModel>> getByCarId(int carId) => dataSource.fetchByCarId(carId);
}