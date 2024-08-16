import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/model/AddressModel.dart';
import 'package:pets_app/repositories/auth_repository.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';

class AddressController extends GetxController with StateMixin<dynamic> {
  var authRepository = getIt<IAuthRepository>();
  var storage = getIt<ILocalStorageService>();
  bool haveAddress=false;

  TextEditingController additionalInstructionsController =
      TextEditingController();
  TextEditingController apartmentNumberController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();

  getAddressDetail(AddressModel model) {
    additionalInstructionsController.text = model.additionalInstructions!;
    apartmentNumberController.text = model.apartmentNumber!;
    buildingController.text = model.building!;
    cityController.text = model.city!;
    streetController.text = model.street!;
  }

  saveAddress() async {
    try {
      await authRepository
          .saveAddress(
              additionalInstructionsController.text,
              apartmentNumberController.text,
              buildingController.text,
              cityController.text,
              streetController.text)
          .then((value) {
        if (value.statusCode == 200) {
          Get.snackbar('Success'.tr, "Address added successfully",
              backgroundColor: Colors.green, colorText: Colors.white);
        }
        change(value, status: RxStatus.success());
      });
    } on SocketException catch (ex) {
      Get.snackbar('Error', ex.message.tr,
          backgroundColor: Colors.red, colorText: Colors.white);
    } on Exception catch (ex) {
      Get.snackbar('Error'.tr, ex.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    update();
  }

}
