import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_car_expenses/presentation/providers/document_provider.dart';
import 'package:my_car_expenses/presentation/providers/notification_provider.dart';
import 'package:my_car_expenses/presentation/screens/stub_void_screen.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';

import '../../until/svg_icons.dart';
import '../providers/home_provider.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
    this.centerPadding = 0,
    this.selectIndex = 0
  });

  final double centerPadding;
  final double selectIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        height: 70,
        color: ThemeProvider.of().primaryColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  icon: SvgPicture.asset(
                    SvgIcons.home,
                    colorFilter: ColorFilter.mode(
                        selectIndex == 1 ? ThemeProvider.of().accent2Color : ThemeProvider.of().backgroundColor,
                        BlendMode.srcIn
                    ),
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const HomeProvider(),
                    ));
                  }
              ),
              Padding(
                  padding: EdgeInsets.only(right: centerPadding),
                  child: IconButton(
                      icon: SvgPicture.asset(
                        SvgIcons.statistics,
                        colorFilter: ColorFilter.mode(
                            selectIndex == 2 ? ThemeProvider.of().accent2Color : ThemeProvider.of().backgroundColor,
                            BlendMode.srcIn
                        ),
                        width: 30,
                        height: 30,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const StubVoidScreen(),
                        ));
                      }
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: centerPadding),
                child: IconButton(
                    icon: SvgPicture.asset(
                      SvgIcons.documents,
                      colorFilter: ColorFilter.mode(
                          selectIndex == 3 ? ThemeProvider.of().accent2Color : ThemeProvider.of().backgroundColor,
                          BlendMode.srcIn
                      ),
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const DocumentProvider(),
                      ));
                    }
                ),
              ),
              IconButton(
                  icon: SvgPicture.asset(
                    SvgIcons.notification,
                    colorFilter: ColorFilter.mode(
                        selectIndex == 4 ? ThemeProvider.of().accent2Color : ThemeProvider.of().backgroundColor,
                        BlendMode.srcIn
                    ),
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const NotificationProvider(),
                    ));
                  }
              )
            ]
        )
    );
  }
}