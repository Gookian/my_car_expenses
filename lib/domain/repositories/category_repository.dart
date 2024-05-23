import '../../data/models/category_model.dart';

abstract interface class CategoryRepository {
  List<CategoryModel> getAll();
}