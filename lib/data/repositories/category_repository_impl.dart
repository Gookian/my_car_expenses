import 'package:my_car_expenses/data/data_sources/categories/categories_data_source.dart';
import 'package:my_car_expenses/data/models/category_model.dart';
import 'package:my_car_expenses/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoriesDataSource dataSource;

  CategoryRepositoryImpl({required this.dataSource});

  @override
  List<CategoryModel> getAll() => dataSource.getAll();
}