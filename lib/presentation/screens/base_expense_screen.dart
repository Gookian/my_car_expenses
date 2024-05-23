import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:my_car_expenses/domain/entities/category_type.dart';
import 'package:my_car_expenses/presentation/bloc/screens/base_expense_screen/base_expense_cubit.dart';
import 'package:my_car_expenses/presentation/bloc/screens/base_expense_screen/base_expense_state.dart';
import 'package:my_car_expenses/presentation/providers/create/create_fuel_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/create/create_other_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/create/create_parking_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/create/create_repair_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/create/create_service_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/create/create_toll_road_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/create/create_tow_truck_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/create/create_tuning_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/create/create_wash_expense_provider.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';
import 'package:my_car_expenses/presentation/widgets/buttons/icon_text_button_widget.dart';
import 'package:my_car_expenses/presentation/widgets/buttons/outlined_button_widget.dart';
import 'package:my_car_expenses/until/svg_icons.dart';

class BaseExpenseScreen extends StatelessWidget {
  final String title;
  final String emptyDescription;
  final String buttonTitle;
  final String svgIconAsset;
  final CategoryType category;

  BaseExpenseScreen({
    super.key,
    required this.title,
    required this.emptyDescription,
    required this.buttonTitle,
    required this.svgIconAsset,
    required this.category
  });

