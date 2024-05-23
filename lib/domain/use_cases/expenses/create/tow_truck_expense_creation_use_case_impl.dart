import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:my_car_expenses/domain/converters/expense_converter.dart';
import 'package:my_car_expenses/domain/entities/additional_fields/fuel_expense_additional_fields.dart';
import 'package:my_car_expenses/domain/entities/category_type.dart';
import 'package:my_car_expenses/domain/entities/expense.dart';
import 'package:my_car_expenses/domain/repositories/car_repository.dart';
import 'package:my_car_expenses/domain/repositories/expense_repository.dart';
import 'package:my_car_expenses/domain/use_cases/creating_use_case.dart';

class TowTruckExpenseCreationUseCaseImpl implements CreatingUseCase {
  final ExpenseRepository expenseRepository;
  final CarRepository carRepository;
  final ExpenseConverter converter;
  final int carId;

  final CategoryType category = CategoryType.towTruckExpense;

  TowTruckExpenseCreationUseCaseImpl({
    required this.expenseRepository,
    required this.carRepository,
    required this.converter,
    required this.carId
  });

  @override
  void invoke(Map<String, dynamic> map) {
    var expenseModel = converter.toExpenseModel(Expense.fromMap(map, carId, category.name, '{}'));

    carRepository.updateCurrentMillage(carId, int.tryParse(map['currentMileage']!) ?? 0);
    expenseRepository.create(expenseModel: expenseModel);
  }
}