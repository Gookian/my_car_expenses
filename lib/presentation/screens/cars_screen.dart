import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_car_expenses/presentation/bloc/screens/cars_screen/cars_cubit.dart';
import 'package:my_car_expenses/presentation/bloc/screens/cars_screen/cars_state.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';
import 'package:my_car_expenses/presentation/widgets/bottom_app_bar_widget.dart';

class CarsScreen extends StatelessWidget {
  const CarsScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ThemeProvider.of().primaryColor,
          leading: Container(
            margin: const EdgeInsets.only(left: 15),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => {
                Navigator.pop(context, true)
              },
              iconSize: 30,
            ),
          ),
          title: Text(
            "Автомобили",
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: ThemeProvider.of().fontFamily
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        backgroundColor: ThemeProvider.of().backgroundColor,
        body: BlocBuilder<CarsCubit, CarsState>(
          builder: (context, state) {
            if (state is CarsEmptyState) {
              return Center(
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
                      "Нет доступных автомобилей",
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
              );
            }
            if (state is CarsLoadingState) {
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
            if (state is CarsLoadedState) {
              return ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: state.cars.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 16);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var item = state.cars[index];
                    return Stack(
                      children: [
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius + 10),
                            image: const DecorationImage(
                                image: ExactAssetImage('assets/images/car.jpg'),
                                fit: BoxFit.cover
                            ),
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                                  color: const Color(0x99282828),
                                )
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          height: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${item.model} ${item.make} ${item.yearOfIssue}",
                                      style: TextStyle(
                                          color: ThemeProvider.of().backgroundColor,
                                          fontFamily: ThemeProvider.of().fontFamily,
                                          fontSize: 20
                                      ),
                                    ),
                                    Text(
                                      "P989AC70",
                                      style: TextStyle(
                                          color: ThemeProvider.of().backgroundT80Color,
                                          fontFamily: ThemeProvider.of().fontFamily,
                                          fontSize: 18
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Начальный пробег:",
                                                        style: TextStyle(
                                                            color: ThemeProvider.of().backgroundColor,
                                                            fontFamily: ThemeProvider.of().fontFamily,
                                                            fontSize: 18
                                                        ),
                                                      ),
                                                      Text(
                                                        "${item.startMileage} км",
                                                        style: TextStyle(
                                                            color: ThemeProvider.of().backgroundT80Color,
                                                            fontFamily: ThemeProvider.of().fontFamily,
                                                            fontSize: 16
                                                        ),
                                                      )
                                                    ],
                                                  )
                                              ),
                                              SizedBox(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Текуший пробег:",
                                                        style: TextStyle(
                                                            color: ThemeProvider.of().backgroundColor,
                                                            fontFamily: ThemeProvider.of().fontFamily,
                                                            fontSize: 18
                                                        ),
                                                      ),
                                                      Text(
                                                        item.currentMileage > 0 ? "${item.currentMileage} км" : "${item.startMileage} км",
                                                        style: TextStyle(
                                                            color: ThemeProvider.of().backgroundT80Color,
                                                            fontFamily: ThemeProvider.of().fontFamily,
                                                            fontSize: 16
                                                        ),
                                                      )
                                                    ],
                                                  )
                                              )
                                            ],
                                          )
                                      ),
                                      Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.only(left: 30),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Тип топлева:",
                                                          style: TextStyle(
                                                              color: ThemeProvider.of().backgroundColor,
                                                              fontFamily: ThemeProvider.of().fontFamily,
                                                              fontSize: 18
                                                          ),
                                                        ),
                                                        Text(
                                                          item.fuelType,
                                                          style: TextStyle(
                                                              color: ThemeProvider.of().backgroundT80Color,
                                                              fontFamily: ThemeProvider.of().fontFamily,
                                                              fontSize: 16
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                ),
                                                SizedBox(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Расход топлива:",
                                                          style: TextStyle(
                                                              color: ThemeProvider.of().backgroundColor,
                                                              fontFamily: ThemeProvider.of().fontFamily,
                                                              fontSize: 18
                                                          ),
                                                        ),
                                                        Text(
                                                          item.fuelConsumption != null ? "${item.fuelConsumption} л на 100 км" : "мало данных",
                                                          style: TextStyle(
                                                              color: ThemeProvider.of().backgroundT80Color,
                                                              fontFamily: ThemeProvider.of().fontFamily,
                                                              fontSize: 16
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                )
                                              ],
                                            ),
                                          )
                                      )
                                    ],
                                  )
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
              );
            }
            return Container();
          }
        ),
        bottomNavigationBar: const CustomBottomAppBar()
    );
  }
}