  final DateFormat formatter = DateFormat('dd.MM.yyyy - HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ThemeProvider.of().primaryColor,
          leading: BlocBuilder<BaseExpenseCubit, BaseExpenseState>(
            builder: (context, state) {
              if (state is BaseExpenseLoadedState || state is BaseExpenseEmptyState) {
                int idCar = 0;
                if (state is BaseExpenseLoadedState) idCar = state.currentCarId;
                if (state is BaseExpenseEmptyState) idCar = state.currentCarId;
                return Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => {
                      Navigator.pop(context, idCar)
                    },
                    iconSize: 30,
                  ),
                );
              }
              return Container();
            }
          ),
          title: BlocBuilder<BaseExpenseCubit, BaseExpenseState>(
            builder: (context, state) {
              if (state is BaseExpenseLoadedState || state is BaseExpenseEmptyState) {
                String carName = "";
                if (state is BaseExpenseLoadedState) carName = "${state.car.model} ${state.car.make} ${state.car.yearOfIssue}";
                if (state is BaseExpenseEmptyState) carName = "${state.car.model} ${state.car.make} ${state.car.yearOfIssue}";
                return Text(
                  "$title - $carName",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: ThemeProvider.of().fontFamily
                  ),
                );
              }
              return Text(
                title,
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: ThemeProvider.of().fontFamily
                ),
              );
            }
          ),
          actions: [
            BlocBuilder<BaseExpenseCubit, BaseExpenseState>(
                builder: (context, state) {
                  var homeCubit = BlocProvider.of<BaseExpenseCubit>(context);
                  if (state is BaseExpenseLoadedState || state is BaseExpenseEmptyState) {
                    return Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: IconButton(
                          icon: SvgPicture.asset(
                            SvgIcons.car,
                            colorFilter: ColorFilter.mode(ThemeProvider.of().backgroundColor, BlendMode.srcIn),
                            width: 30,
                            height: 30,
                          ),
                          onPressed: () => {
                            homeCubit.getCar().then((cars) => {
                              showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  ),
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 350,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(20),
                                          itemCount: cars.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return IconTextButton(
                                                onPressed: () => {
                                                  homeCubit.setCurrentCarId(cars[index].id),
                                                  Navigator.pop(context, true)
                                                },
                                                icon: SvgPicture.asset(
                                                  SvgIcons.car,
                                                  colorFilter: ColorFilter.mode(ThemeProvider.of().primaryColor, BlendMode.srcIn),
                                                  width: 40,
                                                  height: 40,
                                                ),
                                                text: "${cars[index].model} ${cars[index].make} ${cars[index].yearOfIssue}"
                                            );
                                          }
                                      ),
                                    );
                                  }
                              )
                            })
                          }
                      ),
                    );
                  }
                  return Container();
                }
            )
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        backgroundColor: ThemeProvider.of().backgroundColor,
        body: BlocBuilder<BaseExpenseCubit, BaseExpenseState>(
          builder: (context, state) {
            if (state is BaseExpenseEmptyState) {
              return Column(
                children: [
                  Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/empty_box.png",
                              width: 300,
                              height: 300,
                            ),
                            const SizedBox(height: 30),
                            Text(
                              emptyDescription,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ThemeProvider.of().primaryT10Color,
                                  fontFamily: ThemeProvider.of().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: CustomOutlinedButton(
                        onPressed: () => {
                          _openCreateScreen(context, state)
                        },
                        child: Text(buttonTitle)
                    ),
                  )
                ],
              );
            }
            if (state is BaseExpenseLoadingState) {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: ThemeProvider.of().accentColor,
                        strokeAlign: 5,
                        strokeWidth: 5,
                        strokeCap: StrokeCap.round,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "Загрузка",
                        style: TextStyle(
                            color: ThemeProvider.of().primaryT10Color,
                            fontFamily: ThemeProvider.of().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      )
                    ],
                  )
              );
            }
            if (state is BaseExpenseLoadedState) {
              return Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                          padding: const EdgeInsets.all(20),
                          itemCount: state.expenses.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 16);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            var item = state.expenses[index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: SvgPicture.asset(
                                        svgIconAsset,
                                        colorFilter: ColorFilter.mode(ThemeProvider.of().primaryColor, BlendMode.srcIn),
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                        item.name,
                                                        style: TextStyle(
                                                            color: ThemeProvider.of().primaryT10Color,
                                                            fontFamily: ThemeProvider.of().fontFamily,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20
                                                        )
                                                    ),
                                                    Text(
                                                        "${item.sumExpense} руб",
                                                        style: TextStyle(
                                                            color: ThemeProvider.of().errorT50Color,
                                                            fontFamily: ThemeProvider.of().fontFamily,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20
                                                        )
                                                    )
                                                  ]
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                  "Дата заправки: ${formatter.format(item.date)}",
                                                  style: TextStyle(
                                                      color: ThemeProvider.of().foregroundT30Color,
                                                      fontFamily: ThemeProvider.of().fontFamily,
                                                      fontSize: 18
                                                  )
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                  "Пробег: ${item.currentMileage} км",
                                                  style: TextStyle(
                                                      color: ThemeProvider.of().foregroundT30Color,
                                                      fontFamily: ThemeProvider.of().fontFamily,
                                                      fontSize: 18
                                                  )
                                              )
                                            ]
                                        )
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  height: ThemeProvider.of().borderWidth,
                                  decoration: BoxDecoration(
                                    color: ThemeProvider.of().primaryT80Color,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(ThemeProvider.of().borderRadius)),
                                  ),
                                )
                              ],
                            );
                          }
                      )
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: CustomOutlinedButton(
                        onPressed: () => {
                          _openCreateScreen(context, state)
                        },
                        child: Text(buttonTitle)
                    ),
                  )
                ],
              );
            }
            return Container();
          }
        )
    );
  }

  void _openCreateScreen(BuildContext context, BaseExpenseState state) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        switch (category) {
          case CategoryType.fuelExpense:
            return CreateFuelExpenseProvider(carId: state.currentCarId);
          case CategoryType.washExpense:
            return CreateWashExpenseProvider(carId: state.currentCarId);
          case CategoryType.consumableExpense:
            // TODO добавть как бедет готов экран
          case CategoryType.repairExpense:
            return CreateRepairExpenseProvider(carId: state.currentCarId);
          case CategoryType.towTruckExpense:
            return CreateTowTruckExpenseProvider(carId: state.currentCarId);
          case CategoryType.serviceExpense:
            return CreateServiceExpenseProvider(carId: state.currentCarId);
          case CategoryType.tuningExpense:
            return CreateTuningExpenseProvider(carId: state.currentCarId);
          case CategoryType.parkingExpense:
            return CreateParkingExpenseProvider(carId: state.currentCarId);
          case CategoryType.tollRoadExpense:
            return CreateTollRoadExpenseProvider(carId: state.currentCarId);
          case CategoryType.otherExpense:
            return CreateOtherExpenseProvider(carId: state.currentCarId);
        }
      },
    )).then((value) => BlocProvider.of<BaseExpenseCubit>(context).update(state.currentCarId));
  }
}