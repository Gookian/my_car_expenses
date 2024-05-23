import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_car_expenses/presentation/screens/stub_void_screen.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';
import 'package:my_car_expenses/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:my_car_expenses/presentation/widgets/buttons/outlined_button_widget.dart';
import 'package:my_car_expenses/until/svg_icons.dart';

class ConsumableScreen extends StatelessWidget {
  const ConsumableScreen({
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
            "Расходники",
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
            buildConsumable(
                context,
                title: "Масляный фильтр",
                buttonTitle: "Заменить масляный фильтр",
                resourceText: "8000",
                dateText: "неизвестна",
                svgIconAsset: SvgIcons.oilFilter
            ),
            const SizedBox(height: 16),
            buildConsumable(
                context,
                title: "Воздушный фильтр",
                buttonTitle: "Заменить воздушный фильтр",
                resourceText: "15000",
                dateText: "неизвестна",
                svgIconAsset: SvgIcons.airFilter
            ),
            const SizedBox(height: 16),
            buildConsumable(
                context,
                title: "Бензиновый фильтр",
                buttonTitle: "Заменить бензиновый фильтр",
                resourceText: "20000",
                dateText: "неизвестна",
                svgIconAsset: SvgIcons.fuelFilter
            ),
            const SizedBox(height: 16),
            buildConsumable(
                context,
                title: "Свечи",
                buttonTitle: "Заменить свечи",
                resourceText: "100000",
                dateText: "неизвестна",
                svgIconAsset: SvgIcons.sparkPlug
            ),
            const SizedBox(height: 16),
            buildConsumable(
                context,
                title: "Катализатор",
                buttonTitle: "Заменить катализатор",
                resourceText: "120000",
                dateText: "неизвестна",
                svgIconAsset: SvgIcons.catalyst
            ),
            const SizedBox(height: 16),
            buildConsumable(
                context,
                title: "Колодки",
                buttonTitle: "Заменить колодки",
                resourceText: "30000",
                dateText: "неизвестна",
                svgIconAsset: SvgIcons.brakePads
            ),
            const SizedBox(height: 16),
            buildConsumable(
                context,
                title: "Сцепление",
                buttonTitle: "Заменить сцепление",
                resourceText: "5000",
                dateText: "неизвестна",
                svgIconAsset: SvgIcons.clutch
            )
          ],
        ),
        bottomNavigationBar: const CustomBottomAppBar()
    );
  }

  Widget buildConsumable(BuildContext context, {
    required String title,
    required String buttonTitle,
    required String resourceText,
    required String dateText,
    required String svgIconAsset
  }) {
    return Column(
        children: [
          Row(
              children: [
                SvgPicture.asset(
                  svgIconAsset,
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
                              "Русурс: $resourceText км",
                              style: TextStyle(
                                  color: ThemeProvider.of().foregroundT30Color,
                                  fontFamily: ThemeProvider.of().fontFamily,
                                  fontSize: 16
                              )
                          ),
                          const SizedBox(height: 8),
                          Text(
                              "Примерная дата замены: $dateText",
                              style: TextStyle(
                                  color: ThemeProvider.of().foregroundT30Color,
                                  fontFamily: ThemeProvider.of().fontFamily,
                                  fontSize: 16
                              )
                          ),
                        ]
                    )
                )
              ]
          ),
          const SizedBox(height: 16),
          CustomOutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const StubVoidScreen(),
                ));
              },
              child: Text(buttonTitle)
          )
        ]
    );
  }
}