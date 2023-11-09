import 'package:get/get.dart';
import 'package:pets_app/controllers/verify_controller.dart';

class VerifyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyController>(() {
      return VerifyController();
    });
  }
}
