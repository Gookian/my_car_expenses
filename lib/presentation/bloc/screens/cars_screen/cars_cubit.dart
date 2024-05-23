import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_car_expenses/domain/converters/car_make_converter.dart';
import 'package:my_car_expenses/domain/converters/car_model_converter.dart';
import 'package:my_car_expenses/domain/entities/automobile.dart';
import 'package:my_car_expenses/domain/entities/car.dart';
import 'package:my_car_expenses/domain/entities/car_make.dart';
import 'package:my_car_expenses/domain/use_cases/car/get/get_all_car_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/creating_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_makes_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_model_id_by_name_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/vehicle_info/get_models_use_case.dart';
import 'package:my_car_expenses/presentation/bloc/screens/cars_screen/cars_state.dart';
import 'package:my_car_expenses/presentation/bloc/screens/create_car_screen/create_car_state.dart';

class CarsCubit extends Cubit<CarsState> {
  final GetAllCarUseCase useCase;

  CarsCubit({
    required this.useCase
  }) : super(CarsLoadingState());

  Map<String, Widget> fields = {};

  Future<void> loadCars() async {
    List<Car> cars = await useCase.invoke();

    Future.delayed(const Duration(milliseconds: 500), () {
      if (cars.isNotEmpty) {
        emit(CarsLoadedState(cars: cars));
      } else {
        emit(CarsEmptyState());
      }
    });
  }
}