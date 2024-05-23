class DocumentModel {
  final int id;
  final int carId;
  final String type;
  final int series;
  final int number;
  final DateTime dateOfIssue;
  final String additionalFields;

  DocumentModel({
    required this.id,
    required this.carId,
    required this.type,
    required this.series,
    required this.number,
    required this.dateOfIssue,
    required this.additionalFields
  });

  factory DocumentModel.fromSqfliteDatabase(Map<String, dynamic> map) => DocumentModel(
    id: map['id']?.toInt() ?? 0,
    carId: map['car_id']?.toInt() ?? 0,
    type: map['type'] ?? '',
    series: map['series']?.toInt() ?? 0,
    number: map['number']?.toInt() ?? 0,
    dateOfIssue: DateTime.tryParse(map['date_of_issue']) ?? DateTime.now(),
    additionalFields: map['additional_fields'] ?? '',
  );
}