import 'dart:ui';

import 'package:my_car_expenses/presentation/themes/theme_base.dart';

class ThemeLight implements ThemeBase {
  @override
  Color accentColor = const Color(0xFF514EE0);//0xFF514EE0

  @override
  Color accent2Color = const Color(0xFF8C8AE7);

  @override
  String fontFamily = "Montserrat";//Montserrat

  @override
  Color primaryColor = const Color(0xFF413F57);//0xFF413F57

  @override
  Color primaryT10Color = const Color(0xE6413F57);//0xE6413F57

  @override
  Color primaryT50Color = const Color(0x80413F57);//0x80413F57

  @override
  Color primaryT80Color = const Color(0x33413F57);

  @override
  Color backgroundColor = const Color(0xFFF4FBFB);//0xFFF4FBFB

  @override
  Color backgroundT80Color = const Color(0xCCF4FBFB);

  @override
  Color foregroundColor = const Color(0xFF333333);

  @override
  Color foregroundT30Color = const Color(0xB3333333);

  @override
  Color errorColor = const Color(0xFFDB4B47);

  @override
  Color errorT50Color = const Color(0x80DB4B47); // Возможно не нужен

  @override
  double borderRadius = 15.0;//15.0

  @override
  double borderWidth = 2.4;
}