class CarUpdateModel {
  final int modelId;
  final int makeId;
  final int fuelTypeId;
  final String name;
  final int yearOfIssue;
  final int startMileage;

  CarUpdateModel({
    required this.modelId,
    required this.makeId,
    required this.fuelTypeId,
    required this.name,
    required this.yearOfIssue,
    required this.startMileage,
  });
}