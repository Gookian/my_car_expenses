import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_car_expenses/domain/entities/document_type.dart';
import 'package:my_car_expenses/presentation/bloc/screens/document_screen/document_cubit.dart';
import 'package:my_car_expenses/presentation/bloc/screens/document_screen/document_state.dart';
import 'package:my_car_expenses/presentation/providers/create/create_insurance_provider.dart';
import 'package:my_car_expenses/presentation/providers/create/create_vehicle_passport_provider.dart';
import 'package:my_car_expenses/presentation/providers/create/create_vehicle_registration_certificate_provider.dart';
import 'package:my_car_expenses/presentation/screens/stub_void_screen.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';
import 'package:my_car_expenses/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:my_car_expenses/presentation/widgets/buttons/icon_text_button_widget.dart';
import 'package:my_car_expenses/presentation/widgets/buttons/outlined_button_widget.dart';
import 'package:my_car_expenses/presentation/widgets/roll_up_container_widget.dart';
import 'package:my_car_expenses/until/svg_icons.dart';

import 'menu_screen.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({
    super.key
  });

  void showBottomShipCrate(BuildContext context, int carId) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext buildContext) {
          return SizedBox(
            height: 250,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                IconTextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CreateVehicleRegistrationCertificateProvider(carId: carId),
                      )).then((value) => BlocProvider.of<DocumentCubit>(context).update());
                    },
                    icon: SvgPicture.asset(
                      SvgIcons.vehicleRegistrationCertificate,
                      colorFilter: ColorFilter.mode(ThemeProvider.of().accentColor, BlendMode.srcIn),
                      width: 50,
                      height: 50,
                    ),
                    text: "Добавить СТС"
                ),
                IconTextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CreateVehiclePassportProvider(carId: carId),
                      )).then((value) => BlocProvider.of<DocumentCubit>(context).update());
                    },
                    icon: SvgPicture.asset(
                      SvgIcons.vehiclePassport,
                      colorFilter: ColorFilter.mode(ThemeProvider.of().accentColor, BlendMode.srcIn),
                      width: 50,
                      height: 50,
                    ),
                    text: "Добавить паспорт ТС"
                ),
                IconTextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CreateInsuranceProvider(carId: carId),
                      )).then((value) => BlocProvider.of<DocumentCubit>(context).update());
                    },
                    icon: SvgPicture.asset(
                      SvgIcons.insurance,
                      colorFilter: ColorFilter.mode(ThemeProvider.of().accentColor, BlendMode.srcIn),
                      width: 50,
                      height: 50,
                    ),
                    text: "Добавить страховку"
                )
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ThemeProvider.of().primaryColor,
          leading: Container(
            margin: const EdgeInsets.only(left: 15),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () =>
              {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const MenuScreen(),
                ))
              },
              iconSize: 30,
            ),
          ),
          title: Text(
            "Документы",
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
        body: BlocBuilder<DocumentCubit, DocumentState>(
          builder: (context, state) {
            if (state is DocumentEmptyState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/empty_box.png",
                      width: 300,
                      height: 300,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Нет ни одного автомобиля",
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
              );
            }
            if (state is DocumentLoadingState) {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: ThemeProvider.of().accentColor,
                        strokeAlign: 5,
                        strokeWidth: 5,
                        strokeCap: StrokeCap.round,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "Загрузка",
                        style: TextStyle(
                            color: ThemeProvider.of().primaryT10Color,
                            fontFamily: ThemeProvider.of().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      )
                    ],
                  )
              );
            }
            if (state is DocumentLoadedState) {
              return ListView.separated(
                  padding: const EdgeInsets.only(left: 20, top: 32, right: 20, bottom: 20),
                  itemCount: state.carDocuments.length + 1,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 32);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Row(
                        children: [
                          SvgPicture.asset(
                            SvgIcons.driverLicense,
                            colorFilter: ColorFilter.mode(ThemeProvider.of().primaryT10Color, BlendMode.srcIn),
                            width: 70,
                            height: 70,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                              child: CustomOutlinedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => const StubVoidScreen(),
                                    ));
                                  },
                                  child: const Text("Добавить водительские права")
                              )
                          )
                        ]
                      );
                    }
                    var item = state.carDocuments[index - 1];
                    return RollUpContainer(
                      title: item.name,
                      child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: item.documents.length + 1,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 16);
                          },
                          itemBuilder: (BuildContext context, int index) {
                              if (index < item.documents.length) {
                                var itemDocument = item.documents[index];
                                print(itemDocument.type.name);
                                switch (itemDocument.type) {
                                  case DocumentType.vehicleRegistrationCertificate:
                                    return buildDocument("Свидетельство о регистрации", "Серия и номер: ${itemDocument.series} ${itemDocument.number}", SvgIcons.vehicleRegistrationCertificate);
                                  case DocumentType.vehiclePassport:
                                    return buildDocument("Паспорт ТС", "Серия и номер: ${itemDocument.series} ${itemDocument.number}", SvgIcons.vehiclePassport);
                                  case DocumentType.insurance:
                                    return buildDocument("Страховка", "Серия и номер: ${itemDocument.series} ${itemDocument.number}", SvgIcons.insurance);
                                }
                              } else {
                                return CustomOutlinedButton(
                                  onPressed: () {
                                    showBottomShipCrate(context, item.carId);
                                  },
                                  description: item.name,
                                  child: const Text("Добавить документ для:")
                                );
                              }
                          }
                      )
                    );
                  }
              );
            }
            return Container();
          }
        ),
        bottomNavigationBar: const CustomBottomAppBar(selectIndex: 3)
    );
  }

  Widget buildDocument(String title, String description, String svgIconAsset) {
    return Column(
      children: [
        Row(
            children: [
              SvgPicture.asset(
                svgIconAsset,
                colorFilter: ColorFilter.mode(ThemeProvider.of().primaryT10Color, BlendMode.srcIn),
                width: 70,
                height: 70,
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              color: ThemeProvider.of().foregroundColor,
                              fontFamily: ThemeProvider.of().fontFamily,
                              fontSize: 20
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                            description,
                            style: TextStyle(
                                color: ThemeProvider.of().foregroundT30Color,
                                fontFamily: ThemeProvider.of().fontFamily,
                                fontSize: 16
                            )
                        )
                      ]
                  )
              )
            ]
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: ThemeProvider.of().borderWidth,
          decoration: BoxDecoration(
            color: ThemeProvider.of().primaryT80Color,
            borderRadius: BorderRadius.all(
                Radius.circular(ThemeProvider.of().borderRadius)),
          )
        )
      ]
    );
  }
}