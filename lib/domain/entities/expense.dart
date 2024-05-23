class Expense {
  final int id;
  final int carId;
  final String category;
  final String name;
  final DateTime date;
  final int sumExpense;
  final int currentMileage;
  final String additionalFields;

  Expense({
    required this.id,
    required this.carId,
    required this.category,
    required this.name,
    required this.date,
    required this.sumExpense,
    required this.currentMileage,
    required this.additionalFields
  });

  factory Expense.fromMap(Map<String, dynamic> map, int carId, String category, String additionalFields) => Expense(
      id: 0,
      carId: carId,
      category: category,
      name: map['name'] ?? '',
      date: DateTime.now(),
      sumExpense: int.tryParse(map['sumExpense']!) ?? 0,
      currentMileage: int.tryParse(map['currentMileage']!) ?? 0,
      additionalFields: additionalFields
  );
}
