import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_car_expenses/presentation/bloc/widgets/pie_chart_cubit.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';

import '../../domain/entities/category_data.dart';


class CustomPieChart extends StatelessWidget {
  const CustomPieChart({
    super.key,
    required this.categories,
    required this.touchIndex,
    this.callbackTouch
  });

  final List<CategoryData> categories;
  final int touchIndex;
  final void Function(int)? callbackTouch;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PieChartCubit>(
        create: (context) => PieChartCubit(touchIndex, categories),
        child: BlocBuilder<PieChartCubit, PieChartState>(
            builder: (context, state) {
              int index = -1;
              BlocProvider.of<PieChartCubit>(context).setTouchIndex(touchIndex);
              BlocProvider.of<PieChartCubit>(context).setCategories(categories);

              return Stack(
                alignment: Alignment.center,
                children: [
                  Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${getAllSum(state.categories).toStringAsFixed(0)} руб.",
                        style: TextStyle(
                            color: ThemeProvider.of().primaryT10Color,
                            fontFamily: ThemeProvider.of().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                      Text(
                        "Общие\nзатраты",
                        style: TextStyle(
                            color: ThemeProvider.of().foregroundT30Color,
                            fontFamily: ThemeProvider.of().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 12
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  PieChart(
                        PieChartData(
                            pieTouchData: PieTouchData(
                              enabled: true,
                              longPressDuration: const Duration(minutes: 1500),
                              touchCallback: (event, pieTouchResponse) => {
                                if (pieTouchResponse != null) {
                                  if (pieTouchResponse.touchedSection!.touchedSectionIndex != -1) {
                                    index = -1,
                                    for (int i = 0; i < state.categories.length; i++) {
                                      if (state.categories[i].sum != 0) {
                                        index++,
                                        if (pieTouchResponse.touchedSection!.touchedSectionIndex == index) {
                                          BlocProvider.of<PieChartCubit>(context).setTouchIndex(i),
                                          if (callbackTouch != null) {
                                            callbackTouch!(i)
                                          }
                                        }
                                      }
                                    }
                                  } else {
                                    BlocProvider.of<PieChartCubit>(context).setTouchIndex(state.touchIndex)
                                  }
                                }
                              }
                            ),
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 5,
                            centerSpaceRadius: 60,
                            sections: getSections(state.touchIndex, state.categories)
                        ),
                        swapAnimationDuration: const Duration(microseconds: 750),
                        swapAnimationCurve: Curves.easeInOutQuint,
                      )
                ],
              );
            }
        )
    );
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      fontFamily: ThemeProvider.of().fontFamily,
      color: Colors.white
    );
  }

  List<PieChartSectionData> getSections(int touchIndex, List<CategoryData> categories) => categories
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        bool isTouched = touchIndex == index;
        double radius = isTouched ? 60 : 50;

        final value = PieChartSectionData(
            value: data.sum,
            color: data.color,
            title: "${((data.sum / getAllSum(categories)) * 100).toStringAsFixed(1)}%",
            radius: radius,
            titleStyle: _getTextStyle()
        );

        return MapEntry(index, value);
      })
      .values
      .toList();

  double getAllSum(List<CategoryData> categories) {
    double sum = 0;
    for (var element in categories) {
      sum += element.sum;
    }
    return sum;
  }
}