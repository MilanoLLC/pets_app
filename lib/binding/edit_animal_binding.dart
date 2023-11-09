import 'package:get/get.dart';
import 'package:pets_app/controllers/edit_animal_controller.dart';
import 'package:pets_app/model/AnimalModel.dart';

class EditAnimalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAnimalController>(() {
      return EditAnimalController(AnimalModel());
    });
  }
}
