import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_car_expenses/presentation/providers/cars_provider.dart';
import 'package:my_car_expenses/presentation/providers/document_provider.dart';
import 'package:my_car_expenses/presentation/providers/notification_provider.dart';
import 'package:my_car_expenses/presentation/screens/service_screen.dart';
import 'package:my_car_expenses/presentation/screens/stub_void_screen.dart';
import 'package:my_car_expenses/presentation/screens/tow_truck_screen.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';

import '../../until/svg_icons.dart';
import '../providers/home_provider.dart';
import '../widgets/buttons/icon_text_button_widget.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
          'Меню',
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
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: IconTextButton(
                        onPressed: () => {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const CarsProvider(),
                          ))
                        },
                        icon: SvgPicture.asset(
                          SvgIcons.car,
                          colorFilter: ColorFilter.mode(ThemeProvider.of().primaryColor, BlendMode.srcIn),
                          width: 40,
                          height: 40,
                        ),
                        text: "Мои авто"
                      )
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: IconTextButton(
                            onPressed: () => {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const HomeProvider(),
                              ))
                            },
                            icon: SvgPicture.asset(
                              SvgIcons.home,
                              colorFilter: ColorFilter.mode(ThemeProvider.of().primaryColor, BlendMode.srcIn),
                              width: 40,
                              height: 40,
                            ),
                            text: "Главная"
                        )
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: IconTextButton(
                          onPressed: () => {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const DocumentProvider(),
                            ))
                          },
                          icon: SvgPicture.asset(
                            SvgIcons.documents,
                            colorFilter: ColorFilter.mode(ThemeProvider.of().primaryColor, BlendMode.srcIn),
                            width: 40,
                            height: 40,
                          ),
                          text: "Мои документы"
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: IconTextButton(
                          onPressed: () => {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const StubVoidScreen(),
                            ))
                          },
                          icon: SvgPicture.asset(
                            SvgIcons.statistics,
                            colorFilter: ColorFilter.mode(ThemeProvider.of().primaryColor, BlendMode.srcIn),
                            width: 40,
                            height: 40,
                          ),
                          text: "Статистика"
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: IconTextButton(
                          onPressed: () => {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const NotificationProvider(),
                            ))
                          },
                          icon: SvgPicture.asset(
                            SvgIcons.notification,
                            colorFilter: ColorFilter.mode(ThemeProvider.of().primaryColor, BlendMode.srcIn),
                            width: 40,
                            height: 40,
                          ),
                          text: "Уведомления"
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: IconTextButton(
                          onPressed: () => {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const ServiceScreen(),
                            ))
                          },
                          icon: SvgPicture.asset(
                            SvgIcons.service,
                            colorFilter: ColorFilter.mode(ThemeProvider.of().primaryColor, BlendMode.srcIn),
                            width: 40,
                            height: 40,
                          ),
                          text: "Номера и ссылки на сервисы"
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      child: IconTextButton(
                          onPressed: () => {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const TowTruckScreen(),
                            ))
                          },
                          icon: SvgPicture.asset(
                            SvgIcons.towTruck,
                            colorFilter: ColorFilter.mode(ThemeProvider.of().primaryColor, BlendMode.srcIn),
                            width: 40,
                            height: 40,
                          ),
                          text: "Номера эвакуаторов"
                      ),
                    )
                  ]
              )
          )
      ),
    );
  }
}