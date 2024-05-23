import 'package:my_car_expenses/data/models/structure/base_structure_model.dart';
import 'package:my_car_expenses/presentation/screens/create_screen.dart';

class StructureConverter {
  List<BaseStructureItem> convert(List<BaseStructureItemModel> structureModel) {
    List<BaseStructureItem> resultList = [];
    for (int i = 0; i < structureModel.length; i++) {
      var item = structureModel[i];
      if (item is IdentifyStructureItemModel) {
        var value = tryParse(item.data, item.name);
        if (value != null) resultList.add(value);
      } else if (item is TwoStructureItemModel) {
        var valueLeft = tryParse(item.itemLeft.data, item.itemLeft.name);
        var valueRight = tryParse(item.itemRight.data, item.itemRight.name);
        resultList.add(TwoStructureItem(
            itemLeft: valueLeft as IdentifyStructureItem,
            itemRight: valueRight as IdentifyStructureItem
        ));
      }
    }

    return resultList;
  }

  BaseStructureItem? tryParse(BaseStructureFieldDataModel data, String itemName) {
    if (data is StructureTextFieldModel) {
      return IdentifyStructureItem(
          name: itemName,
          data: StructureTextField(
              titleText: data.titleText,
              hintText: data.hintText,
              labelText: data.labelText,
              suffixText: data.suffixText,
              keyboardType: data.keyboardType
          )
      );
    } else if (data is SearchTextFieldModel) {
      return IdentifyStructureItem(
          name: itemName,
          data: SearchTextField(
              titleText: data.titleText,
              hintText: data.hintText,
              labelText: data.labelText,
              suffixText: data.suffixText,
              keyboardType: data.keyboardType,
              searchItems: data.searchItems
          )
      );
    } else if (data is StructureDropdownButtonFieldModel) {
      return IdentifyStructureItem(
          name: itemName,
          data: StructureDropdownButtonField(
              titleText: data.titleText,
              hintText: data.hintText,
              items: data.items
          )
      );
    } else if (data is StructurePickerFieldModel) {
      return IdentifyStructureItem(
          name: itemName,
          data: StructurePickerField(
              titleText: data.titleText,
              hintText: data.hintText
          )
      );
    } else {
      return null;
    }
  }
}