import 'package:my_car_expenses/presentation/screens/create_screen.dart';

abstract class CreateState {}

class CreateLoadingState extends CreateState {}

class CreateLoadedState extends CreateState {
  final List<BaseStructureItem> structure;

  CreateLoadedState({required this.structure});
}

class CreateErrorState extends CreateState {}