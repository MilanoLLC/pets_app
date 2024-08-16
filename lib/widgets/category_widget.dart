import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';

Widget categoryWidgetSmall(BuildContext context, controller, index) {
  int selectedCategory = 0;
  double height = getScreenPercentSize(context, 7);
  double width = getWidthPercentSize(context, 30);
  double defMargin = getHorizontalSpace(context);
  // Color color = "#F1DDD3".toColor();
  //
  // if (index % 3 == 0) {
  //   color = "#F7E1BD".toColor();
  // } else if (index % 3 == 1) {
  //   color = "#DBF0E5".toColor();
  // } else if (index % 3 == 2) {
  //   color = "#F1DDD3".toColor();
  // }
  return InkWell(
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.transparent,
              width: selectedCategory == index ? 1 : 0),
          borderRadius:
              BorderRadius.all(Radius.circular(getPercentSize(height, 50)))),
      margin:
          EdgeInsets.only(left: index == 0 ? (defMargin) : (defMargin / 1.5)),
      child: Container(
        width: width,
        decoration: ShapeDecoration(
          color: primaryColor.withOpacity(0.3),
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
                  networkPath + controller.categories[index].imagePath!,
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
                    Theme.of(context).hintColor,
                    getPercentSize(width, 12),
                    FontWeight.w500,
                    TextAlign.start,
                    1,
                    context))
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
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
          overlayColor: const Color(0x33E8EAF6));

      selectedCategory = index;
      await controller
          .getAnimalsByCategory(controller.categories[index].enName!)
          .then((value) => Loader.hide());
      Get.toNamed(Routes.PETSBYCATEGORY,
          arguments: {'products': controller.animalsByCategory});
    },
  );
}

Widget categoryWidgetLarge(BuildContext context, controller, index) {
  int selectedCategory = 0;

  double defMargin = getScreenPercentSize(context, 1.5);
  double height = getScreenPercentSize(context, 25);

  // Color color = "#F1DDD3".toColor();
  //
  // if (index % 3 == 0) {
  //   color = "#F7E1BD".toColor();
  // } else if (index % 3 == 1) {
  //   color = "#DBF0E5".toColor();
  // } else if (index % 3 == 2) {
  //   color = "#F1DDD3".toColor();
  // }

  return Container(
    margin: EdgeInsets.only(top: defMargin, bottom: (defMargin)),
    height: height,
    decoration: ShapeDecoration(
      color: Theme.of(context).cardColor,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 15,
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
    child: InkWell(
      onTap: () async {
        Loader.show(context,
            isSafeAreaOverlay: false,
            progressIndicator: const CircularProgressIndicator(),
            isBottomBarOverlay: false,
            overlayFromBottom: 0,
            themeData: Theme.of(context).copyWith(
                colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
            overlayColor: const Color(0x33E8EAF6));

        selectedCategory = index;
        await controller
            .getAnimalsByCategory(controller.categories[index].enName!)
            .then((value) => Loader.hide());
        Get.toNamed(Routes.PETSBYCATEGORY,
            arguments: {'products': controller.animalsByCategory});
      },
      child: Column(
        children: [
          SizedBox(
            width: 90,
            child: Center(
              child: Image.network(
                networkPath + controller.categories[index].imagePath!,
                height: getPercentSize(height, 60),
              ),
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Text(
                controller.categories[index].enName!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    ),
  );
}
