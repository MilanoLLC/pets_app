import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets_app/model/Post_model.dart';
import 'package:pets_app/repositories/community_repository.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/service_locator.dart';

class EditPostController extends GetxController with StateMixin<dynamic> {
  PostModel model;
  EditPostController(this.model);

  var communityRepository = getIt<ICommunityRepository>();
  TextEditingController textContentController = TextEditingController();
  List<String> images = [];
  String? selectedCategory = "";
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    Map<String, dynamic> args = Get.arguments;
    model = args['editPost']!;
    await getPostDetails();
  }

  getPostDetails() async {
    textContentController.text = model.postContent!;
    images = model.images!;
  }

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    update();
  }

  Future<void> editPost(postSerial) async {
    try {
      await communityRepository
          .editPost(postSerial, textContentController.text, imageFileList)
          .then((value) {
        if (value.statusCode == 200) {
          Get.snackbar('Success'.tr, "Post edited successfully",
              backgroundColor: Colors.green, colorText: Colors.white);
          Get.offAndToNamed(Routes.MYPOST);
        }
      });
    } on SocketException catch (ex) {
      Get.snackbar('Error'.tr, ex.message,
          backgroundColor: Colors.red, colorText: Colors.white);
    } on Exception catch (ex) {
      Get.snackbar('Error'.tr, ex.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
