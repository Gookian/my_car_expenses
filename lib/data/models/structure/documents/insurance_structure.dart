import 'package:flutter/material.dart';
import 'package:my_car_expenses/data/models/structure/base_structure_model.dart';

class InsuranceStructure {
  static List<BaseStructureItemModel> structure = [
    IdentifyStructureItemModel(
        name: "series",
        data: StructureTextFieldModel(
            titleText: "Серия",
            labelText: "Введите серию",
            hintText: "85 HP",
            suffixText: "серия",
            keyboardType: TextInputType.number
        )
    ),
    IdentifyStructureItemModel(
        name: "number",
        data: StructureTextFieldModel(
            titleText: "Номер",
            labelText: "Введите номер",
            hintText: "938475",
            suffixText: "номер",
            keyboardType: TextInputType.number
        )
    ),
    IdentifyStructureItemModel(
        name: "dateOfIssue",
        data: StructurePickerFieldModel(
            titleText: "Дата выдачи",
            hintText: "Выберите дату"
        )
    ),
    IdentifyStructureItemModel(
        name: "expirationDate",
        data: StructurePickerFieldModel(
            titleText: "Дата окончания действия",
            hintText: "Выберите дату"
        )
    )
  ];
}