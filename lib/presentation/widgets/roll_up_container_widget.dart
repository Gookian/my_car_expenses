import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';
import 'package:my_car_expenses/until/svg_icons.dart';

class RollUpContainer extends StatefulWidget {
  const RollUpContainer({
    super.key,
    required this.title,
    required this.child,
    this.isOpen
  });

  final String title;
  final Widget child;
  final bool? isOpen;

  @override
  State<StatefulWidget> createState() => RollUpContainerState();
}

class RollUpContainerState extends State<RollUpContainer> {
  late bool _isOpen;
  late Widget? _child;

  @override
  void initState() {
    _isOpen = widget.isOpen ?? false;
    _child = widget.child;

    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    _child = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Column(
        children: [
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (_isOpen) {
                  setState(() {
                    _isOpen = false;
                  });
                } else {
                  setState(() {
                    _isOpen = true;
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      widget.title,
                      style: TextStyle(
                          color: ThemeProvider.of().primaryT10Color,
                          fontFamily: ThemeProvider.of().fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      )
                  ),
                  _isOpen ?
                  Icon(Icons.arrow_drop_down, size: 30, color: ThemeProvider.of().primaryT10Color) :
                  Icon(Icons.arrow_drop_up, size: 30, color: ThemeProvider.of().primaryT10Color)
                ],
              )
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: ThemeProvider.of().borderWidth + 2,
            decoration: BoxDecoration(
              color: ThemeProvider.of().primaryT10Color,
              borderRadius: BorderRadius.all(
                  Radius.circular(ThemeProvider.of().borderRadius)),
            ),
          ),
          const SizedBox(height: 8),
          AnimatedSize(
            duration: const Duration(seconds: 1),
            reverseDuration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            alignment: Alignment.topCenter,
            child: Container(
              constraints: _isOpen
                  ? const BoxConstraints(maxHeight: double.infinity)
                  : const BoxConstraints(maxHeight: 0.0),
              child: _child
            ),
          )
        ],
      );
}