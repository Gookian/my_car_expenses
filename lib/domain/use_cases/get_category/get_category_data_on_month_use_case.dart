import 'package:my_car_expenses/domain/entities/category_data.dart';

abstract interface class GetCategoryDataOnMonthUseCase {
  Future<List<CategoryData>> invoke(DateTime dateTime, int carId);
}