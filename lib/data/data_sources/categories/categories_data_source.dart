import 'dart:ui';

import 'package:my_car_expenses/data/models/category_model.dart';
import 'package:my_car_expenses/domain/entities/category_type.dart';
import 'package:my_car_expenses/until/svg_icons.dart';

abstract interface class CategoriesDataSource {
  List<CategoryModel> getAll();
}

class CategoriesDataSourceImpl implements CategoriesDataSource {
  final List<CategoryModel> _categories = [
    CategoryModel(type: CategoryType.washExpense, name: "Мойка", color: const Color(0xFF47C9DB), assetSvgIcon: SvgIcons.carWash),
    CategoryModel(type: CategoryType.fuelExpense, name: "Заправка", color: const Color(0xFFB5DB47), assetSvgIcon: SvgIcons.gasStation),
    CategoryModel(type: CategoryType.consumableExpense, name: "Расхрдники", color: const Color(0xFFDB4B47), assetSvgIcon: SvgIcons.consumables),
    CategoryModel(type: CategoryType.repairExpense, name: "Ремонт", color: const Color(0xFF9547DB), assetSvgIcon: SvgIcons.hundred),
    CategoryModel(type: CategoryType.towTruckExpense, name: "Эвакуатор", color: const Color(0xFFDB8E47), assetSvgIcon: SvgIcons.towTruck),
    CategoryModel(type: CategoryType.serviceExpense, name: "Сервис", color: const Color(0xFF16A77B), assetSvgIcon: SvgIcons.service),
    CategoryModel(type: CategoryType.tuningExpense, name: "Тюнинг", color: const Color(0xFFA716A1), assetSvgIcon: SvgIcons.tuning),
    CategoryModel(type: CategoryType.parkingExpense, name: "Парковка", color: const Color(0xFF1629A7), assetSvgIcon: SvgIcons.parking),
    CategoryModel(type: CategoryType.tollRoadExpense, name: "Платка", color: const Color(0xFFA74916), assetSvgIcon: SvgIcons.tollRoad),
    CategoryModel(type: CategoryType.otherExpense, name: "Другое", color: const Color(0xFFE0E440), assetSvgIcon: SvgIcons.other),
  ];

  @override
  List<CategoryModel> getAll() => _categories;
}