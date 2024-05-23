import 'package:my_car_expenses/presentation/themes/theme_base.dart';
import 'package:my_car_expenses/presentation/themes/theme_light.dart';

class ThemeProvider {
  static final ThemeBase _them = ThemeLight();

  static ThemeBase of() {
    return _them;
  }
}