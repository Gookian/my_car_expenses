import 'package:flutter/material.dart';
import 'package:my_car_expenses/data/models/structure/base_structure_model.dart';

class FuelExpenseStructure {
  static List<BaseStructureItemModel> structure = [
    IdentifyStructureItemModel(
        name: "name",
        data: StructureTextFieldModel(
            titleText: "Название",
            hintText: "Введите название",
            keyboardType: TextInputType.text)),
    TwoStructureItemModel(
        itemLeft: IdentifyStructureItemModel(
            name: "remainingFuel",
            data: StructureTextFieldModel(
                titleText: "Остаток топлива",
                labelText: "Остоток в баке",
                suffixText: "л",
                hintText: "10",
                keyboardType: TextInputType.number)),
        itemRight: IdentifyStructureItemModel(
            name: "refueled",
            data: StructureTextFieldModel(
                titleText: "Заправлено",
                labelText: "Заправлено",
                suffixText: "л",
                hintText: "10",
                keyboardType: TextInputType.number))),
    TwoStructureItemModel(
        itemLeft: IdentifyStructureItemModel(
            name: "currentMileage",
            data: StructureTextFieldModel(
                titleText: "Текущий пробег",
                labelText: "Текущий пробег",
                suffixText: "км",
                hintText: "200000",
                keyboardType: TextInputType.number)),
        itemRight: IdentifyStructureItemModel(
            name: "sumExpense",
            data: StructureTextFieldModel(
                titleText: "Сумма",
                labelText: "Сумму затрат",
                suffixText: "руб",
                hintText: "500",
                keyboardType: TextInputType.number)))
  ];
}