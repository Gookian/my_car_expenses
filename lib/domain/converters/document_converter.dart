import 'package:my_car_expenses/data/models/documents/document_model.dart';
import 'package:my_car_expenses/domain/entities/document.dart';
import 'package:my_car_expenses/domain/entities/document_type.dart';

class DocumentConverter {
  List<Document> toDocuments(List<DocumentModel> models) => models.map((model) => toDocument(model)).toList();

  Document toDocument(DocumentModel model) => Document(
      id: model.id,
      type: getDocumentTypeByString(model.type),
      series: model.series,
      number: model.number,
      dateOfIssue: model.dateOfIssue,
      additionalFields: model.additionalFields
  );

  DocumentModel toDocumentModel(Document entity, int carId) => DocumentModel(
      id: entity.id,
      carId: carId,
      type: entity.type.name,
      series: entity.series,
      number: entity.number,
      dateOfIssue: entity.dateOfIssue,
      additionalFields: entity.additionalFields,
  );

  DocumentType getDocumentTypeByString(String value) {
    switch (value) {
      case "vehiclePassport":
        return DocumentType.vehiclePassport;
      case "insurance":
        return DocumentType.insurance;
      default:
        return DocumentType.vehicleRegistrationCertificate;
    }
  }
}