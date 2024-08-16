// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:im_stepper/stepper.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pets_app/controllers/edit_animal_controller.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/button_widget.dart';
import 'package:pets_app/widgets/photos_widget.dart';

class EditPetPage extends StatelessWidget {
  dynamic argumentData = Get.arguments;
  TextEditingController controllerTest = TextEditingController();

  EditPetPage({Key? key}) : super(key: key);

  Future<bool> _requestPop() {
    Get.back();
    return Future.value(true);
  }

  double defaultMargin = 0;
  double defMargin = 0;
  double fontSize = 0;
  double cellHeight = 0;

  @override
  Widget build(BuildContext context) {
    AnimalModel model = argumentData['model'];
    SizeConfig().init(context);

    defaultMargin = getHorizontalSpace(context);
    cellHeight = getScreenPercentSize(context, 6.5);
    defMargin = getHorizontalSpace(context);
    fontSize = getPercentSize(cellHeight, 28);

    return LoaderOverlay(
      child: GetBuilder<EditAnimalController>(
          init: EditAnimalController(model),
          builder: (controller) {
            print("model pet");
            print(model.toJson());

            return Scaffold(
                appBar: appBarBack(context, "Edit Pet", true),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconStepper(
                        icons: const [
                          Icon(Icons.first_page),
                          Icon(Icons.pets),
                          Icon(Icons.last_page),
                        ],
                        activeStep: controller.activeStep,
                        activeStepColor: primaryColor,
                        stepColor: Colors.grey.withOpacity(0.2),
                        onStepReached: (index) {
                          controller.stepReached(index);
                        },
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: stepperWidget(controller, context),
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: buttonWidget(
                                context, "Previous", Colors.white, primaryColor,
                                () {
                              controller.previousButton();
                            }),
                          ),

                          Expanded(
                              child: controller.activeStep == 2
                                  ? buttonWidget(context, "Update",
                                      primaryColor, Colors.white, () {
                                      Loader.show(context,
                                          isSafeAreaOverlay: false,
                                          progressIndicator:
                                              const CircularProgressIndicator(),
                                          isBottomBarOverlay: false,
                                          overlayFromBottom: 0,
                                          themeData: Theme.of(context).copyWith(
                                              colorScheme:
                                                  ColorScheme.fromSwatch()
                                                      .copyWith(
                                                          secondary:
                                                              Colors.black38)),
                                          overlayColor:
                                              const Color(0x33E8EAF6));

                                      controller
                                          .editAnimal(model.serial)
                                          .then((value) => Loader.hide());
                                    })
                                  : buttonWidget(context, "Next", primaryColor,
                                      Colors.white, () {
                                      controller.nextButton();
                                    }))

                          // previousButton(),
                          // nextButton(),
                        ],
                      ),
                    ],
                  ),
                ));
          }),
    );
  }

  Widget stepperWidget(controller, context) {
    double margin = getScreenPercentSize(context, 1.2);
    double height = getScreenPercentSize(context, 17);

    switch (controller.activeStep) {
      case 0:
        return ListView(
          children: [
            getTextFiledTitleWidget(context, "", controller.textNameController,
                "Pet Name", TextInputType.text),
            SizedBox(
              height: margin,
            ),
            const Text(
              "Category",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
            getDropDownWidget(context, controller.selectedCategory!,
                controller.categoriesNames, controller.changeCategory),
            SizedBox(
              height: margin,
            ),
            getTextFiledTitleWidget(context, "", controller.textTypeController,
                "Type", TextInputType.text),
            SizedBox(
              height: margin,
            ),
            controller.images.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pet Photos",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      showListOfImagesWidget(
                          context, controller, controller.imagesModel)
                    ],
                  )
                : const SizedBox(),
            SizedBox(
              height: margin * 2,
            ),
            const Text(
              "Upload Photos",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                controller.selectImages();
              },
              child: Container(
                height: 80,
                decoration: getShapeDecoration(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "${assetsPath}camera fill.png",
                      height: getPercentSize(height, 15),
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: getWidthPercentSize(context, 2),
                    ),
                    Text('Photos/Videos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: getPercentSize(height, 12),
                            decoration: TextDecoration.none,
                            fontFamily: customFontFamily,
                            color: primaryColor))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: margin * 2,
            ),
            controller.imageFileList!.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Uploading Photos",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      listOfImagesWidget(context, controller)
                    ],
                  )
                : const SizedBox(),
          ],
        );

      case 1:
        return ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Location",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
            getDropDownWidget(context, controller.selectedLocation!,
                controller.locationList, controller.changeLocation),
            SizedBox(
              height: margin,
            ),
            const Text(
              "Gender",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
            SizedBox(
              height: margin,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getRadioButton(context, "Male", controller.gender[0],
                    controller.selectedGender, controller.changeGender),
                const SizedBox(
                  width: (8),
                ),
                getRadioButton(context, "Female", controller.gender[1],
                    controller.selectedGender, controller.changeGender),
              ],
            ),
            SizedBox(
              height: margin * 2,
            ),
            getTextFiledTitleWidget(context, "", controller.textColorController,
                "Color", TextInputType.text),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: getTextFiledTitleWidget(
                      context,
                      "",
                      controller.textWeightController,
                      "Weight",
                      TextInputType.number),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: getDropDownWidget(
                        context,
                        controller.selectedWeight!,
                        controller.weightList,
                        controller.changeWeight),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: getTextFiledTitleWidget(
                      context,
                      "",
                      controller.textAgeController,
                      "Age",
                      TextInputType.number),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: getDropDownWidget(
                        context,
                        controller.selectedAgePrefix!,
                        controller.agePrefixList,
                        controller.changeAgePrefix),
                  ),
                )
              ],
            ),
          ],
        );

      case 2:
        return ListView(
          children: [
            const Text(
              "Vaccinated",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                getRadioButton(context, "Yes", controller.vaccinated[0],
                    controller.selectedVaccinated, controller.changeVaccinated),
                const SizedBox(
                  width: (10),
                ),
                getRadioButton(context, "No", controller.vaccinated[1],
                    controller.selectedVaccinated, controller.changeVaccinated),
              ],
            ),
            SizedBox(
              height: margin * 2,
            ),
            controller.selectedVaccinated == "true"
                ? getTextFiledTitleWidget(
                    context,
                    "",
                    controller.textNoOfVaccinatedController,
                    "Number of vaccines",
                    TextInputType.number)
                : const SizedBox(),
            SizedBox(
              height: margin,
            ),
            const Text(
              "Passport",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                getRadioButton(context, "Yes", controller.passport[0],
                    controller.selectedPassport, controller.changePassport),
                const SizedBox(
                  width: (10),
                ),
                getRadioButton(context, "No", controller.passport[1],
                    controller.selectedPassport, controller.changePassport),
              ],
            ),
            SizedBox(
              height: margin * 2,
            ),
            const Text(
              "Friendly",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                getRadioButton(context, "Yes", controller.friendly[0],
                    controller.selectedFriendly, controller.changeFriendly),
                const SizedBox(
                  width: (10),
                ),
                getRadioButton(context, "No", controller.friendly[1],
                    controller.selectedFriendly, controller.changeFriendly),
              ],
            ),
            SizedBox(
              height: margin * 2,
            ),
            const Text(
              "More Description",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            textFiledWidgetLarge(context, "", controller.textDescController),
          ],
        );

      default:
        return Text("Default");
    }
  }
}
