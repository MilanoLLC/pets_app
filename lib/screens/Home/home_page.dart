// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pets_app/controllers/home_controller.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomePage(this.function,
      {Key? key, this.functionViewAll, this.functionAdoptionAll})
      : super(key: key);

  late Function function;
  late Function? functionViewAll;
  late Function? functionAdoptionAll;

  double defMargin = 0;
  double padding = 0;
  double height = 0;

  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;

  @override
  Widget build(BuildContext context) {
    defMargin = getHorizontalSpace(context);
    padding = getScreenPercentSize(context, 2);
    height = getScreenPercentSize(context, 5.7);

    return LoaderOverlay(
      child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return Container(
              // color: backgroundColor,
              padding: EdgeInsets.only(top: getScreenPercentSize(context, 2)),
              child: GestureDetector(
                onTap: () {
                  myFocusNode.canRequestFocus = false;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getAppBar(context),
                    Expanded(
                      child: ListView(
                        children: [
                          SizedBox(
                            height: defMargin,
                          ),
                          sliderWidget(context),
                          SizedBox(
                            height: getScreenPercentSize(context, 3),
                          ),
                          getTitle(context, 'Categories',
                              function: functionViewAll!),
                          categoryList(context),
                          SizedBox(
                            height: getScreenPercentSize(context, 1),
                          ),
                          getTitle(context, 'Our Picks for you',
                              function: functionAdoptionAll!),
                          animalList(context),
                          // animalList2(context)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  animalList(BuildContext context) {
    defMargin = getScreenPercentSize(context, 1.5);
    var height = getScreenPercentSize(context, 35);
    double width = getWidthPercentSize(context, 40);
    double imgHeight = getPercentSize(height, 45);
    double remainHeight = height - imgHeight;
    double radius = getPercentSize(height, 5);
    var crossAxisCount = 2;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: (defMargin * 1.2)),
      scrollDirection: Axis.vertical,
      primary: false,
      crossAxisSpacing: (defMargin * 2),
      mainAxisSpacing: 0,
      childAspectRatio: 0.65,
      children: List.generate(controller.products.length, (index) {
        AnimalModel model = controller.products[index];

        return InkWell(
          child: Container(
            width: width,
            margin: EdgeInsets.only(top: defMargin, bottom: (defMargin)),
            decoration: ShapeDecoration(
              color: Theme.of(context).cardColor,
              // color: backgroundColor,
              shadows: [
                BoxShadow(
                    color: subTextColor.withOpacity(0.1),
                    blurRadius: 0,
                    spreadRadius: 2,
                    offset: const Offset(0, 1))
              ],
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: radius,
                  cornerSmoothing: 0.8,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 170.0,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      image: NetworkImage(
                          networkPath + controller.products[index].images![0]),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(defMargin),
                        topRight: Radius.circular(defMargin)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: getPercentSize(width, 5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: getCustomTextWidget(
                                  model.animalName!,
                                  Theme.of(context).hintColor,
                                  getPercentSize(remainHeight, 10),
                                  FontWeight.bold,
                                  TextAlign.center,
                                  1)),
                        ],
                      ),
                      SizedBox(
                        height: getPercentSize(remainHeight, 5),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: getTextWidget(
                                model.type.toString(),
                                Colors.grey,
                                getPercentSize(remainHeight, 8),
                                FontWeight.w400,
                                TextAlign.center),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          onTap: () {
            Get.toNamed(Routes.PETDETAILS, arguments: [
              {'model': model}
            ]);
          },
        );
      }),
    );
  }

  animalList2(BuildContext context) {
    double height = getScreenPercentSize(context, 15);
    double width = getWidthPercentSize(context, 20);
    double radius = getPercentSize(height, 5);

    return Container(
        height: height,
        margin: EdgeInsets.symmetric(vertical: padding),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: controller.products.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              AnimalModel model = controller.products[index];
              return InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  decoration: ShapeDecoration(
                    color: backgroundColor,
                    shadows: [
                      BoxShadow(
                          color: subTextColor.withOpacity(0.1),
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: const Offset(0, 1))
                    ],
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: radius,
                        cornerSmoothing: 0.8,
                      ),
                    ),
                  ),
                  margin: EdgeInsets.only(
                      left: index == 0 ? (defMargin) : (defMargin / 1.5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 130.0,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: NetworkImage(networkPath +
                                controller.products[index].images![0]),
                            fit: BoxFit.fitHeight,
                          ),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0)),
                        ),
                      ),
                      SizedBox(
                        width: getPercentSize(width, 20),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          getCustomTextWidget(
                              controller.products[index].animalName!,
                              Colors.black,
                              20,
                              FontWeight.bold,
                              TextAlign.start,
                              1),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              getCustomTextWidget("Gender ", primaryColor, 14,
                                  FontWeight.w500, TextAlign.start, 1),
                              getCustomTextWidget(
                                  controller.products[index].gender!,
                                  Colors.grey,
                                  14,
                                  FontWeight.w500,
                                  TextAlign.start,
                                  1)
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              getCustomTextWidget("Age ", primaryColor, 14,
                                  FontWeight.w500, TextAlign.start, 1),
                              getCustomTextWidget(
                                  "${controller.products[index].age!} ${controller.products[index].agePrefix!}",
                                  Colors.grey,
                                  14,
                                  FontWeight.w500,
                                  TextAlign.start,
                                  1)
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              getCustomTextWidget("Type ", primaryColor, 14,
                                  FontWeight.w500, TextAlign.start, 1),
                              getCustomTextWidget(
                                  controller.products[index].type!,
                                  Colors.grey,
                                  14,
                                  FontWeight.w500,
                                  TextAlign.start,
                                  1)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Get.toNamed(Routes.PETDETAILS, arguments: [
                    {'model': model}
                  ]);
                },
              );
            }));
  }

  int selectedCategory = 0;

  categoryList(BuildContext context) {
    double height = getScreenPercentSize(context, 7);
    double width = getWidthPercentSize(context, 30);
    return Container(
        height: height,
        margin: EdgeInsets.symmetric(vertical: padding),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: controller.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Color color = "#F1DDD3".toColor();

              if (index % 3 == 0) {
                color = "#F7E1BD".toColor();
              } else if (index % 3 == 1) {
                color = "#DBF0E5".toColor();
              } else if (index % 3 == 2) {
                color = "#F1DDD3".toColor();
              }
              return InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.transparent,
                          width: selectedCategory == index ? 1 : 0),
                      borderRadius: BorderRadius.all(
                          Radius.circular(getPercentSize(height, 50)))),
                  margin: EdgeInsets.only(
                      left: index == 0 ? (defMargin) : (defMargin / 1.5)),
                  child: Container(
                    margin: const EdgeInsets.all(1),
                    width: width,
                    decoration: ShapeDecoration(
                      color: color,
                      shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius(
                          cornerRadius: getPercentSize(height, 50),
                          cornerSmoothing: 0.8,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: height,
                          width: height,
                          decoration: const BoxDecoration(
                            color: Colors.white54,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.network(
                              networkPath +
                                  controller.categories[index].imagePath!,
                              height: getPercentSize(height, 60),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getPercentSize(width, 5),
                        ),
                        Expanded(
                            child: getCustomTextWidget(
                                controller.categories[index].enName!,
                                Colors.black,
                                getPercentSize(width - height, 22),
                                FontWeight.w500,
                                TextAlign.start,
                                1))
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  Loader.show(context,
                      isSafeAreaOverlay: false,
                      progressIndicator: const CircularProgressIndicator(),
                      isBottomBarOverlay: false,
                      overlayFromBottom: 0,
                      themeData: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.fromSwatch()
                              .copyWith(secondary: Colors.black38)),
                      overlayColor: const Color(0x33E8EAF6));

                  selectedCategory = index;
                  await controller
                      .getProductsByCategory(
                          controller.categories[index].enName!)
                      .then((value) => Loader.hide());
                  Get.toNamed(Routes.PETSBYCATEGORY,
                      arguments: {'products': controller.productsByCategory});
                },
              );
            }));
  }

  getTitle(BuildContext context, String s, {Function? function}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defMargin),
      child: Row(
        children: [
          Expanded(
            child: getTextWithFontFamilyWidget(
                s,
                getScreenPercentSize(context, 2),
                FontWeight.w500,
                TextAlign.start),
          ),
          InkWell(
            onTap: () {
              if (function != null) {
                function();
              }
            },
            child: getTextWidget(
                'View All',
                primaryColor,
                getScreenPercentSize(context, 1.6),
                FontWeight.w500,
                TextAlign.start),
          )
        ],
      ),
    );
  }

  getAppBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defMargin),
      child: Row(
        children: [
          // Image.asset(
          //   assetsPath + "menu.png",
          //   height: getScreenPercentSize(context, 2.5),
          //   color: textColor,
          // ),

          Expanded(
            child: getCustomTextWithFontFamilyWidget(
                'Adopt a Friend',
                Theme.of(context).hintColor,
                getScreenPercentSize(context, 2.7),
                FontWeight.w500,
                TextAlign.start,
                1),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.NOTIFICATIONS);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => NotificationList(),
              //     ));
            },
            child: Image.asset(
              "${assetsPath}notifications.png",
              height: getScreenPercentSize(context, 2.5),
              color: Theme.of(context).hintColor,
            ),
          ),

          // Icon(
          //   Icons.shopping_bag_outlined,
          //   color: Colors.lightGreen,
          //   size: getScreenPercentSize(context, 3),
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => AddNewPetPage(),
          //         ));
          //   },
          //   child: Container(
          //     margin: EdgeInsets.only(left: getWidthPercentSize(context, 2)),
          //     height: height,
          //     width: height,
          //     decoration: getDecorationWithColor(
          //         getPercentSize(height, 25), primaryColor),
          //     child: Center(
          //       child: Icon(Icons.add,
          //           color: Colors.white, size: getPercentSize(height, 70)),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  sliderWidget(BuildContext context) {
    double sliderHeight = getScreenPercentSize(context, 22);

    return SizedBox(
      width: double.infinity,
      height: sliderHeight,
      child: CarouselSlider.builder(
        itemCount: 3,
        options:
            CarouselOptions(autoPlay: true, onPageChanged: (index, reason) {}),
        itemBuilder: (context, index, realIndex) {
          Color color = "#F1DDD3".toColor();

          if (index % 2 == 0) {
            color = Colors.green.shade200;
          } else if (index % 2 == 1) {
            color = Colors.orangeAccent.shade100;
          }

          if (index == 0) {
            return getBanner(context, sliderHeight, 'pet_3.png');
          } else if (index == 1) {
            return getSliderCell(context, sliderHeight, color);
          } else {
            return getBanner(context, sliderHeight, 'pet_6.png', color: color);
          }
        },
      ),
    );
  }

  Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
        (c.blue * f).round());
  }

  getSliderCell(BuildContext context, double height, Color color) {
    double width = double.infinity;
    double radius = getPercentSize(height, 7);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.5), color.withOpacity(0.9), color])),
      margin:
          EdgeInsets.symmetric(vertical: defMargin, horizontal: (padding / 2)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(right: padding),
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getCustomTextWithFontFamilyWidget(
                      "Pet Adoption\nMade Easy",
                      Colors.white,
                      getPercentSize(height, 11),
                      FontWeight.w500,
                      TextAlign.end,
                      2),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: getPercentSize(height, 4.5),
                        horizontal: getWidthPercentSize(context, 4)),
                    margin: EdgeInsets.only(top: getPercentSize(height, 6)),
                    decoration: getDefaultDecorationWithColor(
                        Colors.white, (radius / 1.5)),
                    child: getCustomTextWithFontFamilyWidget(
                      "Shop Now",
                      Colors.black,
                      getPercentSize(height, 7),
                      FontWeight.w400,
                      TextAlign.start,
                      1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(getPercentSize(height, 5)),
                // margin: EdgeInsets.all(getPercentSize(height, 5)),
                child: Image.asset(
                  '${assetsPath}pet_3.png',
                  width: getScreenPercentSize(context, 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getBanner(BuildContext context, double height, String img, {Color? color}) {
    color ??= "#A193E2".toColor();
    double width = double.infinity;

    double radius = getPercentSize(height, 7);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color!,
                color.withOpacity(0.9),
                color.withOpacity(0.5)
              ])),
      margin:
          EdgeInsets.symmetric(vertical: defMargin, horizontal: (padding / 2)),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.all(getPercentSize(height, 5)),
              child: Image.asset(
                assetsPath + img,
                width: getWidthPercentSize(context, 42),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: padding),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getCustomTextWithFontFamilyWidget(
                      "Pet Adoption\nMade Easy",
                      Colors.white,
                      getPercentSize(height, 11),
                      FontWeight.w500,
                      TextAlign.start,
                      2),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: getPercentSize(height, 4.5),
                        horizontal: getWidthPercentSize(context, 4)),
                    margin: EdgeInsets.only(top: getPercentSize(height, 6)),
                    decoration: getDefaultDecorationWithColor(
                        Colors.white, (radius / 1.5)),
                    child: getCustomTextWithFontFamilyWidget(
                      "Shop Now",
                      Colors.black,
                      getPercentSize(height, 7),
                      FontWeight.w400,
                      TextAlign.start,
                      1,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
