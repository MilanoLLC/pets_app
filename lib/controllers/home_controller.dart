import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pets_app/controllers/pagination_filter_controller.dart';
import 'package:pets_app/model/CategoryModel.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/repositories/home_repository.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';

class HomeController extends GetxController with StateMixin<dynamic> {
  List<CategoryModel> categories = <CategoryModel>[].obs;
  List<CategoryModel> categoryList = <CategoryModel>[].obs;
  List<String> categoriesNames = <String>[].obs;

  List<AnimalModel> animals = <AnimalModel>[].obs;
  List<AnimalModel> animalList = <AnimalModel>[].obs;

  List<AnimalModel> animalsByCategory = <AnimalModel>[].obs;
  List<AnimalModel> animalListByCategory = <AnimalModel>[].obs;
  TextEditingController colorEditingController = TextEditingController();
  var homeRepository = getIt<IHomeRepository>();
  var storage = getIt<ILocalStorageService>();
  final _paginationFilter = PaginationFilter().obs;
  final _lastPage = false.obs;

  int get limit => _paginationFilter.value.limit!;
  int get _page => _paginationFilter.value.page!;
  bool get lastPage => _lastPage.value;

  String selectedAge = "less";
  // final List<String> age = ["less", "oneTo3", "threeTo6", "more"];

  String selectedGender = "MALE";
  // final List<String> gender = ["MALE", "FEMALE"];

  String selectedFriendly = "true";
  // final List<String> friendly = ["true", "false"];

  String selectedVaccinated = "true";
  // final List<String> vaccinated = ["true", "false"];

  String selectedLocation = 'Dubai';

  static List<Emarite> emirateList = [
    Emarite(name: "Abu Dhabi"),
    Emarite(name: "Ajman"),
    Emarite(name: "Dubai"),
    Emarite(name: "Fujairah"),
    Emarite(name: "Ras Al Khaimah"),
    Emarite(name: "Sharjah"),
    Emarite(name: "Umm Al Quwain"),
  ];
  final emirates = emirateList
      .map((element) => MultiSelectItem<Emarite?>(element, element.name))
      .toList();

  static List<Age> agesList = [
    Age(name: "Less Than 1 Year"),
    Age(name: "1 to 3 Years"),
    Age(name: "3 to 6 Years"),
    Age(name: "More Than 6 Years"),
  ];

  final ages = agesList
      .map((element) => MultiSelectItem<Age?>(element, element.name))
      .toList();

  static List<Gender> genderList = [
    Gender(name: "Male"),
    Gender(name: "Female"),
  ];

  final gender = genderList
      .map((element) => MultiSelectItem<Gender?>(element, element.name))
      .toList();


  static List<Friendly> friendlyList = [
    Friendly(name: "Friendly"),
    Friendly(name: "UnFriendly"),
  ];
  final friendly = friendlyList
      .map((element) => MultiSelectItem<Friendly?>(element, element.name))
      .toList();

  static List<Vaccinated> vaccinatedList = [
    Vaccinated(name: "Vaccinated"),
    Vaccinated(name: "UnVaccinated"),
  ];

  final vaccinated = vaccinatedList
      .map((element) => MultiSelectItem<Vaccinated?>(element, element.name))
      .toList();

  static List<Color> colorList = [
    Color(name: "Orange"),
    Color(name: "Black"),
    Color(name: "white"),
    Color(name: "Grey"),
  ];
  final colors = colorList
      .map((element) => MultiSelectItem<Color?>(element, element.name))
      .toList();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCategories();
    ever(_paginationFilter, (_) => getanimals());
    _changePaginationFilter(0, 8);
  }

  @override
  void onClose() {}
  Future<void> getCategories() async {
    try {
      await homeRepository.getCategories().then((value) {
        categories = value;
        categoryList = categories;
        for (int i = 0; i < categories.length; i++) {
          categoriesNames.add(categories[i].enName!);
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


  // void changeGender(value) {
  //   selectedGender = value;
  //   update();
  // }
  //
  // void changeAge(value) {
  //   selectedAge = value;
  //   update();
  // }
  // void changeFriendly(value) {
  //   selectedFriendly = value;
  //   update();
  // }
  //
  // void changeVaccinated(value) {
  //   selectedVaccinated = value;
  //   update();
  // }

  Future<void> getanimals() async {
    try {
      await homeRepository.getAllAnimals(_page, limit).then((value) {
        if (value.isEmpty) {
          _lastPage.value = true;
        }
        animals = animals + value;
        animalList = animals;
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

  Future<void> getAnimalsByCategory(String category) async {
    try {
      await homeRepository.getAllAnimals(_page, limit).then((value) {
        if (value.isEmpty) {
          _lastPage.value = true;
        }

        animalsByCategory = value
            .where(
              (u) => (u.category!.enName!.toLowerCase().contains(
                    category.toLowerCase(),
                  )),
            )
            .toList();
        animalListByCategory = animalsByCategory;
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

  void changeTotalPerPage(int limitValue) {
    animals.clear();
    _lastPage.value = false;
    _changePaginationFilter(1, limitValue);
  }

  void _changePaginationFilter(int page, int limit) {
    _paginationFilter.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void loadNextPage() {
    _changePaginationFilter(_page + 1, limit);
  }

  void filterSearchResults(String query) {
    print("filterSearchResults");
    categories = categoryList
        .where((item) =>
            item.enName!.toLowerCase().contains(query.toLowerCase()) ||
            item.arName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }

  void filterSearchResultsByType(String query) {
    print("filterSearchResultsByType");
    animals = animalList
        .where((item) => item.type!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }

  void filterSearchResultsByType2(String query) {
    print("filterSearchResultsByType");
    animalsByCategory = animalListByCategory
        .where((item) => item.type!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }

  Future<void> filterAnimals() async {
    try {
      // print("filter = $selectedAge - ${colorEditingController.text} - $selectedFriendly - $selectedGender - $dropdownValue - $selectedVaccinated");
      await homeRepository
          .filterAnimals(
              selectedAge,
              colorEditingController.text,
              selectedFriendly,
              selectedGender,
              selectedLocation,
              selectedVaccinated)
          .then((value) {
        // print("value =${value.statusCode}");
        // print("value =$value");

        if (value.statusCode == 200) {
          animals = value;
        }
      });
    } on SocketException catch (ex) {
      Get.snackbar('Error'.tr, ex.message,
          backgroundColor: Colors.black, colorText: Colors.red);
    } on Exception catch (ex) {
      Get.snackbar('Error'.tr, ex.toString(),
          backgroundColor: Colors.black, colorText: Colors.red);
    }
    update();
  }
}

class Emarite {
  // final int id;
  final String name;
  Emarite({
    // required this.id,
    required this.name,
  });
}

class Color {
  // final int id;
  final String name;
  Color({
    // required this.id,
    required this.name,
  });
}


class Age {
  // final int id;
  final String name;
  Age({
    // required this.id,
    required this.name,
  });
}

class Gender {
  // final int id;
  final String name;
  Gender({
    // required this.id,
    required this.name,
  });
}

class Friendly {
  // final int id;
  final String name;
  Friendly({
    // required this.id,
    required this.name,
  });
}

class Vaccinated {
  // final int id;
  final String name;
  Vaccinated({
    // required this.id,
    required this.name,
  });
}
