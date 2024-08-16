import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets_app/controllers/product_controller.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/repositories/animal_repository.dart';
import 'package:pets_app/repositories/home_repository.dart';
import 'package:pets_app/service_locator.dart';

class EditAnimalController extends GetxController with StateMixin<dynamic> {
  AnimalModel model;

  EditAnimalController(this.model);
  var homeRepository = getIt<IHomeRepository>();

  var animalRepository = getIt<IAnimalRepository>();
  List<String> categoriesNames = <String>[].obs;
  List<String> agePrefixList = <String>[].obs;
  HashMap categoryMaps = HashMap<String, String>();
  List<AnimalModel> myPets = <AnimalModel>[].obs;

  TextEditingController textColorController = TextEditingController();
  TextEditingController textOriginController = TextEditingController();
  TextEditingController textWeightController = TextEditingController();
  TextEditingController textDescController = TextEditingController();
  TextEditingController textTypeController = TextEditingController();
  TextEditingController textNoOfVaccinatedController = TextEditingController();
  TextEditingController textLocationController = TextEditingController();
  TextEditingController textNameController = TextEditingController();
  TextEditingController textAgeController = TextEditingController();
  TextEditingController textAgePrefixController = TextEditingController();
  List<String> images = [];
  List<String> imagesModel = [];

  String? selectedCategory = "";
  String? selectedAgePrefix = "";

  var isChecked = false.obs;

  String? selectedLocation = "Dubai";
  List<String> locationList = [
    "Abu Dhabi",
    "Dubai",
    "Sharjah",
    "Ajman",
    "Umm Al Quwain",
    "Ras Al Khaimah",
    "Fujairah"
  ];

  String? selectedWeight = "Kilograms";
  List<String> weightList = [
    "Grams",
    "Kilograms",
  ];

  String selectedGender = "MALE";
  final List<String> gender = ["MALE", "FEMALE"];

  String selectedFriendly = "true";
  final List<String> friendly = ["true", "false"];

  String selectedVaccinated = "true";
  final List<String> vaccinated = ["true", "false"];

  String selectedPassport = "true";
  final List<String> passport = ["true", "false"];

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  int activeStep = 0;
  int activeStepIndex = 0;
  int upperBound = 3;

  @override
  Future<void> onInit() async {
    super.onInit();
    Map<String, dynamic> args = Get.arguments;

    model = args['model']!;
    await getCategories();
    await getPetDetails();
    agePrefixList = ["Days", "Weeks", "Months", "Years"];
  }

  getPetDetails() async {
    textNameController.text = model.animalName!;
    textColorController.text = model.color!;
    selectedGender = model.gender!;
    selectedLocation = model.location!;
    selectedFriendly = model.friendly == true ? "true" : "false";
    selectedCategory = model.category!.enName;
    textWeightController.text = model.weight!.toString();
    textDescController.text = model.description!;
    selectedGender = model.gender!;
    textTypeController.text = model.type!;
    selectedVaccinated = model.vaccinated == true ? "true" : "false";
    textNoOfVaccinatedController.text = model.numberOfVaccines!.toString();
    selectedPassport = model.passport == true ? "true" : "false";
    textLocationController.text = model.location!;
    textAgeController.text = model.age!;
    textAgePrefixController.text = model.agePrefix!;
    images = model.images!;
    imagesModel = model.images!;
    selectedAgePrefix = model.agePrefix!;
  }

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    update();
  }

  void removeImages(index) async {
    imageFileList!.removeAt(index);
    update();
  }

  void changeGender(value) {
    selectedGender = value;
    update();
  }

  void changeAgePrefix(value) {
    selectedAgePrefix = value;
    update();
  }

  void changeFriendly(value) {
    selectedFriendly = value;
    update();
  }

  void changeVaccinated(value) {
    selectedVaccinated = value;
    update();
  }

  void changeCategory(value) {
    selectedCategory = value;
    update();
  }

  void changePassport(value) {
    selectedPassport = value;
    update();
  }

  changeChecked(value) {
    isChecked.value = value;
    update();
  }

  void changeWeight(value) {
    selectedWeight = value;
    update();
  }

  void changeLocation(value) {
    selectedLocation = value;
    update();
  }

  Future<void> getCategories() async {
    try {
      await homeRepository.getCategories().then((value) {
        for (int i = 0; i < value.length; i++) {
          categoriesNames.add(value[i].enName!);
          categoryMaps[value[i].enName] = value[i].serial;
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
    selectedCategory = categoriesNames[0];
    update();
  }

  Future<void> getMyPets() async {
    try {
      await animalRepository.getMyAnimals().then((value) {
        myPets = value;
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

  Future<void> editAnimal(serial) async {
    try {
      await animalRepository
          .editAnimal(
              serial,
              selectedGender,
              textColorController.text,
              selectedFriendly,
              textAgePrefixController.text,
              "ADOPTED",
              categoryMaps[selectedCategory],
              textWeightController.text,
              textDescController.text,
              textTypeController.text,
              selectedVaccinated,
              selectedPassport,
              textNoOfVaccinatedController.text,
              textLocationController.text,
              textNameController.text,
              textAgeController.text,
              imageFileList)
          .then((value) {
        if (value.statusCode == 200) {
          getMyPets();
          // ProductController().updateData(myPets);
          Get.find<ProductController>().updateData(myPets);
          Get.back();

          Get.snackbar('Success'.tr, "Animal Edited successfully",
              backgroundColor: Colors.green, colorText: Colors.white);
          update();
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

  nextButton() {
    if (activeStep < upperBound) {
      activeStep++;
      update();
    }
  }

  previousButton() {
    if (activeStep > 0) {
      activeStep--;
      update();
    }
  }

  stepReached(index) {
    activeStep = index;
    update();
  }

  stepCancel() {
    if (activeStepIndex == 0) {
      return;
    }
    activeStepIndex -= 1;
    // update();
  }

  stepTapped(int index) {
    activeStepIndex = index;
    // update();
  }

  stepContinue() {
    if (activeStepIndex < (3)) {
      activeStepIndex += 1;
    } else {
      print('Submited');
    }
    // update();
  }
}
