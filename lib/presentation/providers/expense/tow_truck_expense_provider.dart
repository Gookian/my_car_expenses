import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_car_expenses/domain/entities/category_type.dart';
import 'package:my_car_expenses/presentation/bloc/screens/base_expense_screen/base_expense_cubit.dart';
import 'package:my_car_expenses/presentation/screens/base_expense_screen.dart';
import 'package:my_car_expenses/until/svg_icons.dart';

class TowTruckExpenseProvider extends StatelessWidget {
  final int carId;

  const TowTruckExpenseProvider({
    super.key,
    required this.carId
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BaseExpenseCubit>(
      create: (context) => GetIt.instance<BaseExpenseCubit>(param1: CategoryType.towTruckExpense)..loadExpense(carId),
      child: BaseExpenseScreen(
        title: 'Эвакуатор',
        emptyDescription: 'Для данного автомобиля\n пока что нет затрат на эвакуатор',
        buttonTitle: 'Добавить затраты на эвакуатор',
        svgIconAsset: SvgIcons.towTruck,
        category: CategoryType.towTruckExpense,
      ),
    );
  }
}
