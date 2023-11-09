// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pets_app/controllers/edit_animal_controller.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:get/get.dart';

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
    // final controller = Get.put(EditAnimalController(model));

    SizeConfig().init(context);
    defaultMargin = getHorizontalSpace(context);
    double margin = getWidthPercentSize(context, 2.5);
    double height = getScreenPercentSize(context, 17);
    cellHeight = getScreenPercentSize(context, 6.5);
    defMargin = getHorizontalSpace(context);
    fontSize = getPercentSize(cellHeight, 28);
    return LoaderOverlay(
      child: GetBuilder<EditAnimalController>(
          init: EditAnimalController(model),
          builder: (controller) {
            return Scaffold(
              // backgroundColor: backgroundColor,
              appBar: AppBar(
                title: const Text("Edit Pet Details"),
                elevation: 0,
                centerTitle: true,
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: margin,
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      shrinkWrap: true,
                      primary: true,
                      padding: EdgeInsets.symmetric(horizontal: defMargin),
                      children: [
                        //
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 350,
                            child: Swiper(
                              outer: false,
                              itemBuilder: (BuildContext context, int index) {
                                return Image.network(
                                  networkPath + model.images![index],
                                  fit: BoxFit.fill,
                                );
                              },
                              pagination: const SwiperPagination(
                                  margin: EdgeInsets.all(5.0)),
                              itemCount: model.images!.length,
                            )),
                        SizedBox(
                          height: margin,
                        ),
                        SizedBox(
                          height: margin,
                        ),

                        getTextFiledNewPetWidget(context, "",
                            controller.textNameController, "Animal Name"),
                        SizedBox(
                          height: margin,
                        ),
                        getTextFiledNewPetWidget(
                            context, "", controller.textColorController, "Color"),
                        SizedBox(
                          height: margin,
                        ),
                        //gender
                        const Text(
                          "Gender",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          children: [
                            getRadioButton(
                                context,
                                "Male",
                                controller.gender[0],
                                controller.selectedGender,
                                controller.changeGender),
                            SizedBox(
                              width: (margin),
                            ),
                            getRadioButton(
                                context,
                                "Female",
                                controller.gender[1],
                                controller.selectedGender,
                                controller.changeGender),
                          ],
                        ),
                        //friendly
                        SizedBox(
                          height: margin,
                        ),
                        const Text(
                          "Friendly",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          children: [
                            getRadioButton(
                                context,
                                "Yes",
                                controller.friendly[0],
                                controller.selectedFriendly,
                                controller.changeFriendly),
                            SizedBox(
                              width: (margin),
                            ),
                            getRadioButton(
                                context,
                                "No",
                                controller.friendly[1],
                                controller.selectedFriendly,
                                controller.changeFriendly),
                          ],
                        ),
                        // SizedBox(
                        //   height: margin,
                        // ),
                        // getTextFiledNewPetWidget(context, "",
                        //     controller.textOriginController, "Origin"),
                        SizedBox(
                          height: margin,
                        ),
                        const Text(
                          "Category",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        getDropDownWidget(
                            context,
                            controller.selectedCategory!,
                            controller.categoriesNames,
                            controller.changeCategory),
                        SizedBox(
                          height: margin,
                        ),
                        getTextFiledNewPetWidget(context, "",
                            controller.textWeightController, "Weight"),
                        SizedBox(
                          height: margin,
                        ),
                        const Text(
                          "Description",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        getDescTextFiledWidget(
                            context, "", controller.textDescController),
                        SizedBox(
                          height: margin,
                        ),
                        getTextFiledNewPetWidget(
                            context, "", controller.textTypeController, "Type"),
                        SizedBox(
                          height: margin,
                        ),
                        const Text(
                          "Vaccinated",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          children: [
                            getRadioButton(
                                context,
                                "Yes",
                                controller.vaccinated[0],
                                controller.selectedVaccinated,
                                controller.changeVaccinated),
                            SizedBox(
                              width: (margin),
                            ),
                            getRadioButton(
                                context,
                                "No",
                                controller.vaccinated[1],
                                controller.selectedVaccinated,
                                controller.changeVaccinated),
                          ],
                        ),
                        SizedBox(
                          height: margin,
                        ),
                        getTextFiledNewPetWidget(
                            context,
                            "",
                            controller.textNoOfVaccinatedController,
                            "No of Vaccinated"),
                        SizedBox(
                          height: margin,
                        ),
                        const Text(
                          "Passport",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          children: [
                            getRadioButton(
                                context,
                                "Yes",
                                controller.passport[0],
                                controller.selectedPassport,
                                controller.changePassport),
                            SizedBox(
                              width: (margin),
                            ),
                            getRadioButton(
                                context,
                                "No",
                                controller.passport[1],
                                controller.selectedPassport,
                                controller.changePassport),
                          ],
                        ),
                        SizedBox(
                          height: margin,
                        ),
                        getTextFiledNewPetWidget(context, "",
                            controller.textLocationController, "Location"),

                        SizedBox(
                          height: margin,
                        ),
                        getTextFiledNewPetWidget(
                            context, "", controller.textAgeController, "Age"),

                        SizedBox(
                          height: margin,
                        ),
                        const Text(
                          "Age prefix",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        getDropDownWidget(
                            context,
                            controller.selectedAgePrefix!,
                            controller.agePrefixList,
                            controller.changeAgePrefix),
                        SizedBox(
                          height: margin,
                        ),
                        const Text(
                          "List of Images",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () {
                            controller.selectImages();
                          },
                          child: Container(
                            height: height,
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
                                // getTextWithFontFamilyWidget(
                                //     'Add Photo',
                                //     primaryColor,
                                //     getPercentSize(height, 12),
                                //     FontWeight.w500,
                                //     TextAlign.center)
                                Text('Add Photo',
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
                        ),SizedBox(
                          height: margin,
                        ),
                        SizedBox(
                          height: margin,
                        ),
                        controller.imageFileList!.isNotEmpty
                            ? Column( crossAxisAlignment:
                        CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "List of Images",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: height,
                              decoration: getShapeDecoration(context),
                              width: MediaQuery.of(context).size.width,
                              // height: 150,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Expanded(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      primary: true,
                                      children: List.generate(
                                          controller.imageFileList!.length,
                                              (index) {
                                            return Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Image.file(File(controller
                                                  .imageFileList![0].path)),
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                            : const SizedBox()
                      ],
                    ),
                  ),
                  getButtonWidget(context, "Save", primaryColor, () {
                    Loader.show(context,
                        isSafeAreaOverlay: false,
                        progressIndicator: const CircularProgressIndicator(),
                        isBottomBarOverlay: false,
                        overlayFromBottom: 0,
                        themeData: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.fromSwatch()
                                .copyWith(secondary: Colors.black38)),
                        overlayColor: const Color(0x33E8EAF6));

                    controller.editAnimal(model.serial).then((value) => Loader.hide());
                  
                  }),
                  SizedBox(
                    height: margin,
                  )
                ],
              ),
            );
          }),
    );
  }

  getTitle(BuildContext context, String string) {
    return Container(
      margin: EdgeInsets.only(top: getScreenPercentSize(context, 3)),
      child: getTextWidget(string, textColor,
          getScreenPercentSize(context, 1.8), FontWeight.w600, TextAlign.start),
    );
  }

  Widget getTextFiledNewPetWidget(BuildContext context, String s,
      TextEditingController textEditingController, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          height: cellHeight,
          margin: EdgeInsets.symmetric(
              vertical: getScreenPercentSize(context, 1.2)),
          alignment: Alignment.centerLeft,
          decoration: getShapeDecoration(context),
          child: TextField(
            maxLines: 1,
            controller: textEditingController,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
                fontFamily: fontFamily,
                color: Theme.of(context).hintColor,
                fontWeight: FontWeight.w500,
                fontSize: fontSize),
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: getWidthPercentSize(context, 2)),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: s,
                suffixIcon: Icon(
                  Icons.add,
                  color: Colors.transparent,
                  size: getPercentSize(cellHeight, 40),
                ),
                hintStyle: TextStyle(
                    fontFamily: fontFamily,
                    color: subTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: fontSize)),
          ),
        ),
      ],
    );
  }

  getShapeDecoration(BuildContext context) {
    double radius = getPercentSize(cellHeight, 20);

    return ShapeDecoration(
      color: Theme.of(context).colorScheme.background,
      shape: SmoothRectangleBorder(
        side: const BorderSide(color: Colors.transparent, width: 0.3),
        borderRadius: SmoothBorderRadius(
          cornerRadius: radius,
          cornerSmoothing: 0.8,
        ),
      ),
    );
  }

  Widget getRadioButton(BuildContext context, String s, String val,
      String controllerSelected, func) {
    return Expanded(
      flex: 1,
      child: Container(
        height: cellHeight,
        width: double.infinity,
        margin:
            EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 1.2)),
        padding:
            EdgeInsets.symmetric(horizontal: getWidthPercentSize(context, 2)),
        alignment: Alignment.centerLeft,
        decoration: getShapeDecoration(context),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Text(s),
          tileColor: Colors.black,
          selectedTileColor: Colors.black,
          selectedColor: Colors.black,
          textColor: Theme.of(context).hintColor,
          leading: Radio(
            value: val,
            groupValue: controllerSelected,
            onChanged: func,
            activeColor: Colors.blue,
            fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
          ),
          iconColor: Colors.black,
        ),
      ),
    );
  }

  Widget getDropDownWidget(
      BuildContext context, String dropdownValue1, List<String> list, func) {
    return Container(
      height: cellHeight,
      width: double.infinity,
      margin:
          EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 1.2)),
      padding:
          EdgeInsets.symmetric(horizontal: getWidthPercentSize(context, 2)),
      alignment: Alignment.centerLeft,
      decoration: getShapeDecoration(context),
      child: DropdownButton<String>(
        value: dropdownValue1,
        isDense: true,
        isExpanded: true,
        icon: Image.asset(
          "${assetsPath}down-arrow.png",
          color: textColor,
          height: fontSize,
        ),
        // icon: Icon(
        //   Icons.keyboard_arrow_down,
        //   color: textColor,
        // ),
        elevation: 16,
        style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: fontSize),
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        onChanged: func,
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                style: TextStyle(
                    fontFamily: fontFamily,
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.w500,
                    fontSize: fontSize)),
          );
        }).toList(),
      ),
    );
  }

  Widget getDescTextFiledWidget(BuildContext context, String s,
      TextEditingController textEditingController) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 1.2)),
      padding:
          EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 1.2)),
      alignment: Alignment.centerLeft,
      decoration: getShapeDecoration(context),
      child: TextField(
        maxLines: 4,
        controller: textEditingController,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
            fontFamily: fontFamily,
            color: Theme.of(context).hintColor,
            height: 1.3,
            fontWeight: FontWeight.w500,
            fontSize: fontSize),
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: getWidthPercentSize(context, 2)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: s,
            suffixIcon: Icon(
              Icons.add,
              color: Colors.transparent,
              size: getPercentSize(cellHeight, 40),
            ),
            isDense: true,
            hintStyle: TextStyle(
                fontFamily: fontFamily,
                color: subTextColor,
                fontWeight: FontWeight.w400,
                fontSize: fontSize)),
      ),
    );
  }
}
