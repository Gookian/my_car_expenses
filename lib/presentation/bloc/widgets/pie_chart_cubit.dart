import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/category_data.dart';

class PieChartCubit extends Cubit<PieChartState> {
  PieChartCubit(touchIndex, categories) : super(PieChartState(touchIndex: touchIndex, categories: categories));

  void setTouchIndex(int value) {
    emit(PieChartState(touchIndex: value, categories: state.categories));
  }
  void setCategories(List<CategoryData> values) {
    emit(PieChartState(touchIndex: state.touchIndex,  categories: values));
  }
}

class PieChartState {
  final int touchIndex;
  final List<CategoryData> categories;

  PieChartState({required this.touchIndex, required this.categories});
}