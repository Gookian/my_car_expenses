import 'dart:ui';

import 'package:my_car_expenses/domain/entities/category_type.dart';

class CategoryData {
  final CategoryType type;
  final String name;
  final double sum;
  final Color color;
  final String assetSvgIcon;

  CategoryData({required this.type, required this.name, required this.sum, required this.color, required this.assetSvgIcon});
}