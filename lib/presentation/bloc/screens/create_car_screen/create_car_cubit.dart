import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_car_expenses/domain/converters/car_make_converter.dart';
import 'package:my_car_expenses/domain/converters/car_model_converter.dart';
import 'package:my_car_expenses/domain/entities/automobile.dart';
import 'package:my_car_expenses/domain/entities/car_make.dart';
import 'package:my_car_expenses/domain/use_cases/creating_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_makes_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_model_id_by_name_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_models_use_case.dart';
import 'package:my_car_expenses/presentation/bloc/screens/create_car_screen/create_car_state.dart';

class CreateCarCubit extends Cubit<CreateCarState> {
  final GetModelsUseCase getModelsUseCase;
  final GetMakesUseCase getMakesUseCase;
  final CreatingUseCase creatingUseCase;
  final GetModelIdByNameUseCase getModelIdByNameUseCase;

  final CarModelConverter carModelConverter;
  final CarMakeConverter carMakesConverter;

  CreateCarCubit({
    required this.getModelsUseCase,
    required this.getMakesUseCase,
    required this.creatingUseCase,
    required this.getModelIdByNameUseCase,
    required this.carModelConverter,
    required this.carMakesConverter
  }) : super(CreateCarLoadingState());

  Map<String, Widget> fields = {};

  void initialize() {
    List<Automobile> models = carModelConverter.toAutomobiles(getModelsUseCase.invoke());
    List<CarMake> makes = carMakesConverter.toCarMakes(getMakesUseCase.invoke());

    Future.delayed(const Duration(milliseconds: 500), () {
      emit(CreateCarLoadedState(models: models, makes: makes));
    });
  }

  void create(String name, String yearOfIssue, String millage) {
    var currentState = state;

    if (currentState is CreateCarLoadedState) {
      var map = {
        'model': currentState.modelField.currentState?.controller.text,
        'make': currentState.makeField.currentState?.controller.text,
        'fuelType': currentState.fuelField.currentState?.value,
        'name': name,
        'yearOfIssue': yearOfIssue,
        'startMileage': millage
      };
      creatingUseCase.invoke(map);
    }
  }
  
  void selectModel(String model) {
    var currentState = state;
    
    if (currentState is CreateCarLoadedState) {
      int carModelId = getModelIdByNameUseCase.invoke(model);
      List<CarMake> makes = carMakesConverter.toCarMakes(getMakesUseCase.invoke());
      List<CarMake> makesByModel = makes.where((element) => element.carModelId == carModelId).toList();

      currentState.makeField.currentState?.currentSearchItems = makesByModel.map((e) => e.name).toList();
      if (currentState.makeField.currentState!.controller.text.isNotEmpty) {
        currentState.makeField.currentState?.controller.text = "";
      }
      currentState.modelField.currentState?.controller.text = model;
    }
  }

  void selectMake(String make) {
    var currentState = state;

    if (currentState is CreateCarLoadedState) {
      /*CarMake carMake = currentState.makes.firstWhere((element) => element.name == make);
      List<Automobile> models = carModelConverter.toAutomobiles(getModelsUseCase.invoke());
      Automobile modelByMake = models.firstWhere((element) => element.id == carMake.carModelId);

      currentState.modelField.currentState?.controller.text = modelByMake.name;
      currentState.makeField.currentState?.controller.text = make;*/
    }
  }
}