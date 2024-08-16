import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/model/ServiceModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';

Widget productWidget(BuildContext context, ServiceModel model, addToCart) {
  double defMargin = getScreenPercentSize(context, 1.7);
  double height = getScreenPercentSize(context, 35);
  double width = getWidthPercentSize(context, 40);
  double imgHeight = getPercentSize(height, 45);
  double remainHeight = height - imgHeight;
  double radius = getPercentSize(height, 5);

  return Container(
    width: width,
    margin: EdgeInsets.only(top: defMargin, bottom: (defMargin)),
    padding:  EdgeInsets.all(defMargin),
    decoration: ShapeDecoration(
      color: Theme.of(context).cardColor,
      shadows: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 0.5,
            spreadRadius: 0.5,
            offset: const Offset(0, 1))
      ],
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: radius,
          cornerSmoothing: 0.8,
        ),
      ),
    ),
    child: InkWell(
      onTap: () {
        Get.toNamed(Routes.PRODUCTDETAILS, arguments: [
          {'model': model}
        ]);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: imgHeight,
            // margin: EdgeInsets.only(
            //     top: getPercentSize(width, 5),
            //     bottom: getPercentSize(width, 5)),
            child:  Center(
              child: Image.network(
                networkPath + model.images![0],
                height: getPercentSize(imgHeight, 75),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCustomTextWidget(
                      model.enName.toString(),
                      Theme.of(context).hintColor,
                      getPercentSize(remainHeight, 9),
                      FontWeight.bold,
                      TextAlign.start,
                      1,context),
                  SizedBox(height: 5,),
                  getCustomTextWidget(
                      "${model.price.toString()} AED",
                      primaryColor,
                      getPercentSize(remainHeight, 10),
                      FontWeight.bold,
                      TextAlign.start,
                      1,context)
                ],
              ),
              MaterialButton(
                  minWidth: 40,
                  // height: getScreenPercentSize(context, 0.6),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: primaryColor)
                  ),
                  onPressed: addToCart,
                  child:  Center(
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).hintColor,
                        size: 15,
                      )))
            ],
          ),
        ],
      ),
    ),
  );
}
