import 'package:my_car_expenses/domain/entities/car.dart';
import 'package:my_car_expenses/domain/entities/category_data.dart';

abstract class HomeState {}

class HomeEmptyState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final int currentIndex;
  final bool isVisibleWidget;
  final int currentCarId;
  final Car car;
  final List<Car> cars;
  final DateTime dateTime;
  final List<CategoryData>? categoryData;

  HomeLoadedState({
    required this.currentIndex,
    required this.isVisibleWidget,
    required this.currentCarId,
    required this.car,
    required this.cars,
    required this.dateTime,
    this.categoryData
  });

  HomeLoadedState copyWith({int? currentIndex, bool? isVisibleWidget, int? currentCarId, Car? car, List<Car>? cars, DateTime? dateTime, List<CategoryData>? categoryData}) =>
      HomeLoadedState(
          currentIndex: currentIndex ?? this.currentIndex,
          isVisibleWidget: isVisibleWidget ?? this.isVisibleWidget,
          currentCarId: currentCarId ?? this.currentCarId,
          car: car ?? this.car,
          cars: cars ?? this.cars,
          dateTime: dateTime ?? this.dateTime,
          categoryData: categoryData ?? this.categoryData
      );
}

class HomeErrorState extends HomeState {}