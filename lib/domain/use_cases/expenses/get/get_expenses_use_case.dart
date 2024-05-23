import 'package:my_car_expenses/domain/entities/category_type.dart';
import 'package:my_car_expenses/domain/entities/expense.dart';

abstract interface class GetExpensesUseCase {
  Future<List<Expense>> invoke(CategoryType category, int carId);
}