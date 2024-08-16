// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:card_swiper/card_swiper.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/controllers/product_controller.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:pets_app/widgets/button_widget.dart';
import 'package:pets_app/widgets/custom_icon.dart';

class PetDetailPage extends GetView<ProductController> {
  dynamic argumentData = Get.arguments;

  PetDetailPage({Key? key}) : super(key: key);

  ScrollController? _scrollController;
  List<String> sliderList = [];
  int sliderPosition = 0;
  int position = 0;

  void initState() {
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);
  }

  _scrollListener() {}

  Future<bool> _requestPop() {
    Get.back();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    AnimalModel model = argumentData[0]['model'];
    initState();
    double margin = getHorizontalSpace(context);
    var height = getScreenPercentSize(context, 35);
    double radius = getPercentSize(height, 4);

    var storage = getIt<ILocalStorageService>();

    return WillPopScope(
      onWillPop: () async {
        _requestPop();
        return false;
      },
      child: GetBuilder<ProductController>(
          init: ProductController(),
          builder: (controller) {
            return Scaffold(
              extendBodyBehindAppBar: true,

              appBar: AppBar(
                // title: Text(model.animalName!),
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                leading: customIcon(() {
                  Get.back();
                }, Icons.arrow_back),
                actions: [
                  customIcon(() {
                    //share
                  }, Icons.favorite),
                ],
              ),

              body: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                          constraints: BoxConstraints.loose(Size(
                              MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height / 2)),
                          child: Swiper(
                            // indicatorLayout: PageIndicatorLayout.COLOR,
                            // autoplay: true,
                            // layout: SwiperLayout.DEFAULT,
                            // outer: true,
                            pagination: SwiperPagination(
                              margin: const EdgeInsets.only(top: 5.0),
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.grey,
                                  activeColor: primaryColor,
                                  size: 4,
                                  activeSize: 7,
                                  space: 1.3),
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Image.network(
                                networkPath + model.images![index],
                                fit: BoxFit.fill,
                              );
                            },
                            itemCount: model.images!.length,
                          )),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      Expanded(
                        flex: 1,
                        child: ListView(
                          padding: const EdgeInsets.all(20),
                          children: [
                            getTextWithFontFamilyWidget(
                                model.animalName!,
                                getScreenPercentSize(context, 3),
                                FontWeight.w500,
                                TextAlign.start),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: (margin / 3)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_rounded,
                                          size: 20, color: "#746F7A".toColor()),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      getTextWidget(
                                          model.location!,
                                          // Theme.of(context).hintColor,
                                          subTextColor,
                                          getScreenPercentSize(context, 2),
                                          FontWeight.normal,
                                          TextAlign.start),
                                    ],
                                  ),
                                  getTextWidget(
                                      "${model.category!.enName!} - ${model.type!}",
                                      // Theme.of(context).hintColor,
                                      Colors.grey,
                                      getScreenPercentSize(context, 2),
                                      FontWeight.normal,
                                      TextAlign.start),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                animalData(
                                    context, "Gender", model.gender!, radius),
                                animalData(
                                    context, "Color", model.color!, radius),
                                animalData(
                                    context,
                                    "Age",
                                    "${model.age!} ${model.agePrefix!}",
                                    radius),
                                animalData(context, "Weight",
                                    model.weight.toString(), radius),
                              ],
                            ),
                            const SizedBox(height: 20),
                            getTextWithFontFamilyWidget(
                                'About ${model.animalName!}',
                                getScreenPercentSize(context, 2.2),
                                FontWeight.w500,
                                TextAlign.start),
                            const SizedBox(height: 10),
                            getCustomTextWidget(
                                model.description!,
                                Colors.grey,
                                getScreenPercentSize(context, 1.9),
                                FontWeight.normal,
                                TextAlign.start,
                                10,
                                context),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: [
                                  // Checkbox(
                                  //   // shape: const CircleBorder(),
                                  //   checkColor: Colors.white,
                                  //   // fillColor: MaterialStateProperty.resolveWith(getColor),
                                  //   value: controller.isChecked.value,
                                  //   onChanged: (bool? value) {
                                  //     if (value != null) {
                                  //       if (value) {
                                  //         termsConditionsDialog(context);
                                  //       }
                                  //       controller.changeChecked(value);
                                  //     }
                                  //   },
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.checkTerms();
                                          termsConditionsDialog(context);
                                        },
                                        child: Container(
                                          height:
                                              getScreenPercentSize(context, 3),
                                          width:
                                              getScreenPercentSize(context, 3),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: primaryColor,
                                                  width: 1),
                                              color:
                                                  (controller.isTermsCondition)
                                                      ? primaryColor
                                                      : Colors.transparent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      getScreenPercentSize(
                                                          context, 0.5)))),
                                          child: Center(
                                            child: Icon(
                                              Icons.check,
                                              size: getScreenPercentSize(
                                                  context, 2.5),
                                              color:
                                                  (controller.isTermsCondition)
                                                      ? Colors.white
                                                      : Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      getTextWidget(
                                          ' I agree with ',
                                          Theme.of(context).hintColor,
                                          getScreenPercentSize(context, 1.8),
                                          FontWeight.w400,
                                          TextAlign.start),
                                      getTextWidget(
                                          "Terms",
                                          primaryColor,
                                          getScreenPercentSize(context, 1.9),
                                          FontWeight.bold,
                                          TextAlign.start),
                                      getTextWidget(
                                          " & ",
                                          Theme.of(context).hintColor,
                                          getScreenPercentSize(context, 1.8),
                                          FontWeight.w400,
                                          TextAlign.start),
                                      getTextWidget(
                                          "Condition",
                                          primaryColor,
                                          getScreenPercentSize(context, 1.9),
                                          FontWeight.bold,
                                          TextAlign.start),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      height: 80,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Theme.of(context).cardColor.withOpacity(0.1),
                            Theme.of(context).cardColor.withOpacity(0.3),
                            Theme.of(context).cardColor.withOpacity(0.7),
                            Theme.of(context).cardColor.withOpacity(0.9),
                          ])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            height: getScreenPercentSize(context, 7),
                            minWidth: MediaQuery.of(context).size.width * 1 / 5,
                            color: Colors.white,
                            onPressed: () {},
                            elevation: 0,
                            shape: SmoothRectangleBorder(
                              borderRadius: SmoothBorderRadius(
                                cornerRadius: 10,
                                cornerSmoothing: 1,
                              ),
                            ),
                            child: Center(
                                child: Icon(
                              Icons.favorite_border,
                              size: 28,
                              color: primaryColor,
                            )),
                          ),
                          MaterialButton(
                            onPressed: () {
                              var token = storage.get(STORAGE_KEYS.token);
                              if (token == null || token == "") {
                                AwesomeDialog(
                                  context: context,
                                  // dialogType: DialogType.infoReverse,
                                  headerAnimationLoop: true,
                                  // animType: AnimType.bottomSlide,
                                  title: 'Please login to continue!',
                                  // reverseBtnOrder: true,
                                  btnOkOnPress: () {
                                    Get.toNamed(Routes.SIGNIN);
                                  },
                                  btnOkText: "Log in",
                                  btnCancelOnPress: () {},
                                  // desc:
                                  // 'Lorem ipsum dolor sit amet consectetur adipiscing elit eget ornare tempus, vestibulum sagittis rhoncus felis hendrerit lectus ultricies duis vel, id morbi cum ultrices tellus metus dis ut donec. Ut sagittis viverra venenatis eget euismod faucibus odio ligula phasellus,',
                                ).show();
                              } else {
                                if (controller.isChecked.value == false) {
                                  Get.snackbar('Terms & Conditions',
                                      "Please agree terms and conditions first",
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white);
                                } else {
                                  controller.adopt(model.serial);
                                }
                              }
                            },
                            height: getScreenPercentSize(context, 7),
                            minWidth:
                                MediaQuery.of(context).size.width * 3 / 4.5,
                            color: primaryColor,
                            elevation: 0,
                            shape: SmoothRectangleBorder(
                              borderRadius: SmoothBorderRadius(
                                cornerRadius: 10,
                                cornerSmoothing: 1,
                              ),
                            ),
                            child: Center(
                                child: getDefaultTextWidget(
                                    "Adopt Now",
                                    TextAlign.center,
                                    FontWeight.w500,
                                    20,
                                    Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // ),
            );
          }),
    );
  }

  animalData(BuildContext context, dataTitle, dataText, radius) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: ShapeDecoration(
        color: Theme.of(context).cardColor,
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: radius,
            cornerSmoothing: 0.8,
          ),
        ),
        shadows: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 0.5,
              spreadRadius: 0.5,
              offset: const Offset(0, 1))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTextWidget(
              dataTitle, subTextColor, 12, FontWeight.normal, TextAlign.start),
          const SizedBox(
            height: 10,
          ),
          getTextWidget(dataText, Theme.of(context).hintColor, 14,
              FontWeight.bold, TextAlign.start),
        ],
      ),
    );
  }

  termsConditionsDialog(BuildContext context) {
    double height = getScreenPercentSize(context, 45);
    double radius = getScreenPercentSize(context, 3);
    double margin = getScreenPercentSize(context, 2);
    double defMargin = getHorizontalSpace(context);

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).cardColor),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius))),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return FractionallySizedBox(
                heightFactor: 0.6,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: margin,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: margin, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: getTextWithFontFamilyWidget(
                                'Terms and Conditions',
                                getPercentSize(height, 5),
                                FontWeight.w500,
                                TextAlign.start),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(
                                      0.8), // Adjust color as needed
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: getPercentSize(height, 4),
                                  color: Theme.of(context).hintColor,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: (defMargin / 2.2), horizontal: defMargin),
                      height: getScreenPercentSize(context, 0.03),
                      color: primaryColor.withOpacity(0.7),
                    ),
                    Padding(
                      padding: EdgeInsets.all(margin),
                      child: const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eleifend sed tellus eget pretium. Fusce gravida hendrerit cursus. In venenatis augue quis elit euismod, ut rutrum lacus suscipit. Integer mi odio, pellentesque eu finibus ac, tincidunt et felis. Donec ut urna maximus, volutpat lacus in, tincidunt mauris. Nullam maximus, mauris a laoreet fringilla, eros orci mollis orci, vel ultricies mi magna a urna. In hac habitasse platea dictumst. Sed ut pharetra dolor. Vivamus mattis posuere odio ac egestas. Cras faucibus, lacus et interdum vestibulum, risus mi vestibulum ante, vitae fringilla turpis diam a urna. Fusce dictum eget dui eget auctor. Mauris quis eleifend tortor.",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Checkbox(
                    //       shape: const CircleBorder(),
                    //       checkColor: Colors.white,
                    //       // fillColor: MaterialStateProperty.resolveWith(getColor),
                    //       value: controller.isChecked.value,
                    //       // onChanged: controller.changeChecked,
                    //       onChanged: (bool? value) {
                    //         setState(() {
                    //           controller.changeChecked(value);
                    //         });
                    //       },
                    //     ),
                    //     getCustomTextWidget2(
                    //         "I agree to terms and conditions ",
                    //         Theme.of(context).hintColor,
                    //         getScreenPercentSize(context, 1.9),
                    //         FontWeight.normal,
                    //         TextAlign.start,
                    //         5),
                    //   ],
                    // ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: buttonWidget(
                          context, "Agree", primaryColor,Colors.white, () {
                        controller.agreeTerms();
                        Get.back();
                      }),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
