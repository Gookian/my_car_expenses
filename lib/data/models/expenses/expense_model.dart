class ExpenseModel {
  final int id;
  final int carId;
  final String category;
  final String name;
  final DateTime date;
  final int sumExpense;
  final int currentMileage;
  final String additionalFields;

  ExpenseModel({
    required this.id,
    required this.carId,
    required this.category,
    required this.name,
    required this.date,
    required this.sumExpense,
    required this.currentMileage,
    required this.additionalFields
  });

  factory ExpenseModel.fromSqfliteDatabase(Map<String, dynamic> map) => ExpenseModel(
      id: map['id']?.toInt() ?? 0,
      carId: map['car_id']?.toInt() ?? 0,
      category: map['category'] ?? '',
      name: map['name'] ?? '',
      date: DateTime.tryParse(map['date']) ?? DateTime.now(),
      sumExpense: map['sum_expense']?.toInt() ?? 0,
      currentMileage: map['current_mileage']?.toInt() ?? 0,
      additionalFields: map['additional_fields'] ?? '',
  );
}
