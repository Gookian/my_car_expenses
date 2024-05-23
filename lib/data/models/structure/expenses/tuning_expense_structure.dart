import 'package:flutter/material.dart';
import 'package:my_car_expenses/data/models/structure/base_structure_model.dart';

class TuningExpenseStructure {
  static List<BaseStructureItemModel> structure = [
    IdentifyStructureItemModel(
        name: "name",
        data: StructureTextFieldModel(
            titleText: "Название",
            hintText: "Введите название",
            keyboardType: TextInputType.text)),
    IdentifyStructureItemModel(
        name: "currentMileage",
        data: StructureTextFieldModel(
            titleText: "Текущий пробег",
            labelText: "Текущий пробег",
            suffixText: "км",
            hintText: "200000",
            keyboardType: TextInputType.number)),
    IdentifyStructureItemModel(
        name: "sumExpense",
        data: StructureTextFieldModel(
            titleText: "Сумма",
            labelText: "Сумму затрат",
            suffixText: "руб",
            hintText: "500",
            keyboardType: TextInputType.number))
  ];
}