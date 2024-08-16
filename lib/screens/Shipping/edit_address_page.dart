// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pets_app/controllers/address_controller.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/button_widget.dart';
import 'package:pets_app/widgets/empty_widget.dart';

class EditAddressPage extends StatelessWidget {
  EditAddressPage({Key? key}) : super(key: key);
  final controller = Get.put(AddressController());

  Future<bool> _requestPop() {
    Get.back();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double leftMargin = getHorizontalSpace(context);

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: appBarBack(context, "Edit Address", true),
          body: controller.haveAddress == true
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    ListView(
                      padding: EdgeInsets.all(leftMargin),
                      children: [
                        textFiledWidget(
                            context,
                            "City",
                            controller.cityController,
                            Icons.location_city,
                            TextInputType.text,
                            (value) {}),
                        textFiledWidget(
                            context,
                            "Street",
                            controller.streetController,
                            Icons.location_city,
                            TextInputType.text,
                            (value) {}),
                        textFiledWidget(
                            context,
                            "Building",
                            controller.buildingController,
                            Icons.location_city,
                            TextInputType.text,
                            (value) {}),
                        textFiledWidget(
                            context,
                            "Apartment number",
                            controller.apartmentNumberController,
                            Icons.location_city,
                            TextInputType.number,
                            (value) {}),
                        textFiledWidgetLarge(context, "Additional Instructions",
                            controller.additionalInstructionsController),
                      ],
                    ),
                    Positioned(
                      bottom: 1,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: buttonWidget(
                            context, "Save", primaryColor,Colors.white, () {
                          controller.saveAddress();
                          // Navigator.of(context).pop();
                        }),
                      ),
                    ),
                  ],
                )
              : emptyWidgetWithButton(
                  context,
                  "",
                  Icons.location_on,
                  "You Haven't addresses yet!",
                  "you can add new address",
                  "Add New Address", () {
                  Get.toNamed(Routes.ADDADDRESS);
                }),
        ));
  }
}
