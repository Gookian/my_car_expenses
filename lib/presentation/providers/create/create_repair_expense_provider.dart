import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_car_expenses/domain/entities/category_type.dart';
import 'package:my_car_expenses/presentation/enum/create_cubit_type.dart';
import 'package:my_car_expenses/presentation/bloc/screens/create_screen/create_cubit.dart';
import 'package:my_car_expenses/presentation/screens/create_screen.dart';

class CreateRepairExpenseProvider extends StatelessWidget {
  final int? carId;

  const CreateRepairExpenseProvider({
    super.key,
    required this.carId
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateCubit>(
      create: (context) => GetIt.instance<CreateCubit>(param1: CreateCubitType.repairExpense, param2: carId)..loadStructure(),
      child: CreateScreen(title: "Добавление затрат на ремонт", behaviorScreen: BehaviorScreen.create),
    );
  }
}
