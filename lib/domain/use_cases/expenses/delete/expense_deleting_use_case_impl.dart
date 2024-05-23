import 'package:my_car_expenses/domain/repositories/expense_repository.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/delete/expense_deleting_use_case.dart';

class ExpenseDeletingUseCaseImpl implements ExpenseDeletingUseCase {
  final ExpenseRepository repository;

  ExpenseDeletingUseCaseImpl({
    required this.repository
  });

  @override
  void invoke(int id) {
    repository.delete(id);
  }
}