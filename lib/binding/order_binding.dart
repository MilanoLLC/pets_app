import 'package:get/get.dart';
import 'package:pets_app/controllers/order_controller.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() {
      return OrderController();
    });
  }
}
