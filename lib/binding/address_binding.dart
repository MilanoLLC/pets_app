import 'package:get/get.dart';
import 'package:pets_app/controllers/address_controller.dart';

class AddressBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(() {
      return AddressController();
    });
  }
}
