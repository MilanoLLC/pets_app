import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';

Widget listOfImagesWidget(BuildContext context, controller) {
  double height = getScreenPercentSize(context, 17);

  return Container(
    height: height,
    decoration: getShapeDecoration(context),
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: true,
            children: List.generate(controller.imageFileList!.length, (index) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child:
                    Image.file(File(controller.imageFileList![index].path)),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: InkWell(
                      onTap: () {
                        controller.removeImages(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                        ),
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    ),
  );
}


Widget showListOfImagesWidget(BuildContext context, controller,images) {
  double height = getScreenPercentSize(context, 17);

  return Container(
    height: height,
    decoration: getShapeDecoration(context),
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            primary: true,
            children: List.generate(images.length, (index) {
              return Stack(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child:
                      Image.network(
                        networkPath + images[index],
                        fit: BoxFit.fill,
                      )
                    // Image.file(File(controller.imageFileList![index].path)),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: InkWell(
                      onTap: () {
                        controller.deleteImage(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                        ),
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    ),
  );
}