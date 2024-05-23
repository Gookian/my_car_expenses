import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:my_car_expenses/domain/converters/document_converter.dart';
import 'package:my_car_expenses/domain/entities/document.dart';
import 'package:my_car_expenses/domain/entities/document_type.dart';
import 'package:my_car_expenses/domain/repositories/documents_repository.dart';
import 'package:my_car_expenses/domain/use_cases/creating_use_case.dart';

class VehiclePassportCreationUseCaseImpl implements CreatingUseCase {
  final DocumentRepository repository;
  final DocumentConverter converter;
  final int carId;

  final DocumentType type = DocumentType.vehiclePassport;

  VehiclePassportCreationUseCaseImpl({
    required this.repository,
    required this.converter,
    required this.carId
  });

  @override
  void invoke(Map<String, dynamic> map) {
    Map<String, dynamic> additionalField = {
      'model': map['model'] ?? '',
      'make': map['make'] ?? '',
      'yearOfIssue': map['yearOfIssue'] ?? '',
      'registrationNumber': map['registrationNumber'] ?? '',
      'VIN': map['VIN'] ?? '',
      'typeVehicle': map['typeVehicle'] ?? '',
      'color': map['color'] ?? ''
    };
    Map<String, dynamic> mainMap = {
      'type': type,
      'series': int.tryParse(map['series']!) ?? 0,
      'number': int.tryParse(map['number']!) ?? 0,
      'dateOfIssue': (map['dateOfIssue'] as DateTime).toString(),
      'additionalFields': jsonEncode(additionalField)
    };
    var documentModel = converter.toDocumentModel(Document.fromMap(mainMap), carId);

    repository.add(documentModel);
  }
}