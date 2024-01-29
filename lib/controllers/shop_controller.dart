import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/controllers/pagination_filter_controller.dart';
import 'package:pets_app/model/OrderItemModel.dart';
import 'package:pets_app/model/ServiceModel.dart';
import 'package:pets_app/repositories/shop_repository.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';

class ShopController extends GetxController with StateMixin<dynamic> {
  late final TabController _tabController;

  List<ServiceModel> services = <ServiceModel>[].obs;
  List<ServiceModel> servicesList = <ServiceModel>[].obs;
  List<OrderItemModel> orderItems = <OrderItemModel>[].obs;


  // TextEditingController colorEditingController=TextEditingController();
  var shopRepository = getIt<IShopRepository>();
  var storage = getIt<ILocalStorageService>();
  final _paginationFilter = PaginationFilter().obs;
  final _lastPage = false.obs;

  int get limit => _paginationFilter.value.limit!;
  int get _page => _paginationFilter.value.page!;
  bool get lastPage => _lastPage.value;
  final quantity = 1.obs;

  // String selectedAge = "less";
  // final List<String> age = ["less", "oneTo3", "threeTo6", "more"];
  //
  // String selectedGender = "MALE";
  // final List<String> gender = ["MALE", "FEMALE"];
  //
  // String selectedFriendly = "true";
  // final List<String> friendly = ["true", "false"];
  //
  // String selectedVaccinated = "true";
  // final List<String> vaccinated = ["true", "false"];
  //
  // String dropdownValue = 'Dubai';
  //
  // var items = [
  //   'Abu Dhabi',
  //   'Ajman',
  //   'Dubai',
  //   'Fujairah',
  //   'Ras Al Khaimah',
  //   'Sharjah',
  //   'Umm Al Quwain',
  // ];

  @override
  Future<void> onInit() async {
    super.onInit();
    getAllServicesByTyp("GOODS");

    // await getAllServicesByTyp();
    // ever(_paginationFilter, (_) => getProducts());
    // _changePaginationFilter(0, 8);


    // _tabController = TabController(length: 2, vsync: );

  }

  @override
  void onClose() {}
  Future<void> getAllServicesByTyp(type) async {
    try {
      await shopRepository.getAllServicesByTyp(type).then((value) {
        services = value;
        servicesList = services;
        // for (int i = 0; i < categories.length; i++) {
        //   categoriesNames.add(categories[i].enName!);
        // }
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

  void filterSearchResultsByType(String query) {
    services = servicesList
        .where((item) => item.enName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }

  void addToCart(item,int quantity){

    OrderItemModel orderItem=OrderItemModel();
    orderItem.item=item;
    orderItem.quantity=quantity;
    int foundIndex=orderItems.indexWhere((element) => element.item!.serviceSerial==item.serviceSerial);
    if(foundIndex!=-1){
      OrderItemModel temp=orderItems.where((element) => element.item!.serviceSerial==item.serviceSerial).first;
      temp.quantity=temp.quantity! + quantity;
      orderItems[foundIndex]=temp;
      print("order items  = ${orderItems[0].quantity}");
    }
    else {
      orderItems.add(orderItem);
    }

    storage.set("orders", orderItems);
    update();
  }

  changeQuantity(val){
    quantity.value = int.parse(val.replaceAll(',', ''));
    update();
  }

  Future<void> removeItem( index) async {
    orderItems.remove(orderItems[index]);
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

  // Future<void> getProducts() async {
  //   try {
  //     await homeRepository.getAllAnimals(_page, limit).then((value) {
  //       if (value.isEmpty) {
  //         _lastPage.value = true;
  //       }
  //       products = products + value;
  //       productList = products;
  //       change(value, status: RxStatus.success());
  //     });
  //   } on SocketException catch (ex) {
  //     Get.snackbar('Error', ex.message.tr,
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   } on Exception catch (ex) {
  //     Get.snackbar('Error'.tr, ex.toString(),
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   }
  //   update();
  // }
  //
  // Future<void> getProductsByCategory(String category) async {
  //   try {
  //     await homeRepository.getAllAnimals(_page, limit).then((value) {
  //       if (value.isEmpty) {
  //         _lastPage.value = true;
  //       }
  //
  //       productsByCategory = value
  //           .where(
  //             (u) => (u.category!.enName!.toLowerCase().contains(
  //                   category.toLowerCase(),
  //                 )),
  //           )
  //           .toList();
  //       productListByCategory = productsByCategory;
  //       change(value, status: RxStatus.success());
  //     });
  //   } on SocketException catch (ex) {
  //     Get.snackbar('Error', ex.message.tr,
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   } on Exception catch (ex) {
  //     Get.snackbar('Error'.tr, ex.toString(),
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   }
  //   update();
  // }
  //
  // void changeTotalPerPage(int limitValue) {
  //   products.clear();
  //   _lastPage.value = false;
  //   _changePaginationFilter(1, limitValue);
  // }
  //
  // void _changePaginationFilter(int page, int limit) {
  //   _paginationFilter.update((val) {
  //     val!.page = page;
  //     val.limit = limit;
  //   });
  // }
  //
  // void loadNextPage() {
  //   _changePaginationFilter(_page + 1, limit);
  // }
  //
  // void filterSearchResults(String query) {
  //   print("filterSearchResults");
  //   categories = categoryList
  //       .where((item) =>
  //           item.enName!.toLowerCase().contains(query.toLowerCase()) ||
  //           item.arName!.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  //   update();
  // }
  //
  // void filterSearchResultsByType(String query) {
  //   print("filterSearchResultsByType");
  //   products = productList
  //       .where((item) => item.type!.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  //   update();
  // }
  //
  // void filterSearchResultsByType2(String query) {
  //   print("filterSearchResultsByType");
  //   productsByCategory = productListByCategory
  //       .where((item) => item.type!.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  //   update();
  // }
  //
  // Future<void> filterAnimals() async {
  //   try {
  //     print("filter = " +
  //         selectedAge.toString() +" - "+
  //         colorEditingController.text.toString() +" - "+
  //         selectedFriendly.toString() +" - "+
  //         selectedGender.toString() +" - "+
  //         dropdownValue.toString() +" - "+
  //         selectedVaccinated.toString());
  //     await homeRepository
  //         .filterAnimals(selectedAge, colorEditingController.text, selectedFriendly,
  //             selectedGender, dropdownValue, selectedVaccinated)
  //         .then((value) {
  //       print("value =" + value.statusCode.toString());
  //       print("value =" + value.toString());
  //
  //       if (value.statusCode == 200) {
  //         products = value;
  //       }
  //     });
  //   } on SocketException catch (ex) {
  //     Get.snackbar('Error'.tr, ex.message,
  //         backgroundColor: Colors.black, colorText: Colors.red);
  //   } on Exception catch (ex) {
  //     Get.snackbar('Error'.tr, ex.toString(),
  //         backgroundColor: Colors.black, colorText: Colors.red);
  //   }
  //   update();
  // }
}
