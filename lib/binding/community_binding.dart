import 'package:get/get.dart';
import 'package:pets_app/controllers/community_controller.dart';

class CommunityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityController>(() {
      return CommunityController();
    });
  }
}
