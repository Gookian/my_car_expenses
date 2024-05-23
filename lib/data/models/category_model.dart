import 'dart:ui';

import 'package:my_car_expenses/domain/entities/category_type.dart';

class CategoryModel {
  final CategoryType type;
  final String name;
  final Color color;
  final String assetSvgIcon;

  CategoryModel({required this.type, required this.name, required this.color, required this.assetSvgIcon});
}