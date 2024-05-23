import 'package:my_car_expenses/domain/entities/document.dart';

class CarDocuments {
  final int carId;
  final String name;
  final List<Document> documents;

  CarDocuments({
    required this.carId,
    required this.name,
    required this.documents
  });
}