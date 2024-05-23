import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/screens/home_screen/home_cubit.dart';
import '../screens/home_screen.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => GetIt.instance<HomeCubit>()..checkIfCarsExist(),
      child: HomeScreen(),
    );
  }
}
