// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:pets_app/controllers/home_controller.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/category_widget.dart';
import 'package:pets_app/widgets/empty_widget.dart';
import 'package:pets_app/widgets/search_widget.dart';

class CategoriesPage extends GetView<HomeController> {
  CategoriesPage({Key? key}) : super(key: key);

  double padding = 0;
  double defMargin = 0;
  double height = 0;
  bool isAutoFocus = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    padding = getScreenPercentSize(context, 2);
    defMargin = getHorizontalSpace(context);
    height = getScreenPercentSize(context, 5.5);

    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            appBar: appBarBack(context, "Categories", true),
            body: controller.categories.isEmpty
                ? Center(
                    child: emptyWidgetWithSubtext(
                        context,
                        "No Categories Yet!",
                        "We'll notify you when something arrives.",
                        "${iconsPath}search.png",
                        ""),
                  )
                : Column(
                  children: [
                    SizedBox(
                      height: getScreenPercentSize(context, 1.5),
                    ),
                    searchWidget(
                      context,
                          (string) {
                        controller.filterSearchResults(string);
                        controller.update();
                      },
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          categoryList(context)
                        ],
                      ),
                    ),
                  ],
                ),
          );
        });
  }

  int selectedCategory = 0;

  categoryList(BuildContext context) {
    defMargin = getScreenPercentSize(context, 1.5);
    var height = getScreenPercentSize(context, 25);
    double crossAxisSpacing = 0;
    var screenWidth = MediaQuery.of(context).size.width;
    var crossAxisCount = 2;
    var width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    var aspectRatio = width / height;

    return LazyLoadScrollView(
        onEndOfPage: controller.loadNextPage,
        isLoading: controller.lastPage,
        child: AnimationLimiter(
          child: GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: (defMargin * 1.2)),
            scrollDirection: Axis.vertical,
            primary: false,
            crossAxisSpacing: (defMargin * 2),
            mainAxisSpacing: 0,
            childAspectRatio: aspectRatio,
            children: List.generate(controller.categories.length, (index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 500),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                      child: categoryWidgetLarge(context, controller, index)),
                ),
              );
            }),
          ),
        ));
  }
}
