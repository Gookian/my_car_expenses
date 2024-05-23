import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_car_expenses/presentation/bloc/screens/cars_screen/cars_cubit.dart';
import 'package:my_car_expenses/presentation/bloc/screens/cars_screen/cars_state.dart';
import 'package:my_car_expenses/presentation/screens/menu_screen.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';
import 'package:my_car_expenses/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:my_car_expenses/presentation/widgets/roll_up_container_widget.dart';
import 'package:my_car_expenses/until/svg_icons.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({
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
          title: Text(
            "Уведомления",
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
                      "assets/images/notification.png",
                      width: 300,
                      height: 300,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Нет уведомлений",
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
                  padding: const EdgeInsets.only(left: 20, top: 32, right: 20, bottom: 20),
                  itemCount: state.cars.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 32);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var item = state.cars[index];
                    return RollUpContainer(
                      title: '${item.model} ${item.make} ${item.yearOfIssue}',
                      child: Column(
                        children: [
                          buildNotification(),
                          const SizedBox(height: 8),
                          buildNotification(),
                          const SizedBox(height: 8),
                          buildNotification(),
                          const SizedBox(height: 8),
                          buildNotification()
                        ],
                      )
                    );
                  }
              );
            }
            return Container();
          }
        ),
        bottomNavigationBar: const CustomBottomAppBar(selectIndex: 4)
    );
  }

  Widget buildNotification() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
          border: Border.all(
              color: ThemeProvider.of().primaryT10Color,
              width: ThemeProvider.of().borderWidth
          )
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            SvgIcons.notification,
            colorFilter: ColorFilter.mode(ThemeProvider.of().accentColor, BlendMode.srcIn),
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 20),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Продлите страховку",
                    style: TextStyle(
                        color: ThemeProvider.of().foregroundColor,
                        fontFamily: ThemeProvider.of().fontFamily,
                        fontSize: 20
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Через 30 дней просрочится страховка",
                    style: TextStyle(
                        color: ThemeProvider.of().foregroundT30Color,
                        fontFamily: ThemeProvider.of().fontFamily,
                        fontSize: 16
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}