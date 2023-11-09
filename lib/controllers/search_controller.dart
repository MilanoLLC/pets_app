import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/controllers/pagination_filter_controller.dart';
import 'package:pets_app/model/CategoryModel.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/repositories/home_repository.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';

class SearchController extends GetxController with StateMixin<dynamic> {
  List<CategoryModel> categories = <CategoryModel>[].obs;
  List<CategoryModel> categoryList = <CategoryModel>[].obs;

  List<AnimalModel> products = <AnimalModel>[].obs;
  List<AnimalModel> productList = <AnimalModel>[].obs;
  final _paginationFilter = PaginationFilter().obs;
  final _lastPage = false.obs;

  int get limit => _paginationFilter.value.limit!;
  int get _page => _paginationFilter.value.page!;
  bool get lastPage => _lastPage.value;

  var homeRepository = getIt<IHomeRepository>();
  var storage = getIt<ILocalStorageService>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCategories();
    ever(
        _paginationFilter, (_) => getProductsByCategory(categories[0].enName!));
    _changePaginationFilter(0, 8);
  }

  Future<void> getCategories() async {
    try {
      await homeRepository.getCategories().then((value) {
        categories = value;
        categoryList = categories;
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
        products = products +
            value
                .where(
                  (u) => (u.category!.enName!.toLowerCase().contains(
                        category.toLowerCase(),
                      )),
                )
                .toList();
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
}
