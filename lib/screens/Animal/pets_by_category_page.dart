// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:pets_app/controllers/home_controller.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/animal_widget2.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/empty_widget.dart';
import 'package:pets_app/widgets/filter_widget.dart';
import 'package:pets_app/widgets/search_widget.dart';

class PetsByCategoryPage extends GetView<HomeController> {
  PetsByCategoryPage({Key? key}) : super(key: key);
  dynamic argumentData = Get.arguments;

  double padding = 0;
  double defMargin = 0;
  double height = 0;
  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;

  @override
  Widget build(BuildContext context) {
    if (argumentData != null) {
      if (argumentData["products"] != null && argumentData != []) {
        controller.animalsByCategory = argumentData["products"];
      }
    }

    SizeConfig().init(context);
    padding = getScreenPercentSize(context, 2);
    defMargin = getHorizontalSpace(context);
    height = getScreenPercentSize(context, 5.5);
    double radius = getScreenPercentSize(context, 1.5);

    return Scaffold(
      appBar: appBarCustom(
          context,
          "Pets By Category",
          InkWell(
            onTap: () {
              filterDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: Image.asset("${assetsPath}filter bold.png",
                    color: Theme.of(context).hintColor,
                    height: getPercentSize(height, 55)),
              ),
            ),
          ),
          true),
      body: controller.animalsByCategory.isEmpty
          ? Center(
              child: emptyWidgetWithSubtext(
                  context,
                  "No Pets Yet!",
                  "We'll notify you when something arrives.",
                  "${iconsPath}search.png",
                  ""),
            )
          : Column(
              children: [
                SizedBox(
                  height: defMargin,
                ),
                searchWidget(context, (string) {
                  controller.filterSearchResultsByType2(string);
                }),
                SizedBox(
                  height: getScreenPercentSize(context, 1.5),
                ),
                Expanded(child: animalList2(context))
              ],
            ),
    );
  }

  animalList2(BuildContext context) {
    defMargin = getScreenPercentSize(context, 1.5);
    var crossAxisCount = 2;

    return Obx(
      () => LazyLoadScrollView(
          onEndOfPage: controller.loadNextPage,
          isLoading: controller.lastPage,
          child: AnimationLimiter(
            child: GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: (defMargin * 1.2)),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              primary: false,
              crossAxisSpacing: 1,
              mainAxisSpacing: 5,
              childAspectRatio: getWidthPercentSize(context, 0.17),
              children:
                  List.generate(controller.animalsByCategory.length, (index) {
                AnimalModel model = controller.animalsByCategory[index];
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  columnCount: 2,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                        child: animalWidget2(context, model, index)),
                  ),
                );
              }),
            ),
          )),
    );
  }

  filterDialog(BuildContext context) {
    double radius = getScreenPercentSize(context, 3);

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
                  heightFactor: 0.6, child: filterWidget(context, controller));
            },
          );
        });
  }
}
