import 'package:flutter/material.dart';
import 'package:my_car_expenses/data/models/car/fuel_type_model.dart';

abstract class BaseStructureFieldDataModel {
  final String titleText;
  final String hintText;

  BaseStructureFieldDataModel({
    required this.titleText,
    required this.hintText
  });
}

class StructureTextFieldModel extends BaseStructureFieldDataModel {
  final String? labelText;
  final String? suffixText;
  final TextInputType keyboardType;

  StructureTextFieldModel({
    required super.titleText,
    required super.hintText,
    required this.keyboardType,
    this.labelText,
    this.suffixText
  });
}

class StructureDropdownButtonFieldModel extends BaseStructureFieldDataModel {
  final List<String> items;

  StructureDropdownButtonFieldModel({
    required super.titleText,
    required super.hintText,
    required this.items
  });
}

class SearchTextFieldModel extends BaseStructureFieldDataModel {
  final String? labelText;
  final String? suffixText;
  final TextInputType keyboardType;
  final List<String> searchItems;

  SearchTextFieldModel({
    required super.titleText,
    required super.hintText,
    required this.searchItems,
    required this.keyboardType,
    this.labelText,
    this.suffixText
  });
}

class StructurePickerFieldModel extends BaseStructureFieldDataModel {
  StructurePickerFieldModel({required super.titleText, required super.hintText});
}

abstract class BaseStructureItemModel {}

class IdentifyStructureItemModel extends BaseStructureItemModel {
  final String name;
  final BaseStructureFieldDataModel data;

  IdentifyStructureItemModel({required this.name, required this.data});
}

class TwoStructureItemModel extends BaseStructureItemModel {
  final IdentifyStructureItemModel itemLeft;
  final IdentifyStructureItemModel itemRight;

  TwoStructureItemModel({required this.itemLeft, required this.itemRight});
}