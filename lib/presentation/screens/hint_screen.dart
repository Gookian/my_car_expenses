import 'package:flutter/material.dart';
import 'package:my_car_expenses/presentation/providers/home_provider.dart';
import 'package:my_car_expenses/presentation/widgets/fields/date_picker_field_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/dropdown_button_field_widget.dart';
import 'package:my_car_expenses/presentation/widgets/buttons/outlined_button_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/search_text_field_form_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/text_field_widget.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';

class HintScreen extends StatelessWidget {
  HintScreen({super.key});

  static const primaryColor = Color(0xFF413F57);
  final formKey = GlobalKey<FormState>();

  final CustomTextField textFormField = CustomTextField(
    titleText: "Поле с вводом текста",
    labelText: "Введите текст",
    hintText: "1000",
    suffixText: "руб",
    //text: "Начальный текст",
  );

  final CustomDropdownButtonField dropdownButtonFromField = CustomDropdownButtonField(
      titleText: "Поле с выподяющим списком",
      hintText: "Нажмите чтобы выбрать",
      items: const ['Отдых', 'Одежда', 'Транспорт', 'Еда', 'Другое'],
      selectedItem: "Еда"
  );

  final DatePickerField datePickerFromField = DatePickerField(
    titleText: "Поле с выбором даты",
    hintText: "Нажмите чтобы выбрать дату",
    //startDate: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeProvider.of().primaryColor,
        title: Text(
          'Подсказки',
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
      body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: textFormField,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: dropdownButtonFromField,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 32),
              child: datePickerFromField,
            ),
            CustomOutlinedButton(
              onPressed: () {
                var text = textFormField.value;
                var selected = dropdownButtonFromField.value;
                var date = datePickerFromField.value;
                debugPrint('Received click $text, $selected, ${date.toString()}');

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const HomeProvider(),
                ));
              },
              child: const Text("Пропустить"),
            ),
            Form(
              key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    SearchTextFieldForm(
                      titleText: "Поле с вводом текста и поиском",
                      searchItems: ["Вариант1", "Значение1", "Элемент1", "Вариант2", "Значение2", "Значение3", "Значение4", "Значение5"],
                      labelText: "Начните вводить текст для поиска модели",
                      hintText: "Lada",
                      suffixText: "модель",
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 12),
                    CustomOutlinedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          debugPrint("Try Valid Creating");
                        } else {
                          debugPrint("Try Don't Valid Creating");
                        }
                      },
                      child: const Text("Тест"),
                    )
                  ],
                )
            ),
            Container(
              height: 400,
              color: Colors.red,
            ),
            Container(
              height: 400,
              color: Colors.green,
            ),
            Container(
              height: 400,
              color: Colors.blue,
            )
          ]
      )
    );
  }
}