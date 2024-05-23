import 'package:my_car_expenses/data/models/expenses/expense_model.dart';
import 'package:my_car_expenses/domain/entities/expense.dart';

class ExpenseConverter {
  ExpenseModel toExpenseModel(Expense entity) {
    return ExpenseModel(
        id: entity.id,
        carId: entity.carId,
        category: entity.category,
        name: entity.name,
        date: entity.date,
        sumExpense: entity.sumExpense,
        currentMileage: entity.currentMileage,
        additionalFields: entity.additionalFields
    );
  }

  Expense toExpense(ExpenseModel model) {
    return Expense(
        id: model.id,
        carId: model.carId,
        category: model.category,
        name: model.name,
        date: model.date,
        sumExpense: model.sumExpense,
        currentMileage: model.currentMileage,
        additionalFields: model.additionalFields
    );
  }
}