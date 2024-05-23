import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_car_expenses/domain/use_cases/creating_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/structure/get_structure_use_case.dart';
import 'package:my_car_expenses/presentation/bloc/screens/create_screen/create_state.dart';
import 'package:my_car_expenses/presentation/screens/create_screen.dart';
import 'package:my_car_expenses/presentation/widgets/fields/date_picker_field_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/dropdown_button_field_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/search_text_field_form_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/text_field_widget.dart';

class CreateCubit extends Cubit<CreateState> {
  final GetStructureUseCase getStructureUseCase;
  final CreatingUseCase creatingUseCase;

  CreateCubit({required this.getStructureUseCase, required this.creatingUseCase}) : super(CreateLoadingState());

  Map<String, Widget> fields = {};

  void loadStructure() {
    List<BaseStructureItem> structure = getStructureUseCase.invoke();

    Future.delayed(const Duration(milliseconds: 500), () {
      emit(CreateLoadedState(structure: structure));
    });
  }

  void addField(String name, Widget field) {
    var currentState = state;

    if(currentState is CreateLoadedState) {
      fields[name] = field;
    }
  }

  void create() {
    creatingUseCase.invoke(_getValueFields());
  }

  Map<String, dynamic> _getValueFields() {
    var currentState = state;

    if(currentState is CreateLoadedState) {
      return fields.map((key, widget) {
        if (widget is CustomTextField) {
          return MapEntry(key, widget.value);
        }
        if (widget is SearchTextFieldForm) {
          return MapEntry(key, widget.value);
        }
        if (widget is CustomDropdownButtonField) {
          return MapEntry(key, widget.value);
        }
        if (widget is DatePickerField) {
          return MapEntry(key, widget.value);
        }
        return MapEntry(key, "");
      });
    }
    return {};
  }
/*
  void update() {
    var currentState = state;
    //fields['fuelType']
    if(currentState is CreateLoadedState) {
      emit(currentState);
    }
  }*/
}