import 'package:my_car_expenses/data/models/expenses/expense_model.dart';
import 'package:my_car_expenses/domain/entities/category_data.dart';
import 'package:my_car_expenses/domain/repositories/category_repository.dart';
import 'package:my_car_expenses/domain/repositories/expense_repository.dart';
import 'package:my_car_expenses/domain/use_cases/get_category/get_category_data_on_month_use_case.dart';

class GetCategoryDataOnMonthUseCaseImpl implements GetCategoryDataOnMonthUseCase {
  final CategoryRepository categoryRepository;
  final ExpenseRepository expenseRepository;

  GetCategoryDataOnMonthUseCaseImpl({
    required this.categoryRepository,
    required this.expenseRepository
  });

  @override
  Future<List<CategoryData>> invoke(DateTime dateTime, int carId) async {
    List<CategoryData> result = [];

    var categories = categoryRepository.getAll();

    for (int i = 0; i < categories.length; i++) {
      var categoryExpenses = await expenseRepository.gatByCategoryAndCarId(categories[i].type.name, carId);
      CategoryData categoryData = CategoryData(
          type: categories[i].type,
          name: categories[i].name,
          sum: _getSumCategory(categoryExpenses, dateTime),
          color: categories[i].color,
          assetSvgIcon: categories[i].assetSvgIcon
      );
      result.add(categoryData);
    }

    return result;
  }

  double _getSumCategory(List<ExpenseModel> expenses, DateTime dateTime) {
    double sum = 0.0;
    for (int i = 0; i < expenses.length; i++) {
      if (dateTime.month == expenses[i].date.month) {
        sum += expenses[i].sumExpense;
      }
    }
    return sum;
  }
}