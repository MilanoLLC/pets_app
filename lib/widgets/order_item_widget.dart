import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/custom_icon.dart';

Widget orderItemWidget(BuildContext context, model, status, color, func) {
  double height = getScreenPercentSize(context, 11);
  double margin = getScreenPercentSize(context, 2);
  double imageSize = getPercentSize(height, 100);

  return InkWell(
    onTap: func,
    child: Container(
      decoration:
          getDecorationWithRadius(theRadius, Theme.of(context).cardColor),
      // margin: EdgeInsets.symmetric(vertical: getPercentSize(height, 10)),
      // width: double.infinity,
      padding: EdgeInsets.all(
        getPercentSize(height, 10),
      ),
      // height: itemHeight,
      child: Row(
        children: [
          Container(
            width: imageSize,
            height: imageSize,
            margin: EdgeInsets.only(right: (margin / 2)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(theRadius),
              child: Image.network(
                networkPath + model.item!.images![0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: getCustomTextWidget(
                          model.item!.enName!,
                          Theme.of(context).hintColor,
                          getPercentSize(height, 18),
                          FontWeight.w500,
                          TextAlign.start,
                          1,
                          context),
                    ),
                    getCustomTextWidget(
                        DateFormat('yyyy/MM/dd')
                            .format(DateTime.parse(model.item!.createdAt!))
                            .toString(),
                        Colors.grey,
                        getPercentSize(height, 15),
                        FontWeight.w400,
                        TextAlign.start,
                        1,
                        context)
                  ],
                ),
                SizedBox(
                  height: getPercentSize(height, 7),
                ),
                getCustomTextWidget(
                    model.item!.serviceType!,
                    Theme.of(context).hintColor.withOpacity(0.6),
                    getPercentSize(height, 16),
                    FontWeight.w400,
                    TextAlign.start,
                    1,
                    context),
                SizedBox(
                  height: getPercentSize(height, 9),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: getCustomTextWidget(
                          model.item!.price!.toString(),
                          primaryColor,
                          getPercentSize(height, 20),
                          FontWeight.w600,
                          TextAlign.start,
                          1,
                          context),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidthPercentSize(context, 3),
                          vertical: getPercentSize(height, 6)),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: getCustomTextWidget(
                          status,
                          color,
                          getPercentSize(height, 14),
                          FontWeight.w400,
                          TextAlign.center,
                          1,
                          context),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
