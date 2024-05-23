import 'package:flutter/material.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';

class TitleAndDescriptionBox extends StatelessWidget {
  const TitleAndDescriptionBox(this.title, {
    super.key,
    this.description,
    this.margin
  });

  final String title;
  final String? description;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            margin: margin,
            height: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ThemeProvider.of().accentColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: ThemeProvider.of().backgroundColor,
                      fontFamily: ThemeProvider.of().fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
                getDescriptionOrVoidWidget()
              ],
            )
        )
    );
  }

  Widget getDescriptionOrVoidWidget() {
    if (description != null) {
      return Text(
        description!,
        style: TextStyle(
            color: ThemeProvider.of().backgroundColor,
            fontFamily: ThemeProvider.of().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 14
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}