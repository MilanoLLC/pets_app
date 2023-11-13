import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/model/ServiceModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';

Widget productWidget(BuildContext context, ServiceModel model, addToCart) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: imgHeight,
            margin: EdgeInsets.only(
                top: getPercentSize(width, 7),
                bottom: getPercentSize(width, 5)),
            child: Stack(
              children: [
                Center(
                  child: Image.network(
                    networkPath + model.images![0],
                    height: getPercentSize(imgHeight, 75),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: getPercentSize(width, 5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: getCustomTextWidget(
                              "${model.price.toString()} AED",
                              Theme.of(context).hintColor,
                              getPercentSize(remainHeight, 11),
                              FontWeight.bold,
                              TextAlign.start,
                              1)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getCustomTextWidget(
                          model.enName.toString(),
                          Colors.grey,
                          getPercentSize(remainHeight, 8),
                          FontWeight.bold,
                          TextAlign.start,
                          1),
                      Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 0.0,
                        clipBehavior: Clip.antiAlias,
                        child: MaterialButton(
                            minWidth: 50.0,
                            height: 40,
                            color: const Color(0xFF9e93d2),
                            onPressed: addToCart,
                            child: const Center(
                                child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ))),
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
      Get.toNamed(Routes.PRODUCTDETAILS, arguments: [
        {'model': model}
      ]);
    },
  );
}
