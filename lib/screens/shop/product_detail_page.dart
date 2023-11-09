// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:card_swiper/card_swiper.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:pets_app/controllers/shop_controller.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/model/ReviewModel.dart';
import 'package:pets_app/model/ServiceModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/DataFile.dart';
import 'package:get/get.dart';
// import 'package:quantity_input/quantity_input.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ProductDetailPage extends GetView<ShopController> {
  ProductDetailPage({Key? key}) : super(key: key);

  dynamic argumentData = Get.arguments;

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
    ServiceModel model = argumentData[0]['model'];
    initState();
    double margin = getHorizontalSpace(context);
    var height = getScreenPercentSize(context, 35);
    double radius = getPercentSize(height, 3);
    var storage = getIt<ILocalStorageService>();
    return GetBuilder<ShopController>(
        init: ShopController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(model.enName!),
              elevation: 0,
              centerTitle: true,
            ),
            // backgroundColor: backgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints.loose(Size(
                          MediaQuery.of(context).size.width,
                          (MediaQuery.of(context).size.height * 1 / 3) + 100)),
                      child: Swiper(
                        outer: false,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            networkPath + model.images![index],
                            fit: BoxFit.cover,
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
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        children: [
                          SizedBox(height: margin),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: (margin / 2)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Expanded(
                                //     child:
                                getTextWidget(
                                    model.itemCategory!.categoryEnName!,
                                    // Theme.of(context).hintColor,
                                    Theme.of(context).hintColor,
                                    getScreenPercentSize(context, 2.5),
                                    FontWeight.normal,
                                    TextAlign.start),
                                getTextWithFontFamilyWidget(
                                    "${model.price!.toString()}  AED",
                                    getScreenPercentSize(context, 3),
                                    FontWeight.w500,
                                    TextAlign.start),
                                // ),
                                //             Expanded(
                                //                 child:

                                // ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: (margin / 2)),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //           child: getTextWidget(
                          //               model.itemCategory!.categoryEnName!,
                          //               // Theme.of(context).hintColor,
                          //               Colors.grey,
                          //               getScreenPercentSize(context, 2),
                          //               FontWeight.normal,
                          //               TextAlign.start)),
                          //       // getTextWithFontFamilyWidget(
                          //       //     model.location!,
                          //       //     primaryColor,
                          //       //     18,
                          //       //     FontWeight.w500,
                          //       //     TextAlign.start)
                          //       // Text("Description",
                          //       //     textAlign: TextAlign.start,
                          //       //     style: TextStyle(
                          //       //         fontWeight: FontWeight.w500,
                          //       //         fontSize: 18,
                          //       //         decoration: TextDecoration.none,
                          //       //         fontFamily: customFontFamily,
                          //       //         color: primaryColor))
                          //     ],
                          //   ),
                          // ),
                          // const SizedBox(height: 20),

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
                              model.serviceType!,
                              Colors.grey,
                              getScreenPercentSize(context, 1.9),
                              FontWeight.normal,
                              TextAlign.left,
                              5),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: (margin * 1.5), bottom: (margin / 2)),
                            child: getTextWithFontFamilyWidget(
                                'Quantity',
                                getScreenPercentSize(context, 2.2),
                                FontWeight.w500,
                                TextAlign.start),
                          ),
                          InputQty(
                            maxVal: 100,
                            initVal: 0,
                            minVal: -100,
                            steps: 10,
                            onQtyChanged: (val) {
                              print(val);
                            },
                          ),
                          // QuantityInput(
                          //     value: controller.quantity.value,
                          //     onChanged: (value) =>
                          //         controller.changeQuantity(value)
                          //     // onChanged: (value) => setState(() => simpleIntInput = int.parse(value.replaceAll(',', '')))
                          //     ),
                          // Obx(
                          //   () => Row(
                          //     children: [
                          //       Checkbox(
                          //           shape: const CircleBorder(),
                          //           checkColor: Colors.white,
                          //           // fillColor: MaterialStateProperty.resolveWith(getColor),
                          //           value: controller.isChecked.value,
                          //           onChanged: controller.changeChecked),
                          //       getCustomTextWidget(
                          //           "Agree ",
                          //           Theme.of(context).hintColor,
                          //           getScreenPercentSize(context, 1.9),
                          //           FontWeight.normal,
                          //           TextAlign.left,
                          //           5),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Theme.of(context).colorScheme.background,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Expanded(
                        //   child:
                        MaterialButton(
                          onPressed: () {
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
                              ).show();
                            } else {
                              controller.addToCart(
                                  model, controller.quantity.value);
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(getPercentSize(radius, 85)))),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 2 / 3,
                            height: getScreenPercentSize(context, 7),
                            margin: EdgeInsets.only(
                              top: getScreenPercentSize(context, 1.2),
                              bottom: getHorizontalSpace(context),
                              // left: getHorizontalSpace(context),
                              // right: getHorizontalSpace(context)
                            ),
                            decoration: ShapeDecoration(
                              color: primaryColor,
                              shape: SmoothRectangleBorder(
                                side:
                                    BorderSide(color: subTextColor, width: 0.3),
                                borderRadius: SmoothBorderRadius(
                                  cornerRadius: radius,
                                  cornerSmoothing: 0.8,
                                ),
                              ),
                            ),
                            child: Center(
                                child: getDefaultTextWidget(
                                    "Add to cart",
                                    TextAlign.center,
                                    FontWeight.w500,
                                    20,
                                    Colors.white)),
                          ),
                        ),
                        // ),
                        // Expanded(
                        //     child:
                        MaterialButton(
                            onPressed: () {
                              Get.toNamed(Routes.MYCART);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    getPercentSize(radius, 85)))),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1 / 6,
                              height: getScreenPercentSize(context, 7),
                              margin: EdgeInsets.only(
                                top: getScreenPercentSize(context, 1.2),
                                bottom: getHorizontalSpace(context),
                                // left: getHorizontalSpace(context),
                                // right: getHorizontalSpace(context)
                              ),
                              decoration: ShapeDecoration(
                                color: primaryColor,
                                shape: SmoothRectangleBorder(
                                  side: BorderSide(
                                      color: subTextColor, width: 0.3),
                                  borderRadius: SmoothBorderRadius(
                                    cornerRadius: radius,
                                    cornerSmoothing: 0.8,
                                  ),
                                ),
                              ),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                  controller.orderItems.isNotEmpty
                                      ? Text(controller.orderItems.length
                                          .toString())
                                      : const SizedBox(),
                                ],
                              )),
                              // ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
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
