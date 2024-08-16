import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/custom_icon.dart';

Widget animalWidget2(BuildContext context, AnimalModel model, index) {
  double height = getScreenPercentSize(context, 18);
  double defMargin = getScreenPercentSize(context, 1.2);
  double width = getWidthPercentSize(context, 20);

  return Container(
    width: MediaQuery.of(context).size.width / 2,
    padding: EdgeInsets.all(defMargin),
    decoration: ShapeDecoration(
      color: Theme.of(context).cardColor,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 10,
          cornerSmoothing: 1,
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
    margin: EdgeInsets.all(defMargin / 2),
    // margin:
    //     EdgeInsets.only(left: index == 0 ? (defMargin) : (defMargin / 1.5)),
    child: InkWell(
      onTap: () {
        Get.toNamed(Routes.PETDETAILS, arguments: [
          {'model': model}
        ]);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height,
            // margin: const EdgeInsets.all(6),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      networkPath + model.images![0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: customIcon(() {}, Icons.favorite),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: defMargin),
          //   child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCustomTextWidget(
                  model.animalName!,
                  Theme.of(context).hintColor,
                  getPercentSize(width, 20),
                  FontWeight.bold,
                  TextAlign.start,
                  1,
                  context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getCustomTextWidget(
                      model.type!,
                      Theme.of(context).hintColor,
                      getPercentSize(width, 16),
                      FontWeight.w500,
                      TextAlign.start,
                      1,
                      context),
                  // SizedBox(
                  //   width: 65,
                  //   child: Text(model.type!,
                  //       overflow: TextOverflow.ellipsis,
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 12,
                  //           fontFamily: fontFamily,
                  //           color: Colors.grey)),
                  // ),
                  // getCustomTextWidget(model.type!, Colors.grey, 12, FontWeight.w500,
                  //     TextAlign.start, 1),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Text(
                        "${model.age!} ${model.agePrefix!}",
                        style: TextStyle(
                            fontSize: getPercentSize(width, 14), fontWeight: FontWeight.bold),
                      )
                      // getCustomTextWidget(
                      //     "${model.age!} ${model.agePrefix!}",
                      //     Theme.of(context).hintColor,
                      //     12,
                      //     FontWeight.w500,
                      //     TextAlign.start,
                      //     1,
                      //     context),
                      )
                ],
              ),
            ],
          ),
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: defMargin),
          //   child:

          // ),
        ],
      ),
    ),
  );
}
