import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/repositories/auth_repository.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';

class SignUpController extends GetxController with StateMixin<dynamic> {
  var authService = getIt<IAuthRepository>();

  var storage = getIt<ILocalStorageService>();
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textFirstNameController = TextEditingController();
  TextEditingController textLastNameController = TextEditingController();
  TextEditingController textUserNameController = TextEditingController();
  TextEditingController textPhoneController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  var textCountryController = TextEditingController().obs;

  final formKey = GlobalKey<FormState>();

  String sourceDropdownValue = 'Social Media';
  bool isTermsCondition = false;
  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;

  Future<bool> register() async {
    try {
      await authService
          .register(
              textCountryController.value.text,
              textEmailController.text,
              textFirstNameController.text,
              textLastNameController.text,
              textPasswordController.text,
              textPhoneController.text,
              textUserNameController.text)
          .then((value) {
        if (value == 200) {
          Get.offAllNamed(Routes.SIGNIN);

          // Get.offAllNamed(Routes.VERIFY);
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

  void checkTerms() {
    if (isTermsCondition) {
      isTermsCondition = false;
    } else {
      isTermsCondition = true;
    }
  }

  focus(hasFocus){
    if (hasFocus) {
        isAutoFocus = true;
    } else {
        isAutoFocus = false;
    }
  }

  flagChanged(val){
    textCountryController
        .value.text = val!;
  }

  phoneChanged(val){
    textPhoneController
        .value = val!;
  }
}
