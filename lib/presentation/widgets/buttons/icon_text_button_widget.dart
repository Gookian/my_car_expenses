import 'package:flutter/material.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text
  });

  static const primaryColor = Color(0xFF413F57);

  final void Function() onPressed;
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            side: const BorderSide(
                color: Colors.transparent,
                width: 0
            )
        ),
        child: Container(
          padding: EdgeInsets.only(top: 8),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: icon,
                  ),
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            text,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: ThemeProvider.of().primaryT10Color,
                                fontFamily: ThemeProvider.of().fontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, color: ThemeProvider.of().primaryT10Color)
                        ],
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}