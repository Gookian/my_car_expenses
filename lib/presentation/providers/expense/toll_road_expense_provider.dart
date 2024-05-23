import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_car_expenses/domain/entities/category_type.dart';
import 'package:my_car_expenses/presentation/bloc/screens/base_expense_screen/base_expense_cubit.dart';
import 'package:my_car_expenses/presentation/screens/base_expense_screen.dart';
import 'package:my_car_expenses/until/svg_icons.dart';

class TollRoadExpenseProvider extends StatelessWidget {
  final int carId;

  const TollRoadExpenseProvider({
    super.key,
    required this.carId
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BaseExpenseCubit>(
      create: (context) => GetIt.instance<BaseExpenseCubit>(param1: CategoryType.tollRoadExpense)..loadExpense(carId),
      child: BaseExpenseScreen(
        title: 'Платка',
        emptyDescription: 'Для данного автомобиля\n пока что нет затрат на платную дорогу',
        buttonTitle: 'Добавить затраты на платную дорогу',
        svgIconAsset: SvgIcons.tollRoad,
        category: CategoryType.tollRoadExpense,
      ),
    );
  }
}
