import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';
import 'package:my_car_expenses/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:my_car_expenses/presentation/widgets/buttons/outlined_button_widget.dart';
import 'package:my_car_expenses/until/svg_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class TowTruckScreen extends StatelessWidget {
  const TowTruckScreen({
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
            "Эвакуаторы",
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
        body: ListView(
          padding: const EdgeInsets.only(left: 20, top: 32, right: 20, bottom: 20),
          children: [
            buildTowTrickService(
                title: "Эвакуатор в Томске В ТОМСКЕ",
                description: "Быстро • качественно • надежно",
                textSchedule: "-",
                textPhone: "+7 (903) 955-08-70",
                url: "https://evacuator-tomsk.ru/",
                phone: "+79039550870"
            ),
            const SizedBox(height: 16),
            buildTowTrickService(
                title: "Авто босс",
                description: "Буксировка, подвоз топлива, шиномонтаж",
                textSchedule: "-",
                textPhone: "8 (3822) 941-007",
                url: "https://avtoboss.biz",
                phone: "+73822941007"
            )
          ],
        ),
        bottomNavigationBar: const CustomBottomAppBar()
    );
  }

  Widget buildTowTrickService({
    required String title,
    required String description,
    required String textPhone,
    required String textSchedule,
    required String url,
    required String phone
  }) {
    return Column(
        children: [
          Row(
              children: [
                SvgPicture.asset(
                  SvgIcons.towTruck,
                  colorFilter: ColorFilter.mode(ThemeProvider.of().primaryT10Color, BlendMode.srcIn),
                  width: 70,
                  height: 70,
                ),
                const SizedBox(width: 20),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                color: ThemeProvider.of().foregroundColor,
                                fontFamily: ThemeProvider.of().fontFamily,
                                fontSize: 20
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                              description,
                              style: TextStyle(
                                  color: ThemeProvider.of().foregroundT30Color,
                                  fontFamily: ThemeProvider.of().fontFamily,
                                  fontSize: 16
                              )
                          ),
                          const SizedBox(height: 8),
                          Text(
                              "График работы: $textSchedule",
                              style: TextStyle(
                                  color: ThemeProvider.of().foregroundT30Color,
                                  fontFamily: ThemeProvider.of().fontFamily,
                                  fontSize: 16
                              )
                          ),
                          const SizedBox(height: 8),
                          Text(
                              "Телефон: $textPhone",
                              style: TextStyle(
                                  color: ThemeProvider.of().foregroundT30Color,
                                  fontFamily: ThemeProvider.of().fontFamily,
                                  fontSize: 16
                              )
                          )
                        ]
                    )
                )
              ]
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: CustomOutlinedButton(
                      onPressed: () {
                        _launchURL(url);
                      },
                      child: const Text("Перейти на сайт")
                  )
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: CustomOutlinedButton(
                      onPressed: () {
                        _launchPhone(phone);
                      },
                      child: const Text("Позванить")
                  )
              )
            ],
          ),
          Container(
              margin: const EdgeInsets.only(top: 8),
              height: ThemeProvider.of().borderWidth,
              decoration: BoxDecoration(
                color: ThemeProvider.of().primaryT80Color,
                borderRadius: BorderRadius.all(
                    Radius.circular(ThemeProvider.of().borderRadius)),
              )
          )
        ]
    );
  }

  _launchURL(String uri) async {
    final Uri url = Uri.parse(uri);
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    }
  }

  _launchPhone(String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    }
  }
}