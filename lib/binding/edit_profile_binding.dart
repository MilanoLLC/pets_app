import 'package:get/get.dart';
import 'package:pets_app/controllers/edit_profile_controller.dart';

class EditProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() {
      return EditProfileController();
    });
  }
}
