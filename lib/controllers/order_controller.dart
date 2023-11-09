import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/controllers/pagination_filter_controller.dart';
import 'package:pets_app/model/CategoryModel.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/repositories/home_repository.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';

class OrderController extends GetxController with StateMixin<dynamic> {
  List<CategoryModel> categories = <CategoryModel>[].obs;
  List<CategoryModel> categoryList = <CategoryModel>[].obs;
  List<String> categoriesNames = <String>[].obs;

  List<AnimalModel> products = <AnimalModel>[].obs;
  List<AnimalModel> productList = <AnimalModel>[].obs;

  List<AnimalModel> productsByCategory = <AnimalModel>[].obs;
  List<AnimalModel> productListByCategory = <AnimalModel>[].obs;
  TextEditingController colorEditingController=TextEditingController();
  var homeRepository = getIt<IHomeRepository>();
  var storage = getIt<ILocalStorageService>();
  final _paginationFilter = PaginationFilter().obs;
  final _lastPage = false.obs;

  int get limit => _paginationFilter.value.limit!;
  int get _page => _paginationFilter.value.page!;
  bool get lastPage => _lastPage.value;

  String selectedAge = "less";
  final List<String> age = ["less", "oneTo3", "threeTo6", "more"];

  String selectedGender = "MALE";
  final List<String> gender = ["MALE", "FEMALE"];

  String selectedFriendly = "true";
  final List<String> friendly = ["true", "false"];

  String selectedVaccinated = "true";
  final List<String> vaccinated = ["true", "false"];

  String dropdownValue = 'Dubai';

  var items = [
    'Abu Dhabi',
    'Ajman',
    'Dubai',
    'Fujairah',
    'Ras Al Khaimah',
    'Sharjah',
    'Umm Al Quwain',
  ];
  @override
  Future<void> onInit() async {
    super.onInit();
    await getCategories();
    ever(_paginationFilter, (_) => getProducts());
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

  Future<void> getProducts() async {
    try {
      await homeRepository.getAllAnimals(_page, limit).then((value) {
        if (value.isEmpty) {
          _lastPage.value = true;
        }
        products = products + value;
        productList = products;
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

  Future<void> getProductsByCategory(String category) async {
    try {
      await homeRepository.getAllAnimals(_page, limit).then((value) {
        if (value.isEmpty) {
          _lastPage.value = true;
        }

        productsByCategory = value
            .where(
              (u) => (u.category!.enName!.toLowerCase().contains(
                    category.toLowerCase(),
                  )),
            )
            .toList();
        productListByCategory = productsByCategory;
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
    products.clear();
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
    products = productList
        .where((item) => item.type!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }

  void filterSearchResultsByType2(String query) {
    print("filterSearchResultsByType");
    productsByCategory = productListByCategory
        .where((item) => item.type!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }

  Future<void> filterAnimals() async {
    try {
      print("filter = $selectedAge - ${colorEditingController.text} - $selectedFriendly - $selectedGender - $dropdownValue - $selectedVaccinated");
      await homeRepository
          .filterAnimals(selectedAge, colorEditingController.text, selectedFriendly,
              selectedGender, dropdownValue, selectedVaccinated)
          .then((value) {
        print("value =${value.statusCode}");
        print("value =$value");

        if (value.statusCode == 200) {
          products = value;
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
