import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/PrefData.dart';

emptyWidget(BuildContext context, text, imgSrc) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        imgSrc,
        height: getScreenPercentSize(context, 20),
      ),
      SizedBox(
        height: getScreenPercentSize(context, 3),
      ),
      getCustomTextWithFontFamilyWidget(
          text,
          Theme.of(context).hintColor,
          getScreenPercentSize(context, 2.5),
          FontWeight.w500,
          TextAlign.center,
          1),
      const SizedBox(
        height: 15,
      ),
    ],
  );
}

emptyWidgetWithSubtext(BuildContext context, text, subText, imgSrc) {
  PrefData.setIsNotification(true);
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        imgSrc, //"${assetsPath}bell-1 1.png",
        height: getScreenPercentSize(context, 20),
      ),
      SizedBox(
        height: getScreenPercentSize(context, 3),
      ),
      getCustomTextWithFontFamilyWidget(
          text, //"No Notification Yet!",
          Theme.of(context).hintColor,
          getScreenPercentSize(context, 2.5),
          FontWeight.w500,
          TextAlign.center,
          1),
      SizedBox(
        height: getScreenPercentSize(context, 1),
      ),
      getCustomTextWidget(
          subText, //"We'll notify you when something arrives.",
          Theme.of(context).hintColor,
          getScreenPercentSize(context, 2),
          FontWeight.w400,
          TextAlign.center,
          1),
    ],
  );
}

emptyWidgetWithButton(BuildContext context, imgSrc, text, buttonTitle) {
  double height = getScreenPercentSize(context, 7);
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        imgSrc, //"${iconsPath}box.png",
        height: getScreenPercentSize(context, 20),
      ),
      SizedBox(
        height: getScreenPercentSize(context, 3),
      ),
      getCustomTextWithFontFamilyWidget(
          text, //"Your Pets are Empty!",
          primaryColor,
          getScreenPercentSize(context, 2.5),
          FontWeight.w500,
          TextAlign.center,
          1),
      const SizedBox(
        height: 15,
      ),
      MaterialButton(
        onPressed: () {
          Get.toNamed(Routes.NEWPET);
        },
        minWidth: 100,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          height: getScreenPercentSize(context, 7),
          margin: EdgeInsets.only(
              top: getScreenPercentSize(context, 1.2),
              bottom: getHorizontalSpace(context),
              left: getHorizontalSpace(context) + 40,
              right: getHorizontalSpace(context) + 40),
          decoration: ShapeDecoration(
            shape: SmoothRectangleBorder(
              side: BorderSide(color: primaryColor, width: 1.5),
              borderRadius: SmoothBorderRadius(
                cornerRadius: getPercentSize(height, 25),
                cornerSmoothing: 0.8,
              ),
            ),
          ),
          child: Center(
              child: getDefaultTextWidget(buttonTitle, TextAlign.center,
                  FontWeight.w500, 20, primaryColor)),
        ),
      ),
    ],
  );
}
