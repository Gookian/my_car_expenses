import 'package:my_car_expenses/domain/entities/car_documents.dart';

abstract class DocumentState {}

class DocumentLoadingState extends DocumentState {}

class DocumentLoadedState extends DocumentState {
  final List<CarDocuments> carDocuments;

  DocumentLoadedState({
    required this.carDocuments
  });
}

class DocumentEmptyState extends DocumentState {}