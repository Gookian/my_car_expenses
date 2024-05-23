import 'package:flutter_bloc/flutter_bloc.dart';

import 'hint_state.dart';

class HintCubit extends Cubit<HintState> {
  HintCubit() : super(CountState(count: 0));

  void increment() {
    if (state is CountState) {
      emit(CountState(count: (state as CountState).count + 1));
    }
  }
}