class NotificationModel {
  final int id;
  final int documentId;
  final String title;
  final String description;
  final DateTime date;

  NotificationModel({
    required this.id,
    required this.documentId,
    required this.title,
    required this.description,
    required this.date,
  });

  factory NotificationModel.fromSqfliteDatabase(Map<String, dynamic> map) => NotificationModel(
      id: map['id']?.toInt() ?? 0,
      documentId: map['car_id']?.toInt() ?? 0,
      title: map['category'] ?? '',
      description: map['name'] ?? '',
      date: DateTime.tryParse(map['date']) ?? DateTime.now(),
  );
}
