import 'package:flutter/material.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.titleText,
    this.validator,
    this.keyboardType,
    this.labelText,
    this.hintText,
    this.suffixText,
    this.text
  });

  final String titleText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? labelText;
  final String? hintText;
  final String? suffixText;
  final String? text;

  final TextEditingController _controller = TextEditingController();

  String? _value;
  String get value {
    return _controller.text;
  }

  @override
  Widget build(BuildContext context) {
    _value ??= text;
    if (_value != null) {
      _controller.text = _value!;
    }

    return Column(
        children: [
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                titleText,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: ThemeProvider.of().primaryT10Color,
                    fontFamily: ThemeProvider.of().fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              )
          ),
          TextFormField(
            controller: _controller,
            style: TextStyle(
                color: ThemeProvider.of().primaryT10Color,
                fontFamily: ThemeProvider.of().fontFamily,
                fontSize: 18
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ThemeProvider.of().accentColor,
                      width: ThemeProvider.of().borderWidth
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ThemeProvider.of().borderRadius)
                  )
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ThemeProvider.of().primaryT10Color,
                    width: ThemeProvider.of().borderWidth
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(ThemeProvider.of().borderRadius)
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ThemeProvider.of().errorColor,
                    width: ThemeProvider.of().borderWidth
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(ThemeProvider.of().borderRadius)
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ThemeProvider.of().errorColor,
                    width: ThemeProvider.of().borderWidth
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(ThemeProvider.of().borderRadius)
                ),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              /*suffixIcon: IconButton(
                padding: const EdgeInsets.only(right: 10),
                icon: const Icon(Icons.error, size: 30),
                color: ThemeProvider.of().errorColor,
                onPressed: () {
                  print('Search');
                },
              ),*/
              labelText: labelText,
              hintText: hintText,
              suffixText: suffixText,
              errorStyle: _getErrorTextStyle(),
              labelStyle: _getHelpTextStyle(),
              hintStyle: _getHelpTextStyle(),
              suffixStyle: _getHelpTextStyle(),
            ),
            keyboardType: keyboardType,
            validator: validator,
          )
        ]
    );
  }

  TextStyle _getHelpTextStyle() {
    return TextStyle(
        color: ThemeProvider.of().primaryT50Color,
        fontFamily: ThemeProvider.of().fontFamily,
        fontSize: 18
    );
  }

  TextStyle _getErrorTextStyle() {
    return TextStyle(
        color: ThemeProvider.of().errorColor,
        fontFamily: ThemeProvider.of().fontFamily,
        fontSize: 16
    );
  }
}