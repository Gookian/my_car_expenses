import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_car_expenses/domain/entities/category_type.dart';
import 'package:my_car_expenses/presentation/bloc/screens/base_expense_screen/base_expense_cubit.dart';
import 'package:my_car_expenses/presentation/bloc/screens/cars_screen/cars_cubit.dart';
import 'package:my_car_expenses/presentation/screens/base_expense_screen.dart';
import 'package:my_car_expenses/presentation/screens/cars_screen.dart';
import 'package:my_car_expenses/presentation/screens/notification_screen.dart';
import 'package:my_car_expenses/until/svg_icons.dart';

class NotificationProvider extends StatelessWidget {
  const NotificationProvider({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarsCubit>(
      create: (context) => GetIt.instance<CarsCubit>()..loadCars(),
      child: const NotificationScreen(),
    );
  }
}