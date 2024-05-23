import 'package:flutter/material.dart';
import 'package:my_car_expenses/presentation/providers/home_provider.dart';
import 'package:my_car_expenses/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/date_picker_field_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/dropdown_button_field_widget.dart';
import 'package:my_car_expenses/presentation/widgets/buttons/outlined_button_widget.dart';
import 'package:my_car_expenses/presentation/widgets/fields/text_field_widget.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';

class StubVoidScreen extends StatelessWidget {
  const StubVoidScreen({super.key});

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
          'Экран заглушка',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/stub_void.png",
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 30),
            Text(
              "Данный функционал пока что не реализован",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ThemeProvider.of().primaryT10Color,
                  fontFamily: ThemeProvider.of().fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar()
    );
  }
}