import 'package:my_car_expenses/domain/converters/expense_converter.dart';
import 'package:my_car_expenses/domain/entities/expense.dart';
import 'package:my_car_expenses/domain/repositories/expense_repository.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/get/get_expense_use_case.dart';
import 'package:my_car_expenses/until/exception/not_find_exception.dart';

class GetExpenseUseCaseImpl implements GetExpenseUseCase {
  final ExpenseRepository repository;
  final ExpenseConverter converter;

  GetExpenseUseCaseImpl({
    required this.repository,
    required this.converter
  });

  @override
  Future<Expense> invoke(int id) async {
    var expense = await repository.getById(id);
    if (expense != null) {
      var convertedExpense = converter.toExpense(expense);
      return convertedExpense;
    } else {
      throw NotFindException("Не удалось найти расход");
    }
  }
}