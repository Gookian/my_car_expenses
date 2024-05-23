import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_car_expenses/presentation/bloc/screens/create_screen/create_cubit.dart';
import 'package:my_car_expenses/presentation/bloc/screens/create_screen/create_state.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';
import 'package:my_car_expenses/presentation/widgets/buttons/outlined_button_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/date_picker_field_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/dropdown_button_field_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/search_text_field_form_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/text_field_widget.dart';

enum BehaviorScreen {
  create,
  edit
}

abstract class BaseStructureFieldData {
  final String titleText;
  final String hintText;

  BaseStructureFieldData({
    required this.titleText,
    required this.hintText
  });
}

class StructureTextField extends BaseStructureFieldData {
  final String? labelText;
  final String? suffixText;
  final TextInputType keyboardType;

  StructureTextField({
    required super.titleText,
    required super.hintText,
    required this.keyboardType,
    this.labelText,
    this.suffixText
  });
}

class StructureDropdownButtonField extends BaseStructureFieldData {
  final List<String> items;

  StructureDropdownButtonField({
    required super.titleText,
    required super.hintText,
    required this.items
  });
}

class SearchTextField extends BaseStructureFieldData {
  final String? labelText;
  final String? suffixText;
  final TextInputType keyboardType;
  final List<String> searchItems;

  SearchTextField({
    required super.titleText,
    required super.hintText,
    required this.searchItems,
    required this.keyboardType,
    this.labelText,
    this.suffixText
  });
}

class StructurePickerField extends BaseStructureFieldData {
  StructurePickerField({required super.titleText, required super.hintText});
}

abstract class BaseStructureItem {}

class IdentifyStructureItem extends BaseStructureItem {
  final String name;
  final BaseStructureFieldData data;

  IdentifyStructureItem({required this.name, required this.data});
}

class TwoStructureItem extends BaseStructureItem {
  final IdentifyStructureItem itemLeft;
  final IdentifyStructureItem itemRight;

  TwoStructureItem({required this.itemLeft, required this.itemRight});
}

class CreateScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final String title;
  final BehaviorScreen behaviorScreen;

  CreateScreen({
    super.key,
    required this.title,
    required this.behaviorScreen
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeProvider.of().primaryColor,
        leading: Container(
          margin: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              Navigator.pop(context, true)
            },
            iconSize: 30,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 20.0,
              fontFamily: ThemeProvider.of().fontFamily
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      backgroundColor: ThemeProvider.of().backgroundColor,
      body: BlocBuilder<CreateCubit, CreateState>(
        builder: (context, state) {
          if (state is CreateLoadingState) {
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: ThemeProvider.of().accentColor,
                      strokeAlign: 5,
                      strokeWidth: 5,
                      strokeCap: StrokeCap.round,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Загрузка",
                      style: TextStyle(
                          color: ThemeProvider.of().primaryT10Color,
                          fontFamily: ThemeProvider.of().fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    )
                  ],
                )
            );
          }
          if (state is CreateLoadedState) {
            return Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                          child: ListView.builder(
                              padding: const EdgeInsets.all(20),
                              itemCount: state.structure.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                var structureItem = state.structure[index];
                                if (structureItem is IdentifyStructureItem) {
                                  var field = _getFieldByStructureItemType(structureItem.data, context);
                                  BlocProvider.of<CreateCubit>(context).addField(structureItem.name, field);
                                  return Container(
                                      alignment: Alignment.topCenter,
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: field
                                  );
                                }
                                if (structureItem is TwoStructureItem) {
                                  var fieldLeft = _getFieldByStructureItemType(structureItem.itemLeft.data, context);
                                  var fieldRight = _getFieldByStructureItemType(structureItem.itemRight.data, context);
                                  BlocProvider.of<CreateCubit>(context).addField(structureItem.itemLeft.name, fieldLeft);
                                  BlocProvider.of<CreateCubit>(context).addField(structureItem.itemRight.name, fieldRight);
                                  return Container(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                              margin: const EdgeInsets.only(right: 5),
                                              child: fieldLeft
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                              margin: const EdgeInsets.only(left: 5),
                                              child: fieldRight
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                                return null;
                              }
                          ),
                        )
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: CustomOutlinedButton(
                          onPressed: () => {
                            if (formKey.currentState!.validate()) {
                              debugPrint("Try Valid Creating"),
                              BlocProvider.of<CreateCubit>(context).create(),
                              Navigator.pop(context, "update")
                            } else {
                              debugPrint("Try Don't Valid Creating")
                            }
                          },
                          child: const Text("Добавить")
                      ),
                    )
                  ],
                )
            );
          }
          return Container();
        }
      )
    );
  }

  Widget _getFieldByStructureItemType(BaseStructureFieldData data, BuildContext context) {
    if (data is StructureTextField) {
      return CustomTextField(
          titleText: data.titleText,
          labelText: data.labelText,
          hintText: data.hintText,
          suffixText: data.suffixText,
          //text: "",
          validator: (value) {
            if (value!.isEmpty) return "Заполните поле";
            return null;
          },
          keyboardType: data.keyboardType
      );
    } else if (data is SearchTextField) {
      return SearchTextFieldForm(
          titleText: data.titleText,
          labelText: data.labelText,
          hintText: data.hintText,
          suffixText: data.suffixText,
          searchItems: data.searchItems,
          keyboardType: data.keyboardType
      );
    } else if (data is StructureDropdownButtonField) {
      return CustomDropdownButtonField(
          titleText: data.titleText,
          hintText: data.hintText,
          items: data.items ?? [],
          selectedItem: data.items?.first
      );
    } else if (data is StructurePickerField) {
      return DatePickerField(
          titleText: data.titleText,
          hintText: data.hintText,
          //startDate: DateTime.now(),
          validator: (value) {
            if (value!.isEmpty) return "Заполните поле";
            //if (value!) return "Заполните поле";
            return null;
          }
      );
    } else {
      return Container();
    }
  }
}