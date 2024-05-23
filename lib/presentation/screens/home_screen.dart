import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_car_expenses/domain/entities/category_type.dart';
import 'package:my_car_expenses/presentation/bloc/screens/home_screen/home_cubit.dart';
import 'package:my_car_expenses/presentation/providers/create/create_car_provider.dart';
import 'package:my_car_expenses/presentation/providers/expense/fuel_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/expense/other_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/expense/parking_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/expense/repair_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/expense/service_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/expense/toll_road_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/expense/tow_truck_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/expense/tuning_expense_provider.dart';
import 'package:my_car_expenses/presentation/providers/expense/wash_expense_provider.dart';
import 'package:my_car_expenses/presentation/screens/consumable_screen.dart';
import 'package:my_car_expenses/presentation/screens/menu_screen.dart';
import 'package:my_car_expenses/presentation/screens/stub_void_screen.dart';
import 'package:my_car_expenses/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:my_car_expenses/presentation/widgets/buttons/icon_text_button_widget.dart';
import 'package:my_car_expenses/presentation/widgets/pie_chart_widget.dart';
import 'package:my_car_expenses/presentation/widgets/scroll_date_widget.dart';
import 'package:my_car_expenses/presentation/widgets/buttons/text_and_icon_form_chip_button_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/dropdown_button_field_widget.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';
import 'package:my_car_expenses/presentation/bloc/screens/home_screen/home_state.dart';
import 'package:my_car_expenses/presentation/widgets/title_and_description_box_widget.dart';
import 'package:my_car_expenses/until/svg_icons.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _keyDropdownButton = GlobalKey<CustomDropdownButtonFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ThemeProvider.of().primaryColor,
          leading: Container(
            margin: const EdgeInsets.only(left: 15),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () =>
              {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const MenuScreen(),
                ))
              },
              iconSize: 30,
            ),
          ),
          title: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState || state is HomeEmptyState) {
                return Text(
                  'Главная',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: ThemeProvider.of().fontFamily
                  ),
                );
              }
              if (state is HomeLoadedState) {
                var car = state.cars.firstWhere((car) => car.id == state.currentCarId);
                return Text(
                  "${car.model} ${car.make} ${car.yearOfIssue}",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: ThemeProvider.of().fontFamily
                  ),
                );
              }
              return Container();
            }
          ),
          actions: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                var homeCubit = BlocProvider.of<HomeCubit>(context);
                if (state is HomeLoadedState) {
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
        body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeEmptyState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          "assets/images/wind.png",
                          width: 300,
                          height: 300,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "Нет ни одного доступного автомобиля.\nДля получения доступа к функционалу\nсоздайте авто кнопкой “+” ниже",
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
              if (state is HomeLoadingState) {
                return Stack(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                                    color: ThemeProvider.of().primaryT80Color,
                                  )
                              ),
                              SizedBox(
                                  height: 250,
                                  child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ThemeProvider.of().primaryT80Color,
                                              )
                                          ),
                                        ),
                                        Expanded(
                                            child: Column(
                                                children: [
                                                  Container(
                                                      height: 65,
                                                      margin: const EdgeInsets.only(top: 31, left: 30),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                                                        color: ThemeProvider.of().primaryT80Color,
                                                      )
                                                  ),
                                                  Container(
                                                      height: 30,
                                                      margin: const EdgeInsets.only(top: 16, left: 30),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                                                        color: ThemeProvider.of().primaryT80Color,
                                                      )
                                                  ),
                                                  Container(
                                                      height: 35,
                                                      margin: const EdgeInsets.only(top: 16, left: 30),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                                                        color: ThemeProvider.of().primaryT80Color,
                                                      )
                                                  ),
                                                  Container(
                                                      height: 18,
                                                      margin: const EdgeInsets.only(top: 16, left: 30),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                                                        color: ThemeProvider.of().primaryT80Color,
                                                      )
                                                  ),
                                                  const SizedBox(height: 10)
                                                ]
                                            )
                                        )
                                      ]
                                  )
                              ),
                              Container(
                                  height: 70,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                                margin: const EdgeInsets.only(right: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                                                  color: ThemeProvider.of().primaryT80Color,
                                                )
                                            )
                                        ),
                                        Expanded(
                                            child: Container(
                                                margin: const EdgeInsets.only(left: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                                                  color: ThemeProvider.of().primaryT80Color,
                                                )
                                            )
                                        )
                                      ]
                                  )
                              ),
                              Container(
                                  height: 150,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                              margin: const EdgeInsets.only(right: 5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                                                color: ThemeProvider.of().primaryT80Color,
                                              )
                                          )
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin: const EdgeInsets.only(left: 5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                                                color: ThemeProvider.of().primaryT80Color,
                                              )
                                          )
                                      )
                                    ],
                                  )
                              ),
                              Expanded(
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: GridView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: 8,
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10
                                            ),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                                                    color: ThemeProvider.of().primaryT80Color,
                                                  )
                                              );
                                            }
                                        ),
                                      ),
                                      IgnorePointer(
                                          ignoring: true,
                                          child: Container(
                                              margin: const EdgeInsets.only(bottom: 19.5),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [ThemeProvider.of().backgroundColor.withAlpha(0), ThemeProvider.of().backgroundColor],
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter
                                                  )
                                              )
                                          )
                                      )
                                    ],
                                  )
                              )
                            ]
                        )
                    ),
                    Center(
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
                    )
                  ]
                );
              }
              if (state is HomeLoadedState) {
                _keyDropdownButton.currentState?.value = state.categoryData != null ? BlocProvider.of<HomeCubit>(context).getNames()[state.currentIndex] : '';
                return AnimatedOpacity(
                  opacity: BlocProvider.of<HomeCubit>(context).isVisibleWidget() ?? false ? 1 : 0,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: ScrollDate(
                                onChange: (value) {
                                  BlocProvider.of<HomeCubit>(context).setDateTime(value);
                                },
                              ),
                            ),
                            SizedBox(
                                height: 250,
                                child: Row(
                                    children: [
                                      Expanded(
                                        child: (state.categoryData ?? []).any((element) => element.sum > 0) ? CustomPieChart(
                                          categories: state.categoryData ?? [],
                                          touchIndex: state.currentIndex,
                                          callbackTouch: (index) {
                                            BlocProvider.of<HomeCubit>(context).setCurrentIndex(index);
                                            _keyDropdownButton.currentState?.value = BlocProvider.of<HomeCubit>(context).getNames()[index];
                                          },
                                        ) : Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            padding: const EdgeInsets.all(40),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ThemeProvider.of().accentColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Не достаточно данных для отображения!",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: ThemeProvider.of().backgroundColor,
                                                    fontFamily: ThemeProvider.of().fontFamily,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16
                                                ),
                                              ),
                                            ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                              padding: const EdgeInsets.only(left: 30),
                                              child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    CustomDropdownButtonField(
                                                      key: _keyDropdownButton,
                                                      titleText: "",
                                                      items: BlocProvider.of<HomeCubit>(context).getNames(),
                                                      selectedItem: state.categoryData != null ? BlocProvider.of<HomeCubit>(context).getNames()[state.currentIndex] : null,
                                                      onChange: (value) =>
                                                      {
                                                        for (int i = 0; i < (state.categoryData ?? []).length; i++) {
                                                          if ((state.categoryData ?? [])[i].name == value) {
                                                            BlocProvider.of<HomeCubit>(context).setCurrentIndex(i)
                                                          }
                                                        }
                                                      },
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(left: 5),
                                                      width: double.infinity,
                                                      child: Text(
                                                          state.categoryData != null ? "${state.categoryData![state.currentIndex].sum.toStringAsFixed(0)} руб" : "0 руб",
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              color: ThemeProvider.of().primaryT10Color,
                                                              fontFamily: ThemeProvider.of().fontFamily,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 28
                                                          )
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(left: 5),
                                                      width: double.infinity,
                                                      child: Text(
                                                        "Средние затраты по категории составляют:",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: ThemeProvider.of().foregroundColor,
                                                            fontFamily: ThemeProvider.of().fontFamily,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(left: 5),
                                                      width: double.infinity,
                                                      child: Text(
                                                          "10000 руб",
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                              color: ThemeProvider.of().foregroundT30Color,
                                                              fontFamily: ThemeProvider.of().fontFamily,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 14
                                                          )
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10)
                                                  ]
                                              )
                                          )
                                      )
                                    ]
                                )
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: 70,
                              child: Row(
                                children: [
                                  TitleAndDescriptionBox(
                                      "Расход топлива",
                                      description: state.car.fuelConsumption != null ? "${state.car.fuelConsumption} л на 100 км" : "Недостаточно данных",
                                      margin: const EdgeInsets.only(right: 5)
                                  ),
                                  TitleAndDescriptionBox(
                                      "Пробег авто",
                                      description: "${state.car.currentMileage == 0 ? state.car.startMileage : state.car.currentMileage} км",
                                      margin: const EdgeInsets.only(left: 5)
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: 150,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: TextAndIconFormChipButton(
                                          state.categoryData != null ? state.categoryData![0].name : '',
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => WashExpenseProvider(carId: state.currentCarId),
                                            )).then((value) => BlocProvider.of<HomeCubit>(context).setCurrentCarId(value!));
                                          },
                                          color: state.categoryData != null ? state.categoryData![0].color : ThemeProvider.of().primaryT80Color,
                                          assetSvgIcon: state.categoryData != null ? state.categoryData![0].assetSvgIcon : '',
                                          offsetText: 0,
                                          sizeIcon: 70,
                                          margin: const EdgeInsets.only(right: 5)
                                      )
                                  ),
                                  Expanded(
                                      child: TextAndIconFormChipButton(
                                          state.categoryData != null ? state.categoryData![1].name : '',
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute<int>(
                                              builder: (context) => FuelExpenseProvider(carId: state.currentCarId),
                                            )).then((value) => BlocProvider.of<HomeCubit>(context).setCurrentCarId(value!));
                                          },
                                          color: state.categoryData != null ? state.categoryData![1].color : ThemeProvider.of().primaryT80Color,
                                          assetSvgIcon: state.categoryData != null ? state.categoryData![1].assetSvgIcon : '',
                                          margin: const EdgeInsets.only(left: 5)
                                      )
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: GridView.builder(
                                            itemCount: 8,
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10
                                            ),
                                            itemBuilder: (context, index) {
                                              if (state.categoryData != null) {
                                                var targetElement = state.categoryData![index + 2];
                                                return TextAndIconFormChipButton(
                                                  targetElement.name,
                                                  onPressed: () {
                                                    Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) {
                                                        switch (targetElement.type) {
                                                          case CategoryType.consumableExpense:
                                                            return const ConsumableScreen();
                                                          case CategoryType.repairExpense:
                                                            return RepairExpenseProvider(carId: state.currentCarId);
                                                          case CategoryType.towTruckExpense:
                                                            return TowTruckExpenseProvider(carId: state.currentCarId);
                                                          case CategoryType.serviceExpense:
                                                            return ServiceExpenseProvider(carId: state.currentCarId);
                                                          case CategoryType.tuningExpense:
                                                            return TuningExpenseProvider(carId: state.currentCarId);
                                                          case CategoryType.parkingExpense:
                                                            return ParkingExpenseProvider(carId: state.currentCarId);
                                                          case CategoryType.tollRoadExpense:
                                                            return TollRoadExpenseProvider(carId: state.currentCarId);
                                                          case CategoryType.otherExpense:
                                                            return OtherExpenseProvider(carId: state.currentCarId);
                                                          default:
                                                            return const StubVoidScreen();
                                                        }
                                                      }
                                                    )).then((value) => BlocProvider.of<HomeCubit>(context).setCurrentCarId(value!));
                                                  },
                                                  color: targetElement.color,
                                                  assetSvgIcon: targetElement
                                                      .assetSvgIcon,
                                                );
                                              } else {
                                                return TextAndIconFormChipButton(
                                                  '',
                                                  onPressed: () {},
                                                  color: ThemeProvider.of().primaryT80Color,
                                                  assetSvgIcon: '',
                                                );
                                              }
                                            }
                                        ),
                                      ),
                                      IgnorePointer(
                                          ignoring: true,
                                          child: Container(
                                              margin: const EdgeInsets.only(bottom: 19.5),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [ThemeProvider.of().backgroundColor.withAlpha(0), ThemeProvider.of().backgroundColor],
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter
                                                  )
                                              )
                                          )
                                      )
                                    ]
                                )
                            )
                          ]
                      )
                  ),
                );
              }
              return Container();
            }
        ),
        floatingActionButton: OutlinedButton(
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const CreateCarProvider(),
              )).then((value) => BlocProvider.of<HomeCubit>(context).update())
            },
            style: OutlinedButton.styleFrom(
                fixedSize: const Size(70, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                side: BorderSide(
                    color: ThemeProvider.of().accentColor,
                    width: 0
                ),
                backgroundColor: ThemeProvider.of().accentColor,
                elevation: 5
            ),
            child: Icon(Icons.add, color: ThemeProvider.of().backgroundColor, size: 30)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomBottomAppBar(centerPadding: 50, selectIndex: 1)
    );
  }
}