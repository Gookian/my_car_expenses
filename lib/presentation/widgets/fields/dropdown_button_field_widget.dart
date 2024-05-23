import 'package:flutter/material.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';

class CustomDropdownButtonField extends StatefulWidget {
  CustomDropdownButtonField({
    super.key,
    required this.titleText,
    required this.items,
    this.hintText,
    this.selectedItem,
    this.onChange,
  });

  final String titleText;
  final List<String> items;
  final String? selectedItem;
  final String? hintText;
  final void Function(String?)? onChange;

  //final GlobalKey<CustomDropdownButtonFieldState> keyWidget = GlobalKey<CustomDropdownButtonFieldState>();
  CustomDropdownButtonFieldState state = CustomDropdownButtonFieldState();
  String get value => state?.value ?? "";

  @override
  CustomDropdownButtonFieldState createState() {
    return state; // Переделать так плохо!!!
    //return CustomDropdownButtonFieldState();
  }
}

class CustomDropdownButtonFieldState extends State<CustomDropdownButtonField> {
  String? value;

  @override
  void initState() {
    super.initState();
    value = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                widget.titleText,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: ThemeProvider.of().primaryT10Color,
                    fontFamily: ThemeProvider.of().fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              )
          ),
          DropdownButtonFormField<String>(
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            iconSize: 25,
            iconEnabledColor: ThemeProvider.of().primaryT10Color,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                borderSide: BorderSide(
                    color: ThemeProvider.of().primaryT10Color,
                    width: ThemeProvider.of().borderWidth
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                borderSide: BorderSide(
                    color: ThemeProvider.of().primaryT10Color,
                    width: ThemeProvider.of().borderWidth
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                borderSide: BorderSide(
                    color: ThemeProvider.of().accentColor,
                    width: ThemeProvider.of().borderWidth
                ),
              ),
              hintText: widget.hintText,
              hintStyle: _getHelpTextStyle(),
            ),
            items: widget.items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Container(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        _getItemMenu(item, value),
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
                    )
                ),
              );
            }).toList(),
            selectedItemBuilder: (context) =>
                widget.items
                    .map((value) =>
                    Text(value, overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ThemeProvider.of().primaryT10Color,
                          fontFamily: ThemeProvider.of().fontFamily,
                          fontSize: 18,
                        )))
                    .toList(),
            onChanged: (value) =>
            {
              setState(() {
                this.value = value ?? "";
              }),

              if (widget.onChange != null) {
                widget.onChange!(value)
              }
            },
            value: value,
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

  Widget _getItemMenu(String item, String? state) {
    if (item == state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              item,
              style: TextStyle(
                color: ThemeProvider.of().accentColor,
                fontFamily: ThemeProvider.of().fontFamily,
                fontSize: 18,
              )
          ),
          Icon(Icons.check_circle_outline, color: ThemeProvider.of().accentColor)
        ],
      );
    } else {
      return Row(
          children: [
            Text(
                item,
                style: TextStyle(
                  color: ThemeProvider
                      .of()
                      .primaryT10Color,
                  fontFamily: ThemeProvider
                      .of()
                      .fontFamily,
                  fontSize: 18,
                )
            )
          ]
      );
    }
  }
}
/*
class CustomDropdownButtonField extends StatelessWidget {
  CustomDropdownButtonField({
    super.key,
    required this.titleText,
    required this.items,
    this.hintText,
    this.selectedItem,
    this.onChange
  });

  final String titleText;
  final List<String> items;
  final String? selectedItem;
  final String? hintText;
  final void Function(String?)? onChange;

  String? _value;
  String get value {
    return _value ?? "";
  }

  @override
  Widget build(BuildContext context) {
      return BlocProvider<DropdownButtonFieldCubit>(
          create: (context) => DropdownButtonFieldCubit(selectedItem),
          child: BlocBuilder<DropdownButtonFieldCubit, String?>(
              builder: (context, state) {
                if (selectedItem != null) {
                  BlocProvider.of<DropdownButtonFieldCubit>(context).setValue(selectedItem);
                }

                return Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      DropdownButtonFormField<String>(
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 25,
                        iconEnabledColor: ThemeProvider.of().primaryT10Color,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                            borderSide: BorderSide(
                                color: ThemeProvider.of().primaryT10Color,
                                width: ThemeProvider.of().borderWidth
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                            borderSide: BorderSide(
                                color: ThemeProvider.of().primaryT10Color,
                                width: ThemeProvider.of().borderWidth
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ThemeProvider.of().borderRadius),
                            borderSide: BorderSide(
                                color: ThemeProvider.of().accentColor,
                                width: ThemeProvider.of().borderWidth
                            ),
                          ),
                          hintText: hintText,
                          hintStyle: _getHelpTextStyle(),
                        ),
                        items: items.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Container(
                                margin: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    _getItemMenu(item, state),
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
                                )
                            ),
                          );
                        }).toList(),
                        selectedItemBuilder: (context) =>
                            items
                                .map((value) =>
                                Text(value, overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ThemeProvider.of().primaryT10Color,
                                      fontFamily: ThemeProvider.of().fontFamily,
                                      fontSize: 18,
                                    )))
                                .toList(),
                        onChanged: (value) =>
                        {
                          _value = value,
                          BlocProvider.of<DropdownButtonFieldCubit>(context).setValue(value),

                          if (onChange != null) {
                            onChange!(value)
                          }
                        },
                        value: state,
                      )
                    ]
                );
              })
      );
    }
  }

  TextStyle _getHelpTextStyle() {
    return TextStyle(
        color: ThemeProvider.of().primaryT50Color,
        fontFamily: ThemeProvider.of().fontFamily,
        fontSize: 18
    );
  }

  Widget _getItemMenu(String item, String? state) {
    if (item == state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              item,
              style: TextStyle(
                color: ThemeProvider.of().accentColor,
                fontFamily: ThemeProvider.of().fontFamily,
                fontSize: 18,
              )
          ),
          Icon(Icons.check_circle_outline, color: ThemeProvider.of().accentColor)
        ],
      );
    } else {
      return Row(
          children: [
            Text(
                item,
                style: TextStyle(
                  color: ThemeProvider.of().primaryT10Color,
                  fontFamily: ThemeProvider.of().fontFamily,
                  fontSize: 18,
                )
            )
          ]
      );
    }
  }*/