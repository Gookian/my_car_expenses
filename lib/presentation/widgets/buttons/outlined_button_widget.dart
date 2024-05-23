import 'package:flutter/material.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.description
  });

  final void Function()? onPressed;
  final Widget? child;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width, 60),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                ThemeProvider.of().borderRadius
            ),
          ),
          side: BorderSide(
              color: ThemeProvider.of().accentColor,
              width: ThemeProvider.of().borderWidth
          ),
          backgroundColor: ThemeProvider.of().backgroundColor,
          foregroundColor: ThemeProvider.of().accentColor,
          textStyle: TextStyle(
              fontFamily: ThemeProvider.of().fontFamily,
              fontWeight: FontWeight.w900,
              fontSize: 18
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child!,
          description != null ? Text(
            description ?? "",
            style: TextStyle(
                color: ThemeProvider.of().accent2Color,
                fontFamily: ThemeProvider.of().fontFamily,
                fontWeight: FontWeight.w900,
                fontSize: 14
            )
          ) : Container()
        ],
      ),
    );
  }
}