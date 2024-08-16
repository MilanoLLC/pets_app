import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/repositories/adoption_repository.dart';
import 'package:pets_app/repositories/animal_repository.dart';
import 'package:pets_app/repositories/home_repository.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';

class ProductController extends GetxController with StateMixin<dynamic> {
  List<String> categoriesNames = <String>[].obs;
  HashMap categoryMaps = HashMap<String, String>();
  var homeRepository = getIt<IHomeRepository>();
  var animalRepository = getIt<IAnimalRepository>();
  var adoptRepository = getIt<IAdoptionRepository>();
  var storage = getIt<ILocalStorageService>();

  List<AnimalModel> myPets = <AnimalModel>[].obs;
  AnimalModel animalModel = AnimalModel();
  late String serial;
  var isLoading = true.obs;
  bool isTermsCondition = false;

  TextEditingController textColorController = TextEditingController();
  TextEditingController textOriginController = TextEditingController();
  TextEditingController textWeightController = TextEditingController();
  TextEditingController textDescController = TextEditingController();
  TextEditingController textTypeController = TextEditingController();
  TextEditingController textNoOfVaccinatedController = TextEditingController();
  TextEditingController textLocationController = TextEditingController();
  TextEditingController textNameController = TextEditingController();
  TextEditingController textAgeController = TextEditingController();

  int activeStep = 0;
  int upperBound = 3;
  int activeStepIndex = 0;

  var isChecked = false.obs;

  String? selectedCategory = "";

  String? selectedAgePrefix = "Days";
  List<String> agePrefixList = ["Days", "Weeks", "Months", "Years"];

  String? selectedWeight = "Kilograms";
  List<String> weightList = [
    "Grams",
    "Kilograms",
  ];

  String? selectedLocation = "Abu Dhabi";
  List<String> locationList = [
    "Abu Dhabi",
    "Dubai",
    "Sharjah",
    "Ajman",
    "Umm Al Quwain",
    "Ras Al Khaimah",
    "Fujairah"
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

  @override
  Future<void> onInit() async {
    super.onInit();

    await getCategories();
    var token = storage.get(STORAGE_KEYS.token);
    if (token != null) {
      await getMyPets();
    }
    isLoading.value = false;
  }

  void updateData(List<AnimalModel> newData) {
    isLoading.value = true;
    myPets = newData;
    onInit();
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

  void changeAgePrefix(value) {
    selectedAgePrefix = value;
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

  void changePassport(value) {
    selectedPassport = value;
    update();
  }

  changeChecked(value) {
    isChecked.value = value;
    update();
  }

  Future<void> getCategories() async {
    try {
      await homeRepository.getCategories().then((value) {
        for (int i = 0; i < value.length; i++) {
          categoriesNames.add(value[i].enName!);
          categoryMaps[value[i].enName] = value[i].serial;
        }
        selectedCategory = categoriesNames[0];

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

  Future<void> saveAnimal() async {
    try {
      await animalRepository
          .saveAnimal(
              selectedGender,
              textColorController.text,
              selectedFriendly,
              selectedAgePrefix,
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
          Get.back();

          getMyPets();
          Get.snackbar('Success'.tr, "Animal added successfully",
              backgroundColor: Colors.green, colorText: Colors.white);
        }
      });
    } on SocketException catch (ex) {
      Get.snackbar('Error'.tr, ex.message,
          backgroundColor: Colors.black, colorText: Colors.red);
    } on Exception catch (ex) {
      Get.snackbar('Error'.tr, ex.toString(),
          backgroundColor: Colors.black, colorText: Colors.red);
    }
  }

  Future<void> getMyPets() async {
    try {
      isLoading.value = true; // Show loader

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

  Future<void> removeItem(animalSerial, index) async {
    myPets.remove(myPets[index]);
    try {
      await animalRepository.delete(animalSerial).then((value) {
        if (value.statusCode == 200) {
          Get.snackbar('Success'.tr, "Animal removed successfully",
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

  Future<void> adopt(serial) async {
    try {
      await adoptRepository.adopt(serial).then((value) {
        if (value == 200) {
          Get.back();
          Get.snackbar('Success'.tr, "Animal adopted successfully",
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
    } else {}
    // update();
  }

  void checkTerms() {
    if (isTermsCondition) {
      isTermsCondition = false;
    } else {
      isTermsCondition = true;
    }
    update();
  }

  void agreeTerms() {
    isTermsCondition = true;
    update();
  }
}
