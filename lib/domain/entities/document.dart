import 'package:my_car_expenses/domain/entities/document_type.dart';

class Document {
  final int id;
  final DocumentType type;
  final int series;
  final int number;
  final DateTime dateOfIssue;
  final String additionalFields;

  Document({
    required this.id,
    required this.type,
    required this.series,
    required this.number,
    required this.dateOfIssue,
    required this.additionalFields
  });

  factory Document.fromMap(Map<String, dynamic> map) => Document(
      id: 0,
      type: map['type'],
      series: map['series'] ?? '',
      number: map['number'] ?? '',
      dateOfIssue: DateTime.tryParse(map['dateOfIssue']) ?? DateTime.now(),
      additionalFields: map['additionalFields'] ?? '',
  );
}