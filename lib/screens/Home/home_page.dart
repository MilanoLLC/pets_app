// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pets_app/controllers/home_controller.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/animal_widget.dart';
import 'package:pets_app/widgets/animal_widget2.dart';
import 'package:pets_app/widgets/banner_slider_widget.dart';
import 'package:pets_app/widgets/category_widget.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomePage(this.function,
      {Key? key, this.functionViewAllCategories, this.functionViewAllAnimals})
      : super(key: key);

  late Function function;
  late Function? functionViewAllCategories;
  late Function? functionViewAllAnimals;

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
              padding: EdgeInsets.only(top: getScreenPercentSize(context, 2)),
              child: GestureDetector(
                onTap: () {
                  myFocusNode.canRequestFocus = false;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: defMargin),
                      child: Row(
                        children: [
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
                            },
                            child: Image.asset(
                              "${assetsPath}notifications.png",
                              height: getScreenPercentSize(context, 2.5),
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          Icon(
                            Icons.notifications_none,
                            color: primaryColor,
                            size: getScreenPercentSize(context, 3),
                          ),
                        ],
                      ),
                    ),
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
                              function: functionViewAllCategories!),
                          categoryList(context),
                          SizedBox(
                            height: getScreenPercentSize(context, 1),
                          ),
                          getTitle(context, 'Our Picks for you',
                              function: functionViewAllAnimals!),
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

  animalList(BuildContext context) {
    defMargin = getScreenPercentSize(context, 1.5);
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
        return animalWidget(context, model);
      }),
    );
  }

  animalList2(BuildContext context) {
    double height = getScreenPercentSize(context, 15);

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
              return animalWidget2(context, model, index);
            }));
  }

  categoryList(BuildContext context) {
    double height = getScreenPercentSize(context, 7);
    return Container(
        height: height,
        margin: EdgeInsets.symmetric(vertical: padding),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: controller.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return categoryWidgetSmall(context, controller, index);
            }));
  }
}
