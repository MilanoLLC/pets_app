// ignore_for_file: must_be_immutable, no_logic_in_create_state, use_key_in_widget_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:pets_app/controllers/product_controller.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/empty_widget.dart';
import 'package:pets_app/widgets/my_pet_widget.dart';

class MyPetPage extends GetView<ProductController> {
  const MyPetPage({Key? key}) : super(key: key);

  Future<bool> _requestPop() {
    Get.back();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GetBuilder<ProductController>(
        init: ProductController(),
        builder: (controller) {
          return WillPopScope(
              onWillPop: _requestPop,
              child: Scaffold(
                appBar: appBarCustom(
                    context,
                    "My Pets",
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.NEWPET);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Center(
                            child: Row(
                          children: [
                            // Text("Add Pet",style: TextStyle(fontSize: 14,color: primaryColor),),
                            Icon(
                              Icons.add,
                              color: primaryColor,
                            ),
                          ],
                        )),
                      ),
                    ),
                    true),
                body: (controller.isLoading.value)
                    ? const Center(
                        child: CircularProgressIndicator()) // Show loader
                    : Column(
                        children: [
                          SizedBox(
                            height: getScreenPercentSize(context, 1.5),
                          ),
                          Expanded(
                              flex: 1,
                              child: controller.myPets.isNotEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller.myPets.length,
                                          itemBuilder: (context, index) {
                                            AnimalModel model =
                                                controller.myPets[index];
                                            return myPetWidget(context, model,
                                                () {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.warning,
                                                headerAnimationLoop: true,
                                                animType: AnimType.bottomSlide,
                                                title: 'Are you sure?',
                                                btnOkOnPress: () {
                                                  Loader.show(context,
                                                      isSafeAreaOverlay: false,
                                                      progressIndicator:
                                                          const CircularProgressIndicator(),
                                                      isBottomBarOverlay: false,
                                                      overlayFromBottom: 0,
                                                      themeData: Theme.of(context).copyWith(
                                                          colorScheme: ColorScheme
                                                                  .fromSwatch()
                                                              .copyWith(
                                                                  secondary: Colors
                                                                      .black38)),
                                                      overlayColor: const Color(
                                                          0x33E8EAF6));

                                                  controller
                                                      .removeItem(
                                                          controller
                                                              .myPets[index]
                                                              .serial,
                                                          index)
                                                      .then((value) =>
                                                          Loader.hide());
                                                },
                                                btnOkText: "ok",
                                                btnCancelOnPress: () {},
                                              ).show();
                                            });
                                          }),
                                    )
                                  : Center(
                                      child: emptyWidgetWithButton(
                                          context,
                                          "",
                                          Icons.pets,
                                          "Your Pets are Empty!",
                                          "You can add your pet",
                                          "Add New Pet",
                                          Get.toNamed(Routes.NEWPET)),
                                    )),
                        ],
                      ),
              ));
        });
  }
}
