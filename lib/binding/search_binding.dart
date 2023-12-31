import 'package:get/get.dart';
import 'package:pets_app/controllers/search_controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() {
      return SearchController();
    });
  }
}
