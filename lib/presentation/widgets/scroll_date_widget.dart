import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_car_expenses/presentation/bloc/widgets/scroll_date_cubit.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';

class ScrollDate extends StatelessWidget {
  final void Function(DateTime) onChange;

  final Map<int, String> month = {
    1: "Январь",
    2: "Февраль",
    3: "Март",
    4: "Апрель",
    5: "Май",
    6: "Июнь",
    7: "Июль",
    8: "Август",
    9: "Сентябрь",
    10: "Октябрь",
    11: "Ноябрь",
    12: "Декабрь",
  };

  ScrollDate({
    super.key,
    required this.onChange
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScrollDateCubit>(
        create: (context) => ScrollDateCubit(),
        child: BlocBuilder<ScrollDateCubit, DateTime>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new, color: ThemeProvider.of().accentColor,
                        size: 30,
                      ),
                      onPressed: () =>
                      {
                        BlocProvider.of<ScrollDateCubit>(context).setValue(DateTime(state.year, state.month - 1, state.day)),
                        onChange(DateTime(state.year, state.month - 1, state.day))
                      }
                  ),
                  Text(
                      "${month[state.month]} - ${state.year}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: ThemeProvider.of().primaryT10Color,
                          fontFamily: ThemeProvider.of().fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      )
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios, color: ThemeProvider.of().accentColor,
                        size: 30,
                      ),
                      onPressed: () =>
                      {
                        BlocProvider.of<ScrollDateCubit>(context).setValue(DateTime(state.year, state.month + 1, state.day)),
                        onChange(DateTime(state.year, state.month + 1, state.day))
                      }
                  )
                ],
              );
            }
        )
    );
  }
}