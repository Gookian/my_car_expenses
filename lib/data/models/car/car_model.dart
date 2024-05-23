class CarModel {
  final int id;
  final int modelId;
  final int makeId;
  final int fuelTypeId;
  final String name;
  final int yearOfIssue;
  final int startMileage;
  final int currentMileage;

  final int? fuelConsumption;
  final int? averageMonthlyMileage;

  CarModel({
    required this.id,
    required this.modelId,
    required this.makeId,
    required this.fuelTypeId,
    required this.name,
    required this.yearOfIssue,
    required this.startMileage,
    this.currentMileage = 0,
    this.fuelConsumption,
    this.averageMonthlyMileage
  });

  factory CarModel.fromSqfliteDatabase(Map<String, dynamic> map) => CarModel(
      id: map['id']?.toInt() ?? 0,
      modelId: map['model_id']?.toInt() ?? 0,
      makeId: map['make_id']?.toInt() ?? 0,
      fuelTypeId: map['fuel_type_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      yearOfIssue: map['year_of_issue']?.toInt() ?? 0,
      startMileage: map['start_mileage']?.toInt() ?? 0,
      currentMileage: map['current_mileage']?.toInt() ?? 0,
      fuelConsumption: map['fuel_consumption'],
      averageMonthlyMileage: map['average_monthly_mileage'],
  );
}