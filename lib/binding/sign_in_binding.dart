import 'package:get/get.dart';
import 'package:pets_app/controllers/sign_in_controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() {
      return SignInController();
    });
  }
}
