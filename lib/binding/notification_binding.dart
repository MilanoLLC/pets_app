import 'package:get/get.dart';
import 'package:pets_app/controllers/notification_controller.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() {
      return NotificationController();
    });
  }
}
