// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pets_app/controllers/home_controller.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/animal_widget2.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/empty_widget.dart';
import 'package:pets_app/widgets/filter_widget.dart';
import 'package:pets_app/widgets/search_widget.dart';

class PetsPage extends GetView<HomeController> {
  PetsPage({Key? key}) : super(key: key);

  double padding = 0;
  double defMargin = 0;
  double height = 0;
  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;
  double cellHeight = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    padding = getScreenPercentSize(context, 2);
    defMargin = getHorizontalSpace(context);
    height = getScreenPercentSize(context, 5.5);

    return LoaderOverlay(
      child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return controller.animals.isEmpty
                ? Center(
                    child: emptyWidgetWithSubtext(
                        context,
                        "No Pets Yet!",
                        "We'll notify you when something arrives.",
                        "${iconsPath}search.png",
                        ""),
                  )
                : Scaffold(
                    appBar: appBarCustom(
                        context,
                        "Pets",
                        InkWell(
                          onTap: () {
                            filterDialog(context);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Center(
                              child: Image.asset("${assetsPath}filter bold.png",
                                  color: Theme.of(context).hintColor,
                                  height: getPercentSize(height, 55)),
                            ),
                          ),
                        ),
                        false),
                    body: Column(
                      children: [
                        SizedBox(
                          height: getScreenPercentSize(context, 1),
                        ),
                        searchWidget(context, (string) {
                          controller.filterSearchResultsByType(string);
                        }),
                        Expanded(
                          child: ListView(
                            children: [animalList2(context)],
                          ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }

  animalList2(BuildContext context) {
    defMargin = getScreenPercentSize(context, 1.5);
    var crossAxisCount = 2;

    return
        // Obx(
        // () =>

        LazyLoadScrollView(
      onEndOfPage: controller.loadNextPage,
      isLoading: controller.lastPage,
      child: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: (defMargin * 1)),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          primary: false,
          crossAxisSpacing: 1,
          mainAxisSpacing: 5,
          childAspectRatio: getWidthPercentSize(context, 0.2),
          children: List.generate(controller.animals.length, (index) {
            AnimalModel model = controller.animals[index];
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
      ),
      // ),
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

//     animalList(BuildContext context) {
//     defMargin = getScreenPercentSize(context, 1.5);
//     var height = getScreenPercentSize(context, 35);
//     double width = getWidthPercentSize(context, 40);
//     double imgHeight = getPercentSize(height, 45);
//     double remainHeight = height - imgHeight;
//     double radius = getPercentSize(height, 5);
//     var crossAxisCount = 2;
//
//     return Obx(
//       () => LazyLoadScrollView(
//           onEndOfPage: controller.loadNextPage,
//           isLoading: controller.lastPage,
//           child: GridView.count(
//             crossAxisCount: crossAxisCount,
//             shrinkWrap: true,
//             padding: EdgeInsets.symmetric(horizontal: (defMargin * 1.2)),
//             scrollDirection: Axis.vertical,
//             primary: false,
//             crossAxisSpacing: (defMargin * 2),
//             mainAxisSpacing: 0,
//             childAspectRatio: 0.6,
//             children: List.generate(controller.products.length, (index) {
//               AnimalModel model = controller.products[index];
//
//               return InkWell(
//                 child: Container(
//                   width: width,
//                   margin: EdgeInsets.only(top: defMargin, bottom: (defMargin)),
//                   decoration: ShapeDecoration(
//                     color: Theme.of(context).cardColor,
//                     shadows: [
//                       BoxShadow(
//                           color: subTextColor.withOpacity(0.1),
//                           blurRadius: 2,
//                           spreadRadius: 2,
//                           offset: const Offset(0, 1))
//                     ],
//                     shape: SmoothRectangleBorder(
//                       borderRadius: SmoothBorderRadius(
//                         cornerRadius: radius,
//                         cornerSmoothing: 0.8,
//                       ),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: imgHeight,
//                         margin: EdgeInsets.only(
//                             top: getPercentSize(width, 7),
//                             bottom: getPercentSize(width, 5)),
//                         child: Stack(
//                           children: [
//                             Align(
//                               alignment: Alignment.topRight,
//                               child: Container(
//                                 margin: EdgeInsets.symmetric(
//                                   horizontal: getPercentSize(imgHeight, 9),
//                                   // vertical: getPercentSize(imgHeight, 6)
//                                 ),
//                                 child: Center(
//                                   child: model.images!.isEmpty
//                                       ? Image.asset(
//                                           'assets/images/no image.jpg')
//                                       : FadeInImage.assetNetwork(
//                                           placeholder:
//                                               'assets/images/no image.jpg',
//                                           image: networkPath + model.images![0],
//                                         ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                           child: Container(
//                         margin: EdgeInsets.symmetric(
//                             horizontal: getPercentSize(width, 5)),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                     child: getCustomTextWidget(
//                                         model.animalName!,
//                                         Theme.of(context).hintColor,
//                                         getPercentSize(remainHeight, 8),
//                                         FontWeight.bold,
//                                         TextAlign.center,
//                                         1)),
//                               ],
//                             ),
//                             SizedBox(
//                               height: getPercentSize(remainHeight, 5),
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: getTextWidget(
//                                       model.type.toString(),
//                                       subTextColor,
//                                       getPercentSize(remainHeight, 8),
//                                       FontWeight.w400,
//                                       TextAlign.center),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: getPercentSize(remainHeight, 5),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       const Image(
//                                         image: AssetImage(
//                                             "assets/icons/gender.png"),
//                                         width: 15,
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       getTextWidget(
//                                           model.gender!,
//                                           subTextColor,
//                                           getPercentSize(remainHeight, 8),
//                                           FontWeight.w400,
//                                           TextAlign.start),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       const Image(
//                                         image: AssetImage(
//                                             "assets/icons/paint-tube.png"),
//                                         width: 15,
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       getTextWidget(
//                                           model.color.toString(),
//                                           subTextColor,
//                                           getPercentSize(remainHeight, 8),
//                                           FontWeight.w400,
//                                           TextAlign.start),
//                                     ],
//                                   ),
//                                   // )
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: getPercentSize(remainHeight, 5),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       const Image(
//                                         image: AssetImage(
//                                             "assets/icons/calendar.png"),
//                                         width: 15,
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       getTextWidget(
//                                           "${model.age!} ${model.agePrefix!}",
//                                           subTextColor,
//                                           getPercentSize(remainHeight, 8),
//                                           FontWeight.w400,
//                                           TextAlign.start),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       const Image(
//                                         image: AssetImage(
//                                             "assets/icons/scale.png"),
//                                         width: 15,
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       getTextWidget(
//                                           model.weight.toString(),
//                                           subTextColor,
//                                           getPercentSize(remainHeight, 8),
//                                           FontWeight.w400,
//                                           TextAlign.start),
//                                     ],
//                                   ),
//
//                                   // )
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: getPercentSize(remainHeight, 5),
//                             ),
//                             SizedBox(
//                               width: getPercentSize(width, 2),
//                             ),
//                           ],
//                         ),
//                       )),
//                     ],
//                   ),
//                 ),
//                 onTap: () {
//                   Get.toNamed(Routes.PETDETAILS, arguments: [
//                     {'model': model}
//                   ]);
//                 },
//               );
//             }),
//           )),
//     );
//   }
}
