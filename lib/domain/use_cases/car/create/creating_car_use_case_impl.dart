import 'package:flutter/cupertino.dart';
import 'package:my_car_expenses/domain/converters/car_converter.dart';
import 'package:my_car_expenses/domain/entities/car.dart';
import 'package:my_car_expenses/domain/repositories/car_repository.dart';
import 'package:my_car_expenses/domain/use_cases/creating_use_case.dart';

class CreatingCarUseCaseImpl implements CreatingUseCase {
  final CarRepository repository;
  final CarConverter converter;

  CreatingCarUseCaseImpl({
    required this.repository,
    required this.converter
  });

  @override
  void invoke(Map<String, dynamic> map) {
    var model = converter.toModel(Car.fromMap(map));
    repository.add(model).then((code) => {
      if (code == -1) {
        throw CreateException("Не удалось создать машину!")
      }
    });
  }
}

class CreateException implements Exception {
  String message = "Не удалось создать";
  CreateException(this.message);
}