import 'package:get/get.dart';
import 'package:pets_app/controllers/edit_post_controller.dart';
import 'package:pets_app/model/Post_model.dart';

class EditPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPostController>(() {
      return EditPostController(PostModel());
    });
  }
}
