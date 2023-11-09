
import 'package:get/get.dart';
import 'package:pets_app/model/ModelNotification.dart';
import 'package:pets_app/repositories/home_repository.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';

class NotificationController extends GetxController with StateMixin<dynamic> {
  List<ModelNotification> notificationList = <ModelNotification>[].obs;

  var homeRepository = getIt<IHomeRepository>();
  var storage = getIt<ILocalStorageService>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getAllNotification();

  }

  Future<void> getAllNotification() async {
    // notificationList=DataFile.getNotificationList();
    // try {
    //   print("this is get categories");
    //   await homeRepository.getCategories().then((value) {
    //     print("value  = "+value.toString());
    //     notificationList = value;
    //     change(value, status: RxStatus.success());
    //   });
    // } on SocketException catch (ex) {
    //   Get.snackbar('Error', ex.message.tr,
    //       backgroundColor: Colors.red, colorText: Colors.white);
    // } on Exception catch (ex) {
    //   Get.snackbar('Error'.tr, ex.toString(),
    //       backgroundColor: Colors.red, colorText: Colors.white);
    // }
    update();
  }

}
