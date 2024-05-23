import 'package:my_car_expenses/domain/converters/expense_converter.dart';
import 'package:my_car_expenses/domain/entities/category_type.dart';
import 'package:my_car_expenses/domain/entities/expense.dart';
import 'package:my_car_expenses/domain/repositories/expense_repository.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/get/get_expenses_use_case.dart';

class GetExpensesUseCaseImpl implements GetExpensesUseCase {
  final ExpenseRepository repository;
  final ExpenseConverter converter;

  GetExpensesUseCaseImpl({
    required this.repository,
    required this.converter
  });

  @override
  Future<List<Expense>> invoke(CategoryType category, int carId) async {
    var list = await repository.gatByCategoryAndCarId(category.name, carId);
    var convertedList = list.map((item) => converter.toExpense(item)).toList();
    return convertedList;
  }
}