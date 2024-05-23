import 'package:my_car_expenses/data/models/documents/document_model.dart';

abstract interface class DocumentRepository {
  Future<int> add(DocumentModel documentModel);
  Future<List<DocumentModel>> getByCarId(int carId);
}