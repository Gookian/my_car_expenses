import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';

class TextAndIconFormChipButton extends StatelessWidget {
  const TextAndIconFormChipButton(this.title, {
    super.key,
    required this.onPressed,
    required this.color,
    required this.assetSvgIcon,
    this.offsetText = 10,
    this.sizeIcon = 60,
    this.margin
  });

  final String title;
  final void Function()? onPressed;
  final Color color;
  final String assetSvgIcon;
  final double? offsetText;
  final double? sizeIcon;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
          color: color,
        ),
        child: OutlinedButton(
            onPressed: () => { onPressed!() },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
              ),
              side: const BorderSide(
                  color: Colors.transparent,
                  width: 0
              ),
              backgroundColor: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  assetSvgIcon,
                  colorFilter: ColorFilter.mode(ThemeProvider.of().backgroundColor, BlendMode.srcIn),
                  width: sizeIcon,
                  height: sizeIcon,
                ),
                SizedBox(height: offsetText),
                Text(
                    title,
                    style: TextStyle(
                        color: ThemeProvider.of().backgroundColor,
                        fontFamily: ThemeProvider.of().fontFamily,
                        fontSize: 16
                    )
                )
              ],
            )
        )
    );
  }
}