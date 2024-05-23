import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';
import 'package:my_car_expenses/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:my_car_expenses/presentation/widgets/buttons/outlined_button_widget.dart';
import 'package:my_car_expenses/until/svg_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({
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
            "Сервисы",
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
            buildService(
              title: "Автосервис на молодежной",
              description: "Ремонт и обслуживание автомобилей г. Томск",
              textSchedule: "ПН - ПТ 9:00 - 18:00\nСБ 10:00 - 17:00\nВС выходной",
              textPhone: "+7 (3822) 33 55 83",
              textAddress: "г. Томск, ул. Молодёжная, д.5",
              textEmail: "avtoservis.tsk@gmail.com",
              url: "https://www.ремонтавто70.рф/",
              phone: "+73822335583"
            ),
            const SizedBox(height: 16),
            buildService(
              title: "Комплексный автосервис «А-Бренд»",
              description: "Ремонт и обслуживание автомобилей",
              textSchedule: "ПН-ПТ 8:00–19:00",
              textPhone: "+7 (3822) 996-114",
              textAddress: "г. Томск, Коларовский тракт, 6, стр. 2",
              textEmail: "service@autoservis37.ru",
              url: "https://autoservice70.ru",
              phone: "+73822996114"
            ),
            const SizedBox(height: 16),
            buildService(
                title: "Автосервис СТО-1 на Пушкина",
                description: "Производим ремонт автомобилей в Томске с гарантией 12 месяцев на все работы и запчасти.",
                textSchedule: "ежедневно с 9:00 до 19:00, без выходных",
                textPhone: "+7 (3822) 908-707",
                textAddress: "г. Томск, ул. Пушкина, 65/2",
                textEmail: "sto1-tsk@yandex.ru",
                url: "https://sto1.tomsk.ru",
                phone: "+73822908707"
            ),
            const SizedBox(height: 16),
            buildService(
                title: "Автосервис СТО-1 на Пойменный",
                description: "Производим ремонт автомобилей в Томске с гарантией 12 месяцев на все работы и запчасти.",
                textSchedule: "ежедневно с 9:00 до 19:00, без выходных",
                textPhone: "+7 (3822) 907-707",
                textAddress: "г. Томск, пер. Пойменный, 4",
                textEmail: "sto1-tsk@yandex.ru",
                url: "https://sto1.tomsk.ru",
                phone: "+73822907707"
            )
          ],
        ),
        bottomNavigationBar: const CustomBottomAppBar()
    );
  }

  Widget buildService({
    required String title,
    required String description,
    required String textPhone,
    required String textAddress,
    required String textEmail,
    required String textSchedule,
    required String url,
    required String phone
  }) {
    return Column(
        children: [
          Row(
              children: [
                SvgPicture.asset(
                  SvgIcons.service,
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
                              "Адрес: $textAddress",
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
                          ),
                          const SizedBox(height: 8),
                          Text(
                              "Email: $textEmail",
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