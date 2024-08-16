import 'package:get/get.dart';
import 'package:pets_app/controllers/community_profile_controller.dart';
import 'package:pets_app/model/Post_model.dart';

class CommunityProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityProfileController>(() {
      return CommunityProfileController(PostModel());
    });
  }
}
