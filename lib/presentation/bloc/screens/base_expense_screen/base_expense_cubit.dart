import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_car_expenses/domain/entities/car.dart';
import 'package:my_car_expenses/domain/entities/category_type.dart';
import 'package:my_car_expenses/domain/entities/expense.dart';
import 'package:my_car_expenses/domain/use_cases/car/get/get_all_car_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/car/get/get_car_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/expenses/get/get_expenses_use_case.dart';
import 'package:my_car_expenses/presentation/bloc/screens/base_expense_screen/base_expense_state.dart';

class BaseExpenseCubit extends Cubit<BaseExpenseState> {
  final GetExpensesUseCase getExpensesUseCase;
  final GetCarUseCase getCarUseCase;
  final GetAllCarUseCase getAllCarUseCase;
  final CategoryType category;

  BaseExpenseCubit({
    required this.getExpensesUseCase,
    required this.getCarUseCase,
    required this.getAllCarUseCase,
    required this.category
  }) : super(BaseExpenseLoadingState(currentCarId: 0));

  Future<void> loadExpense(int carId) async {
    List<Expense> expenses = await getExpensesUseCase.invoke(category, carId);
    Car car = await getCarUseCase.invoke(carId);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (expenses.isNotEmpty) {
        emit(BaseExpenseLoadedState(expenses: expenses, currentCarId: carId, car: car));
      } else {
        emit(BaseExpenseEmptyState(currentCarId: carId, car: car));
      }
    });
  }

  void setCurrentCarId(int carId) async {
    emit(BaseExpenseLoadingState(currentCarId: 0));
    loadExpense(carId);
  }

  Future<List<Car>> getCar() async {
    return await getAllCarUseCase.invoke();
  }

  void update(int carId) {
    emit(BaseExpenseLoadingState(currentCarId: 0));
    loadExpense(carId);
  }
}