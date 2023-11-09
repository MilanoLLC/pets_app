import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/repositories/auth_repository.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';

class EditProfileController extends GetxController with StateMixin<dynamic> {
  var authRepository = getIt<IAuthRepository>();
  var storage = getIt<ILocalStorageService>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  @override
  Future<void> onInit() async {
    super.onInit();
    await getUserInfoByToken();
  }

  Future<void> getUserInfoByToken() async {
    try {
      await authRepository.getUserInfoByToken().then((value) {
        firstNameController.text = value.firstName!;
        lastNameController.text = value.lastName!;
        phoneController.text = value.phoneNumber!;
        countryCodeController.text = value.countryPhoneCode!;
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

  Future<bool> modify() async {
    try {
      await authRepository
          .modify(
        firstNameController.value.text,
        lastNameController.text,
        phoneController.text,
        countryCodeController.text,
      )
          .then((value) {
        if (value == 200) {
          Get.back();
          Get.snackbar('Success'.tr, "your Profile is Updated successfully",
              backgroundColor: Colors.green, colorText: Colors.white);
          return true;
        }
      });
    } on SocketException catch (ex) {
      Get.snackbar('Error'.tr, ex.message,
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } on Exception catch (ex) {
      Get.snackbar('Error'.tr, ex.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    return false;
  }

  flagChanged(val) {
    countryCodeController.text = val!;
  }

  countryChanged(val) {
    countryController.text = val!;
  }

  phoneChanged(val) {
    phoneController.text = val!;
  }
}
