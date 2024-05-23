import 'package:flutter/material.dart';
import 'package:my_car_expenses/domain/entities/automobile.dart';
import 'package:my_car_expenses/domain/entities/car_make.dart';
import 'package:my_car_expenses/presentation/widgets/fields/dropdown_button_field_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/search_text_field_form_widget.dart';

abstract class CreateCarState {}

class CreateCarLoadingState extends CreateCarState {}

class CreateCarLoadedState extends CreateCarState {
  final List<Automobile> models;
  final List<CarMake> makes;
  final String? selectModel;
  final String? selectMake;

  final modelField = GlobalKey<SearchTextFieldFormState>();
  final makeField = GlobalKey<SearchTextFieldFormState>();
  final fuelField = GlobalKey<CustomDropdownButtonFieldState>();

  CreateCarLoadedState({
    required this.models,
    required this.makes,
    this.selectModel,
    this.selectMake
  });

  CreateCarLoadedState copyWith({List<Automobile>? models, List<CarMake>? makes, String? selectModel, String? selectMake}) => CreateCarLoadedState(
      models: models ?? this.models,
      makes: makes ?? this.makes,
      selectModel: selectModel ?? this.selectModel,
      selectMake: selectMake ?? this.selectMake
  );
}