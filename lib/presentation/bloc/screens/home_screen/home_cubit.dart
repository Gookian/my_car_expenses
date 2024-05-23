import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_car_expenses/domain/entities/car.dart';
import 'package:my_car_expenses/domain/entities/category_data.dart';
import 'package:my_car_expenses/domain/use_cases/car/get/get_all_car_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/car/get/get_car_use_case.dart';
import 'package:my_car_expenses/domain/use_cases/get_category/get_category_data_on_month_use_case.dart';
import 'package:my_car_expenses/presentation/bloc/screens/home_screen/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoryDataOnMonthUseCase getCategoryDataOnMonthUseCase;
  final GetAllCarUseCase getAllCarUseCase;
  final GetCarUseCase getCarUseCase;

  HomeCubit({
    required this.getCategoryDataOnMonthUseCase,
    required this.getAllCarUseCase,
    required this.getCarUseCase
  }) : super(HomeLoadingState());

  @override
  void onChange(Change<HomeState> change) {
    super.onChange(change);

    if (change.nextState is HomeLoadedState) {
      if (!(change.nextState as HomeLoadedState).isVisibleWidget) {
        _visibleWidget(change.nextState as HomeLoadedState);
      }
    }
  }

  void checkIfCarsExist() async { // loading car
    List<Car> cars = await getAllCarUseCase.invoke();

    if (cars.isNotEmpty) {
      var car = await getCarUseCase.invoke(1);
      Future.delayed(const Duration(milliseconds: 500), () {
        emit(HomeLoadedState(currentIndex: 0, isVisibleWidget: false, currentCarId: 1, car: car, cars: cars, dateTime: DateTime.now()));
        _loadCategoryDate();
      });
    } else {
      emit(HomeEmptyState());
    }
  }

  void _loadCategoryDate() async {
    var currentState = state;

    if (currentState is HomeLoadedState) {
      List<CategoryData> categoryData = await getCategoryDataOnMonthUseCase.invoke(currentState.dateTime, currentState.currentCarId);
      emit(currentState.copyWith(categoryData: categoryData));
    }
  }

  List<String> getNames() {
    var currentState = state;

    if (currentState is HomeLoadedState) {
      return currentState.categoryData
        ?.asMap()
        .map<int, String>((index, data) {
          return MapEntry(index, data.name);
        })
        .values
        .toList() ?? [];
    }
    return [];
  }

  void setCurrentIndex(int currentIndex) {
    if (state is HomeLoadedState) {
      var currentState = (state as HomeLoadedState);

      emit(currentState.copyWith(currentIndex: currentIndex));
    }
  }

  Future<void> setCurrentCarId(int carId) async {
    var currentState = state;
    if (currentState is HomeLoadedState) {
      var car = await getCarUseCase.invoke(carId);

      emit(currentState.copyWith(currentCarId: carId, car: car));
      _loadCategoryDate();
    }
  }

  void setDateTime(DateTime dateTime) {
    var currentState = state;

    if (currentState is HomeLoadedState) {
      emit(currentState.copyWith(dateTime: dateTime));
      _loadCategoryDate();
    }
  }

  Future<List<Car>> getCar() async {
    return await getAllCarUseCase.invoke();
  }

  void _visibleWidget(HomeLoadedState currentState) {
    Future.delayed(const Duration(milliseconds: 100), () {
      emit(currentState.copyWith(isVisibleWidget: true));
    });
  }

  bool? isVisibleWidget() {
    if (state is HomeLoadedState) {
      var currentState = (state as HomeLoadedState);

      return currentState.isVisibleWidget;
    }
    return null;
  }

  void update() {
    emit(HomeLoadingState());
    checkIfCarsExist();
  }
}