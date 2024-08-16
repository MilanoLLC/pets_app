import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';

Widget myPetWidget(BuildContext context, model, func) {
  double height = getScreenPercentSize(context, 12);
  double imageSize = getPercentSize(height, 90);
  double margin = getScreenPercentSize(context, 1.5);
  double radius = getScreenPercentSize(context, 0.6);

  return Container(
    decoration: getDecoration(context, radius),
    margin: EdgeInsets.symmetric(
        vertical: getScreenPercentSize(context, 1),
        horizontal: getHorizontalSpace(context)),
    height: height,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: imageSize,
              width: imageSize,
              margin: EdgeInsets.only(
                  right: margin, left: getPercentSize(height, 5)),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(radius)),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  networkPath + model!.images![0],
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomTextWidget(
                    model.animalName!,
                    Theme.of(context).hintColor,
                    getPercentSize(height, 16),
                    FontWeight.w500,
                    TextAlign.start,
                    1,context),
                SizedBox(
                  height: getPercentSize(height, 2),
                ),
                getCustomTextWidget(
                    model.category!.enName.toString(),
                    Theme.of(context).hintColor,
                    getPercentSize(height, 12),
                    FontWeight.w400,
                    TextAlign.start,
                    1,context),
                SizedBox(
                  height: getPercentSize(height, 10),
                ),
                getCustomTextWidget(
                    model.type.toString(),
                    primaryColor,
                    getPercentSize(height, 15),
                    FontWeight.w400,
                    TextAlign.start,
                    1,context),
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  print("model pet");
                  print(model.toJson());
                  Get.toNamed(Routes.EDITPET, arguments: {'model': model});
                },
                child: Icon(
                  Icons.edit,
                  size: 20,
                  color: primaryColor,
                ),
              ),
              InkWell(
                onTap: func,
                child: const Icon(
                  Icons.delete,
                  size: 20,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
