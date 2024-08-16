import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/custom_icon.dart';

Widget animalWidget(BuildContext context, AnimalModel model) {
  double defMargin = getScreenPercentSize(context, 1.5);
  double height = getScreenPercentSize(context, 40);
  double width = getWidthPercentSize(context, 40);
  double imgHeight = getPercentSize(height, 45);
  double remainHeight = height - imgHeight;
  double radius = getPercentSize(height, 5);

  return InkWell(
    child: Container(
      width: width,
      color: Colors.transparent,
      margin: EdgeInsets.all(defMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 0.8,
            child:
            Container(
              height: height,
              margin: const EdgeInsets.all(10),
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
                    child: customIcon((){}, Icons.favorite),
                  ),
                ],
              ),
            ),


            // Container(
            //   decoration: BoxDecoration(
            //     // color: const Color(0xff7c94b6),
            //     image: DecorationImage(
            //       image: NetworkImage(networkPath + model.images![0]),
            //       fit: BoxFit.cover,
            //     ),
            //     borderRadius: const BorderRadius.all(Radius.circular(15)),
            //   ),
            // ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: getCustomTextWidget(model.animalName!, Theme.of(context).hintColor,
                16, FontWeight.bold, TextAlign.start, 1,context),
          ),
          SizedBox(
            height: getPercentSize(remainHeight, 2),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: getTextWidget(
                model.type.toString(),
                Colors.grey,
                13,
                FontWeight.w400,
                TextAlign.start),
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
