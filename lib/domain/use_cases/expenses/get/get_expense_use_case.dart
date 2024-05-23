import 'package:my_car_expenses/domain/entities/expense.dart';

abstract interface class GetExpenseUseCase {
  Future<Expense> invoke(int id);
}