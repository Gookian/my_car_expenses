import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/screens/hint_screen/hint_cubit.dart';
import '../screens/hint_screen.dart';

class HintProvider extends StatelessWidget {
  const HintProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HintCubit>(
      create: (context) => HintCubit(),
      child: HintScreen(),
    );
  }
}
