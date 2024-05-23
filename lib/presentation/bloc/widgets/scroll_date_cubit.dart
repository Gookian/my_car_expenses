import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollDateCubit extends Cubit<DateTime> {
  ScrollDateCubit() : super(DateTime.now());

  void setValue(DateTime value) {
    emit(value);
  }
}