import 'package:get/get.dart';
import 'package:pets_app/controllers/shop_controller.dart';

class ShopBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopController>(() {
      return ShopController();
    });
  }
}
