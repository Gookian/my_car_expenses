import 'package:my_car_expenses/domain/entities/car.dart';
import 'package:my_car_expenses/domain/entities/expense.dart';

abstract class BaseExpenseState {
  final int currentCarId;

  BaseExpenseState({required this.currentCarId});
}

class BaseExpenseLoadingState extends BaseExpenseState {
  BaseExpenseLoadingState({required super.currentCarId});
}

class BaseExpenseLoadedState extends BaseExpenseState {
  final List<Expense> expenses;
  final Car car;

  BaseExpenseLoadedState({required this.expenses, required super.currentCarId, required this.car});
}

class BaseExpenseEmptyState extends BaseExpenseState {
  final Car car;

  BaseExpenseEmptyState({required super.currentCarId, required this.car});
}