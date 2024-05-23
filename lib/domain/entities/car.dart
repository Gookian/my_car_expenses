class Car {
  final int id;
  final String model;
  final String make;
  final String fuelType;
  final String name;
  final int yearOfIssue;
  final int startMileage;
  final int currentMileage = 0;

  final int? fuelConsumption;
  final int? averageMonthlyMileage;

  Car({
    required this.id,
    required this.model,
    required this.make,
    required this.fuelType,
    required this.name,
    required this.yearOfIssue,
    required this.startMileage,
    this.fuelConsumption,
    this.averageMonthlyMileage
  });

  factory Car.fromMap(Map<String, dynamic> map) => Car(
      id: 0,
      model: map['model'] ?? '',
      make: map['make'] ?? '',
      fuelType: map['fuelType'] ?? '',
      name: map['name'] ?? '',
      yearOfIssue: int.tryParse(map['yearOfIssue']!) ?? 0,
      startMileage: int.tryParse(map['startMileage']!) ?? 0
  );
}