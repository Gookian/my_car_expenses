import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_car_expenses/domain/entities/car.dart';
import 'package:my_car_expenses/domain/entities/car_documents.dart';
import 'package:my_car_expenses/domain/use_cases/car/get/get_all_car_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/documents/get_documents_by_car_id_use_case.dart';
import 'package:my_car_expenses/presentation/bloc/screens/document_screen/document_state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  final GetAllCarUseCase getAllCarUseCase;
  final GetDocumentsByCarIdUseCase getDocumentsByCarIdUseCase;

  DocumentCubit({
    required this.getAllCarUseCase,
    required this.getDocumentsByCarIdUseCase
  }) : super(DocumentLoadingState());

  Map<String, Widget> fields = {};

  Future<void> loadCars() async {
    final cars = await getAllCarUseCase.invoke();
    
    final carDocumentsFuture = cars.map(_toCarDocuments).toList();
    final carDocuments = await Future.wait(carDocumentsFuture);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (carDocuments.isNotEmpty) {
        emit(DocumentLoadedState(carDocuments: carDocuments));
      } else {
        emit(DocumentEmptyState());
      }
    });
  }

  void update() {
    emit(DocumentLoadingState());
    loadCars();
  }
  
  Future<CarDocuments> _toCarDocuments(Car car) async {
    final documents = await getDocumentsByCarIdUseCase.invoke(car.id);
    return CarDocuments(
      carId: car.id,
      name: '${car.model} ${car.make} ${car.yearOfIssue}',
      documents: documents
    );
  }
}