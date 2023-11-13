// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pets_app/controllers/address_controller.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:get/get.dart';

class AddNewAddressPage extends StatelessWidget {
  AddNewAddressPage({Key? key}) : super(key: key);
  dynamic argumentData = Get.arguments;

  final controller = Get.put(AddressController());

  Future<bool> _requestPop() {
    Get.back();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    if (argumentData != null) {
      controller.getAddressDetail(argumentData[0]['isEdit']);
    }

    SizeConfig().init(context);
    double leftMargin = getHorizontalSpace(context);

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Edit Address"),
            elevation: 0,
            centerTitle: true,
          ),
          // appBar: AppBar(
          //   elevation: 0,
          //   toolbarHeight: 0,
          //   centerTitle: true,
          //   // backgroundColor: backgroundColor,
          //   title: getAppBarText(context, S.of(context).address),
          //   leading: Builder(
          //     builder: (BuildContext context) {
          //       return IconButton(
          //         icon: getAppBarIcon(),
          //         onPressed: _requestPop,
          //       );
          //     },
          //   ),
          // ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: ListView(
                  padding: EdgeInsets.all(leftMargin),
                  children: [
                    getDefaultTextFiledWithoutIconWidget(
                        context, "City", controller.cityController),
                    getDefaultTextFiledWithoutIconWidget(
                        context, "Street", controller.streetController),
                    getDefaultTextFiledWithoutIconWidget(
                        context, "Building", controller.buildingController),
                    getDefaultTextFiledWithoutIconWidget(
                        context,
                        "Apartment number",
                        controller.apartmentNumberController),
                    getPrescriptionDesc(context, "Additional Instructions",
                        controller.additionalInstructionsController),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: getScreenPercentSize(context, 0.5)),
                child: getButtonWidget(context, "Save", primaryColor, () {
                  controller.saveAddress();
                  // Navigator.of(context).pop();
                }),
              )
            ],
          ),
        ));
  }
}
