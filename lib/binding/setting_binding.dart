import 'package:get/get.dart';
import 'package:pets_app/controllers/setting_controller.dart';

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() {
      return SettingController();
    });
  }
}
