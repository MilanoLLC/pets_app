import 'package:get/get.dart';
import 'package:pets_app/controllers/product_controller.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() {
      return ProductController();
    });
  }
}
