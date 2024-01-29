import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';

Widget animalWidget2(BuildContext context, AnimalModel model,index) {
  double height = getScreenPercentSize(context, 15);
  double width = getWidthPercentSize(context, 20);
  double radius = getPercentSize(height, 5);
  double defMargin = getHorizontalSpace(context);

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
                    model.images![0]),
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
                  model.animalName!,
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
                      model.gender!,
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
                      "${model.age!} ${model.agePrefix!}",
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
                     model.type!,
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
}
