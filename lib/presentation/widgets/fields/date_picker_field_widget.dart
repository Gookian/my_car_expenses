import 'package:flutter/material.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_car_expenses/presentation/bloc/widgets/date_picker_field_cubit.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  DatePickerField({
    super.key,
    required this.titleText,
    this.validator,
    this.hintText,
    this.startDate
  });

  final String titleText;
  final String? Function(String?)? validator;
  final String? hintText;
  final DateTime? startDate;

  final TextEditingController _controller = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd.MM.yyyy');

  DateTime? get value {
    return _dateFormat.tryParse(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final double widthAll = MediaQuery
        .of(context)
        .size
        .width;

    return BlocProvider<DatePickerFieldCubit>(
        create: (context) => DatePickerFieldCubit(startDate),
        child: BlocBuilder<DatePickerFieldCubit, DateTime?>(
            builder: (context, state) {
              if (state != null) {
                _controller.text = _dateFormat.format(state);
              } else {
                _controller.text = "";
              }

              return Column(
                  children: [
                    Container(
                        width: widthAll,
                        margin: const EdgeInsets.only(left: 4, bottom: 8),
                        child: Text(
                          titleText,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: ThemeProvider.of().primaryT10Color,
                              fontFamily: ThemeProvider.of().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        )
                    ),
                    TextFormField(
                      controller: _controller,
                      readOnly: true,
                      style: TextStyle(
                          color: ThemeProvider.of().primaryT10Color,
                          fontFamily: ThemeProvider.of().fontFamily,
                          fontSize: 18
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 20
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeProvider.of().accentColor,
                                width: ThemeProvider.of().borderWidth
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ThemeProvider.of().borderRadius)
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ThemeProvider.of().primaryT10Color,
                              width: ThemeProvider.of().borderWidth
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ThemeProvider.of().borderRadius)
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ThemeProvider.of().errorColor,
                              width: ThemeProvider.of().borderWidth
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ThemeProvider.of().borderRadius)
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ThemeProvider.of().errorColor,
                              width: ThemeProvider.of().borderWidth
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ThemeProvider.of().borderRadius)
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: hintText,
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 60,
                          maxWidth: 60
                        ),
                        suffixIcon: Icon(
                            Icons.date_range_rounded, color: ThemeProvider.of().accentColor,
                            size: 30,
                        ),
                        errorStyle: _getErrorTextStyle(),
                        hintStyle: _getHelpTextStyle(),
                      ),
                      onTap: () => { _openDatePicker(context) },
                      validator: validator,
                    )
                  ]
              );
            }
        )
    );
  }

  TextStyle _getHelpTextStyle() {
    return TextStyle(
        color: ThemeProvider.of().primaryT50Color,
        fontFamily: ThemeProvider.of().fontFamily,
        fontSize: 18
    );
  }

  TextStyle _getErrorTextStyle() {
    return TextStyle(
        color: ThemeProvider.of().errorColor,
        fontFamily: ThemeProvider.of().fontFamily,
        fontSize: 16
    );
  }

  void _openDatePicker(BuildContext context) {
    var currentState = BlocProvider.of<DatePickerFieldCubit>(context);
    
    var bottomPicker = BottomPicker.date(
      initialDateTime: currentState.state,
      titlePadding: const EdgeInsets.only(top: 20, bottom: 8),
      pickerTitle: Text(
        "Выберите дату",
        style: TextStyle(
            color: ThemeProvider.of().primaryT10Color,
            fontFamily: ThemeProvider.of().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 18
        ),
      ),
      buttonStyle: BoxDecoration(
          border: Border(
              left: BorderSide(color: ThemeProvider.of().accentColor, width: ThemeProvider.of().borderWidth),
              top: BorderSide(color: ThemeProvider.of().accentColor, width: ThemeProvider.of().borderWidth),
              right: BorderSide(color: ThemeProvider.of().accentColor, width: ThemeProvider.of().borderWidth),
              bottom: BorderSide(color: ThemeProvider.of().accentColor, width: ThemeProvider.of().borderWidth)
          ),
          borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius)
      ),
      buttonContent: Text(
        "Выбрать",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: ThemeProvider.of().primaryT10Color,
            fontFamily: ThemeProvider.of().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 18
        ),
      ),
      buttonWidth: 300,
      buttonPadding: 20,
      closeIconColor: ThemeProvider.of().primaryT10Color,
      closeIconSize: 25,
      dateOrder: DatePickerDateOrder.dmy,
      pickerTextStyle: TextStyle(
        color: ThemeProvider.of().primaryT10Color,
        fontFamily: ThemeProvider.of().fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      onSubmit: (date) {
        currentState.setValue(date);
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    );

    return bottomPicker.show(context);
  }
}