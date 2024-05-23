class FuelExpenseAdditionalFields {
  final int refueled;
  final int remainingFuel;

  FuelExpenseAdditionalFields({
    required this.refueled,
    required this.remainingFuel
  });

  Map<String, dynamic> toJson() => {
    "refueled": refueled,
    "remainingFuel": remainingFuel,
  };
}