import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_car_expenses/presentation/bloc/screens/create_car_screen/create_car_cubit.dart';
import 'package:my_car_expenses/presentation/bloc/screens/create_car_screen/create_car_state.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';
import 'package:my_car_expenses/presentation/widgets/buttons/outlined_button_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/dropdown_button_field_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/search_text_field_form_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/text_field_widget.dart';

class CreateCarScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  CreateCarScreen({
    super.key,
  });

  final nameField = CustomTextField(
      titleText: "Название",
      labelText: "Введите название",
      validator: (value) {
        if (value!.isEmpty) return "Заполните поле";
        return null;
      },
      keyboardType: TextInputType.text
  );

  final yearOfIssueField = CustomTextField(
      titleText: "Год выпуска",
      labelText: "Введите год выпуска",
      hintText: "2024",
      suffixText: "год",
      validator: (value) {
        if (value!.isEmpty) return "Заполните поле";
        return null;
      },
      keyboardType: TextInputType.datetime
  );

  final millageField = CustomTextField(
      titleText: "Начальный пробег",
      labelText: "Введите пробег",
      hintText: "200000",
      suffixText: "км",
      validator: (value) {
        if (value!.isEmpty) return "Заполните поле";
        return null;
      },
      keyboardType: TextInputType.number
  );

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
          "Добавление автомобиля",
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
      body: BlocBuilder<CreateCarCubit, CreateCarState>(
        builder: (context, state) {
          if (state is CreateCarLoadedState) {
            return Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                        child: ListView(
                            padding: const EdgeInsets.all(20),
                            children: [
                              Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: nameField
                              ),
                              Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: SearchTextFieldForm(
                                      key: state.modelField,
                                      titleText: "Модель",
                                      labelText: "Начните вводить для поиска модели",
                                      hintText: "Lada",
                                      suffixText: "модель авто",
                                      searchItems: state.models.map((e) => e.name).toList(),
                                      text: state.selectModel,
                                      onChanged: (value) {
                                        if (value != null) {
                                          BlocProvider.of<CreateCarCubit>(context).selectModel(value);
                                        }
                                      }
                                  )
                              ),
                              Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: SearchTextFieldForm(
                                      key: state.makeField,
                                      titleText: "Марка",
                                      labelText: "Начните вводить для поиска марки",
                                      hintText: "Granta",
                                      suffixText: "марка авто",
                                      searchItems: state.makes.map((e) => e.name).toList(),
                                      text: state.selectMake,
                                      onChanged: (value) {
                                        if (value != null) {
                                          BlocProvider.of<CreateCarCubit>(context).selectMake(value);
                                        }
                                      }
                                  )
                              ),
                              Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: yearOfIssueField
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.only(right: 5),
                                          child: millageField
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.only(left: 5),
                                          child: CustomDropdownButtonField(
                                              key: state.fuelField,
                                              titleText: "Тип топлева",
                                              hintText: "Выберите тип топлева",
                                              items: ["Бензин", "Электричество"],
                                              selectedItem: "Бензин"
                                          )
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]
                        )
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: CustomOutlinedButton(
                          onPressed: () => {
                            if (formKey.currentState!.validate()) {
                              debugPrint("Try Valid Creating"),
                              BlocProvider.of<CreateCarCubit>(context).create(nameField.value, yearOfIssueField.value, millageField.value),
                              Navigator.pop(context, "update")
                            } else {
                              debugPrint("Try Don't Valid Creating")
                            }
                          },
                          child: const Text("Добавить автомобиль")
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
}