import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';

Widget animalWidget(BuildContext context, AnimalModel model) {
  double defMargin = getScreenPercentSize(context, 1.5);
  double height = getScreenPercentSize(context, 35);
  double width = getWidthPercentSize(context, 40);
  double imgHeight = getPercentSize(height, 45);
  double remainHeight = height - imgHeight;
  double radius = getPercentSize(height, 5);

  return InkWell(
    child: Container(
      width: width,
      margin: EdgeInsets.only(top: defMargin, bottom: (defMargin)),
      decoration: ShapeDecoration(
        color: Theme.of(context).cardColor,
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
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  image: NetworkImage(networkPath + model.images![0]),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(defMargin),
                    topRight: Radius.circular(defMargin)),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: getPercentSize(width, 5)),
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
            ),
          ),
        ],
      ),
    ),
    onTap: () {
      Get.toNamed(Routes.PETDETAILS, arguments: [
        {'model': model}
      ]);
    },
  );
}
