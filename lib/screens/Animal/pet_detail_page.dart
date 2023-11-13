// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:card_swiper/card_swiper.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/controllers/product_controller.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/model/ReviewModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/DataFile.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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
    double radius = getPercentSize(height, 3);
    var storage = getIt<ILocalStorageService>();

    return WillPopScope(
        onWillPop: () async {
          _requestPop();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(model.animalName!),
            elevation: 0,
            centerTitle: true,
          ),
          // backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                ConstrainedBox(
                    constraints: BoxConstraints.loose(
                        Size(MediaQuery.of(context).size.width, 350.0)),
                    child: Swiper(
                      outer: false,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          networkPath + model.images![index],
                          fit: BoxFit.fill,
                        );
                      },
                      pagination:
                          const SwiperPagination(margin: EdgeInsets.all(5.0)),
                      itemCount: model.images!.length,
                    )),
                SizedBox(
                  height: getScreenPercentSize(context, 1.5),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    children: [
                      SizedBox(height: margin),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: (margin / 2)),
                        child: Row(
                          children: [
                            Expanded(
                                child: getTextWithFontFamilyWidget(
                                    model.animalName!,
                                    getScreenPercentSize(context, 3),
                                    FontWeight.w500,
                                    TextAlign.start)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: (margin / 2)),
                        child: Row(
                          children: [
                            Expanded(
                                child: getTextWidget(
                                    "${model.category!.enName!} - ${model.type!}",
                                    // Theme.of(context).hintColor,
                                    Colors.grey,
                                    getScreenPercentSize(context, 2),
                                    FontWeight.normal,
                                    TextAlign.start)),
                            // getTextWithFontFamilyWidget(
                            //     model.location!,
                            //     primaryColor,
                            //     18,
                            //     FontWeight.w500,
                            //     TextAlign.start)
                            Text(model.location!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    decoration: TextDecoration.none,
                                    fontFamily: customFontFamily,
                                    color: primaryColor))
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              getTextWidget("Gender", primaryColor, 16,
                                  FontWeight.bold, TextAlign.start),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                decoration: ShapeDecoration(
                                  color: Theme.of(context).cardColor,
                                  shadows: [
                                    BoxShadow(
                                        color: subTextColor.withOpacity(0.1),
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 2))
                                  ],
                                  shape: SmoothRectangleBorder(
                                    // side: BorderSide(color: iconColor, width: 0.1),
                                    borderRadius: SmoothBorderRadius(
                                      cornerRadius: radius,
                                      cornerSmoothing: 0.8,
                                    ),
                                  ),
                                ),
                                child: getTextWidget(
                                    model.gender!,
                                    subTextColor,
                                    14,
                                    FontWeight.w400,
                                    TextAlign.start),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              getTextWidget("Color", primaryColor, 16,
                                  FontWeight.bold, TextAlign.start),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: ShapeDecoration(
                                  color: Theme.of(context).cardColor,
                                  shadows: [
                                    BoxShadow(
                                        color: subTextColor.withOpacity(0.1),
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 2))
                                  ],
                                  shape: SmoothRectangleBorder(
                                    // side: BorderSide(color: iconColor, width: 0.1),
                                    borderRadius: SmoothBorderRadius(
                                      cornerRadius: radius,
                                      cornerSmoothing: 0.8,
                                    ),
                                  ),
                                ),
                                child: getTextWidget(model.color!, subTextColor,
                                    14, FontWeight.w400, TextAlign.start),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              getTextWidget("Age", primaryColor, 16,
                                  FontWeight.bold, TextAlign.start),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: ShapeDecoration(
                                  color: Theme.of(context).cardColor,
                                  shadows: [
                                    BoxShadow(
                                        color: subTextColor.withOpacity(0.1),
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 2))
                                  ],
                                  shape: SmoothRectangleBorder(
                                    // side: BorderSide(color: iconColor, width: 0.1),
                                    borderRadius: SmoothBorderRadius(
                                      cornerRadius: radius,
                                      cornerSmoothing: 0.8,
                                    ),
                                  ),
                                ),
                                child: getTextWidget(
                                    "${model.age!} ${model.agePrefix!}",
                                    subTextColor,
                                    14,
                                    FontWeight.w400,
                                    TextAlign.start),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              getTextWidget("Weight", primaryColor, 16,
                                  FontWeight.bold, TextAlign.start),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: ShapeDecoration(
                                  color: Theme.of(context).cardColor,
                                  shadows: [
                                    BoxShadow(
                                        color: subTextColor.withOpacity(0.1),
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 2))
                                  ],
                                  shape: SmoothRectangleBorder(
                                    // side: BorderSide(color: iconColor, width: 0.1),
                                    borderRadius: SmoothBorderRadius(
                                      cornerRadius: radius,
                                      cornerSmoothing: 0.8,
                                    ),
                                  ),
                                ),
                                child: getTextWidget(
                                    model.weight.toString(),
                                    subTextColor,
                                    14,
                                    FontWeight.w400,
                                    TextAlign.start),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: margin),
                      const SizedBox(height: 15),
                      Table(
                        border: const TableBorder(
                            horizontalInside: BorderSide(
                                width: 1,
                                color: Color(0xE3E3E3CC),
                                style: BorderStyle.solid),
                            verticalInside: BorderSide(
                                width: 1,
                                color: Color(0xE3E3E3CC),
                                style: BorderStyle.solid)),
                        children: [
                          const TableRow(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Friendly',
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Vaccinated',
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Passport',
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: model.friendly.toString() == "false"
                                    ? const Image(
                                        image: AssetImage(
                                            "assets/icons/cancel(1).png"),
                                        width: 20,
                                        height: 20,
                                      )
                                    : const Image(
                                        image: AssetImage(
                                            "assets/icons/check.png"),
                                        width: 20,
                                      )),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: model.vaccinated.toString() == "false"
                                  ? const Image(
                                      image: AssetImage(
                                          "assets/icons/cancel(1).png"),
                                      width: 20,
                                      height: 20,
                                    )
                                  : const Image(
                                      image:
                                          AssetImage("assets/icons/check.png"),
                                      width: 20,
                                    ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: model.passport.toString() == "false"
                                    ? const Image(
                                        image: AssetImage(
                                            "assets/icons/cancel(1).png"),
                                        width: 20,
                                        height: 20,
                                      )
                                    : const Image(
                                        image: AssetImage(
                                            "assets/icons/check.png"),
                                        width: 20,
                                      )),
                          ]),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: (margin * 1.5), bottom: (margin / 2)),
                        child: getTextWithFontFamilyWidget(
                            'Description',
                            getScreenPercentSize(context, 2.2),
                            FontWeight.w500,
                            TextAlign.start),
                      ),
                      getCustomTextWidget(
                          model.description!,
                          Colors.grey,
                          getScreenPercentSize(context, 1.9),
                          FontWeight.normal,
                          TextAlign.left,
                          5),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Checkbox(
                                shape: const CircleBorder(),
                                checkColor: Colors.white,
                                // fillColor: MaterialStateProperty.resolveWith(getColor),
                                value: controller.isChecked.value,
                                onChanged: controller.changeChecked),
                            getCustomTextWidget(
                                "Agree ",
                                Theme.of(context).hintColor,
                                getScreenPercentSize(context, 1.9),
                                FontWeight.normal,
                                TextAlign.left,
                                5),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Obx(
                  () => MaterialButton(
                    onPressed: controller.isChecked.value == false
                        ? null
                        : () {
                            var token = storage.get(STORAGE_KEYS.token);
                            print("tokennn = $token");

                            if (token == null || token == "") {
                              print("pressed");
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
                              controller.adopt(model.serial);
                            }
                          },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(getPercentSize(radius, 85)))),
                    child: Container(
                      height: getScreenPercentSize(context, 7),
                      margin: EdgeInsets.only(
                          top: getScreenPercentSize(context, 1.2),
                          bottom: getHorizontalSpace(context),
                          left: getHorizontalSpace(context),
                          right: getHorizontalSpace(context)),
                      decoration: ShapeDecoration(
                        color: controller.isChecked.value
                            ? primaryColor
                            : Colors.grey,
                        shape: SmoothRectangleBorder(
                          side: BorderSide(color: subTextColor, width: 0.3),
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: radius,
                            cornerSmoothing: 0.8,
                          ),
                        ),
                      ),
                      child: Center(
                          child: getDefaultTextWidget("Adopt", TextAlign.center,
                              FontWeight.w500, 20, Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  int quantity = 0;
  getCartButton(BuildContext context, var icon, var color, var iconColor,
      Function function) {
    return InkWell(
      child: Icon(
        icon,
        size: getScreenPercentSize(context, 3),
        color: primaryColor,
      ),
      onTap: () {
        function();
      },
    );
  }
}
