import 'package:flutter_bloc/flutter_bloc.dart';

class DatePickerFieldCubit extends Cubit<DateTime?> {
  DatePickerFieldCubit(DateTime? date) : super(date);

  void setValue(DateTime? value) {
    emit(value);
  }
}