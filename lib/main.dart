import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_car_expenses/injection/data_layer_dependency_injection.dart';
import 'package:my_car_expenses/injection/domain_layer_dependency_injection.dart';
import 'package:my_car_expenses/injection/presentation_layer_dependency_injection.dart';
import 'presentation/providers/home_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  DataLayerDependencyInjection().injection();
  DomainLayerDependencyInjection().injection();
  PresentationLayerDependencyInjection().injection();

  runApp(const MaterialApp(home: HomeProvider()));
}