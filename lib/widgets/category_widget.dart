import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';

Widget categoryWidgetSmall(BuildContext context, controller,index) {
  int selectedCategory = 0;
  double height = getScreenPercentSize(context, 7);
  double width = getWidthPercentSize(context, 30);
  double defMargin = getHorizontalSpace(context);
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
}

Widget categoryWidgetLarge(BuildContext context, controller,index) {
  int selectedCategory = 0;

  double defMargin = getScreenPercentSize(context, 1.5);
  double height = getScreenPercentSize(context, 25);

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
      margin: EdgeInsets.only(top: defMargin, bottom: (defMargin)),
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
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
//
          Expanded(
              child: Text(
                controller.categories[index].enName!,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )),
        ],
      ),
    ),
    onTap: () async {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          });
      await controller
          .getProductsByCategory(controller.categories[index].enName!)
          .then((value) => Navigator.pop(context));

      selectedCategory = index;

      Get.toNamed(Routes.PETSBYCATEGORY,
          arguments: {'products': controller.productsByCategory});
    },
  );
}




