import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/repositories/auth_repository.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';

class SignInController extends GetxController with StateMixin<dynamic> {
  var authService = getIt<IAuthRepository>();

  var storage = getIt<ILocalStorageService>();

  TextEditingController textNameController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String sourceDropdownValue = 'Social Media';

  bool isBusy = false;

  Future<void> login() async {
    try {
      isBusy = true;
      await authService
          .login(textNameController.text, textPasswordController.text)
          .then((value) {


        if (value == true) {
          Get.offAllNamed(Routes.MAIN);

        }

      });
    } on SocketException catch (ex) {
      isBusy = false;
      Get.snackbar('Error'.tr, ex.message,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void logout(){
    storage.clearUserData();
    Get.toNamed(Routes.SIGNIN);

  }
}
