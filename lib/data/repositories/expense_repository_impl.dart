import 'package:my_car_expenses/data/data_sources/database/expenses/expense_data_source.dart';
import 'package:my_car_expenses/data/models/expenses/expense_model.dart';
import 'package:my_car_expenses/domain/repositories/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseDataSource dataSource;

  ExpenseRepositoryImpl({required this.dataSource});

  @override
  Future<int> create({required ExpenseModel expenseModel}) => dataSource.create(expenseModel: expenseModel);

  @override
  Future<int> delete(int id) => dataSource.delete(id);

  @override
  Future<List<ExpenseModel>> gatByCategoryAndCarId(String category, int carId) => dataSource.fetchByCategoryAndCarId(category, carId);

  @override
  Future<ExpenseModel?> getById(int id) => dataSource.fetchById(id);
}