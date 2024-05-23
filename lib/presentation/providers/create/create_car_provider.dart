import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_car_expenses/presentation/bloc/screens/create_car_screen/create_car_cubit.dart';
import 'package:my_car_expenses/presentation/screens/create_car_screen.dart';

class CreateCarProvider extends StatelessWidget {
  const CreateCarProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateCarCubit>(
      create: (context) => GetIt.instance<CreateCarCubit>()..initialize(),
      child: CreateCarScreen()
    );
  }
}
