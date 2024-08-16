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
      getCustomTextWidget2(
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

emptyWidgetWithSubtext(BuildContext context, text, subText, imgSrc, icon) {
  PrefData.setIsNotification(true);
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      imgSrc != ""
          ? Image.asset(
              imgSrc, //"${assetsPath}bell-1 1.png",
              height: getScreenPercentSize(context, 20),
            )
          : Icon(icon,
              color: primaryColor,
              size: MediaQuery.of(context).size.height / 5),
      SizedBox(
        height: getScreenPercentSize(context, 2),
      ),
      getCustomTextWidget2(
          text, //"No Notification Yet!",
          Theme.of(context).hintColor,
          getScreenPercentSize(context, 2.5),
          FontWeight.w500,
          TextAlign.center,
          1),
      SizedBox(
        height: getScreenPercentSize(context, 1),
      ),
      getCustomTextWidget2(
          subText, //"We'll notify you when something arrives.",
          Theme.of(context).hintColor.withOpacity(0.6),
          getScreenPercentSize(context, 1.8),
          FontWeight.w400,
          TextAlign.center,
          1),
    ],
  );
}

emptyWidgetWithButton(
    BuildContext context, imgSrc, icon, title, content, buttonTitle, func) {
  double height = getScreenPercentSize(context, 7);

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      imgSrc != ""
          ? Image.asset(
              imgSrc, //"${iconsPath}box.png",
              height: getScreenPercentSize(context, 20),
            )
          : Icon(icon,
              color: primaryColor,
              size: MediaQuery.of(context).size.height / 5),
      SizedBox(
        height: getScreenPercentSize(context, 2),
      ),
      getCustomTextWidget2(
          title,
          Theme.of(context).hintColor,
          getScreenPercentSize(context, 2.5),
          FontWeight.w500,
          TextAlign.center,
          1),
      SizedBox(
        height: getScreenPercentSize(context, 1),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: getCustomTextWidget2(
            content,
            Theme.of(context).hintColor.withOpacity(0.6),
            getScreenPercentSize(context, 2),
            FontWeight.w400,
            TextAlign.center,
            2),
      ),
      SizedBox(
        height: getScreenPercentSize(context, 1),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getHorizontalSpace(context) + 60, vertical: 15),
        child: MaterialButton(
          onPressed: func,
          height: height,
          shape: SmoothRectangleBorder(
            side: BorderSide(color: primaryColor, width: 1.5),
            borderRadius: SmoothBorderRadius(
              cornerRadius: getPercentSize(height, 25),
              cornerSmoothing: 0.8,
            ),
          ),
          child: Center(
              child: getDefaultTextWidget(buttonTitle, TextAlign.center,
                  FontWeight.w500, 18, primaryColor)),
        ),
      ),
    ],
  );
}

emptyWidgetUnauthorized(BuildContext context) {
  double height = getScreenPercentSize(context, 7);
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        "${iconsPath}block-user.png",
        height: getScreenPercentSize(context, 20),
      ),
      SizedBox(
        height: getScreenPercentSize(context, 3),
      ),
      getCustomTextWidget2(
          "Please log in to view this page",
          Theme.of(context).hintColor,
          getScreenPercentSize(context, 2.2),
          FontWeight.w500,
          TextAlign.center,
          1),
      const SizedBox(
        height: 15,
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getHorizontalSpace(context) + 60, vertical: 15),
        child: MaterialButton(
          onPressed: () {
            Get.toNamed(Routes.SIGNIN);
          },
          height: height,
          shape: SmoothRectangleBorder(
            side: BorderSide(color: primaryColor, width: 1.5),
            borderRadius: SmoothBorderRadius(
              cornerRadius: getPercentSize(height, 25),
              cornerSmoothing: 0.8,
            ),
          ),
          child: Center(
              child: getDefaultTextWidget("Login", TextAlign.center,
                  FontWeight.w500, 20, primaryColor)),
        ),
      ),

      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: getScreenPercentSize(context, 2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getTextWidget(
                  "Don't have an account?",
                  Theme.of(context).hintColor.withOpacity(0.6),
                  getScreenPercentSize(context, 2),
                  FontWeight.w400,
                  TextAlign.center),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                child: getTextWidget(
                    "Sign Up",
                    primaryColor,
                    getScreenPercentSize(context, 2),
                    FontWeight.w500,
                    TextAlign.center),
                onTap: () {
                  Get.toNamed(Routes.SIGNUP);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => SignUpPage()));
                },
              )
            ],
          ),
        ),
      )
    ],
  );
}

