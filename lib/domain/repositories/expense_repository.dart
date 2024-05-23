import 'package:my_car_expenses/data/models/expenses/expense_model.dart';

abstract interface class ExpenseRepository {
  Future<int> create({required ExpenseModel expenseModel});
  Future<int> delete(int id);
  Future<List<ExpenseModel>> gatByCategoryAndCarId(String category, int carId);
  Future<ExpenseModel?> getById(int id);
}