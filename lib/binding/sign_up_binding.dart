import 'package:get/get.dart';
import 'package:pets_app/controllers/sign_up_controller.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() {
      return SignUpController();
    });
  }
}
