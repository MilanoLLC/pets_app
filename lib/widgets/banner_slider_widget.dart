import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';

sliderWidget(BuildContext context) {
  double sliderHeight = getScreenPercentSize(context, 22);

  return SizedBox(
    width: double.infinity,
    height: sliderHeight,
    child: CarouselSlider.builder(
      itemCount: 3,
      options:
          CarouselOptions(autoPlay: true, onPageChanged: (index, reason) {}),
      itemBuilder: (context, index, realIndex) {
        Color color = "#F1DDD3".toColor();

        if (index % 2 == 0) {
          color = Colors.green.shade200;
        } else if (index % 2 == 1) {
          color = Colors.orangeAccent.shade100;
        }

        if (index == 0) {
          return getBanner(context, sliderHeight, 'pet_3.png');
        } else if (index == 1) {
          return getSliderCell(context, sliderHeight, color);
        } else {
          return getBanner(context, sliderHeight, 'pet_6.png', color: color);
        }
      },
    ),
  );
}

getSliderCell(BuildContext context, double height, Color color) {
  double width = double.infinity;
  double radius = getPercentSize(height, 7);
  double defMargin = getHorizontalSpace(context);
  double padding = getScreenPercentSize(context, 2);
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.5), color.withOpacity(0.9), color])),
    margin:
        EdgeInsets.symmetric(vertical: defMargin, horizontal: (padding / 2)),
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(right: padding),
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getCustomTextWidget(
                    "Pet Adoption\nMade Easy",
                    Colors.white,
                    getPercentSize(height, 11),
                    FontWeight.w500,
                    TextAlign.end,
                    2,
                    context),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: getPercentSize(height, 4.5),
                      horizontal: getWidthPercentSize(context, 4)),
                  margin: EdgeInsets.only(top: getPercentSize(height, 6)),
                  decoration: getDefaultDecorationWithColor(
                      Colors.white, (radius / 1.5)),
                  child: getCustomTextWidget(
                      "Shop Now",
                      Colors.black,
                      getPercentSize(height, 7),
                      FontWeight.w400,
                      TextAlign.start,
                      1,
                      context),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.all(getPercentSize(height, 5)),
              // margin: EdgeInsets.all(getPercentSize(height, 5)),
              child: Image.asset(
                '${assetsPath}pet_3.png',
                width: getScreenPercentSize(context, 20),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

getBanner(BuildContext context, double height, String img, {Color? color}) {
  color ??= "#A193E2".toColor();
  double width = double.infinity;
  double defMargin = getHorizontalSpace(context);

  double radius = getPercentSize(height, 7);

  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color!, color.withOpacity(0.9), color.withOpacity(0.5)])),
    margin:
        EdgeInsets.symmetric(vertical: defMargin, horizontal: (padding / 2)),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getPercentSize(height, 5)),
            child: Image.asset(
              assetsPath + img,
              width: getWidthPercentSize(context, 42),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: padding),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getCustomTextWidget(
                    "Pet Adoption\nMade Easy",
                    Colors.white,
                    getPercentSize(height, 11),
                    FontWeight.w500,
                    TextAlign.start,
                    2,
                    context),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: getPercentSize(height, 4.5),
                      horizontal: getWidthPercentSize(context, 4)),
                  margin: EdgeInsets.only(top: getPercentSize(height, 6)),
                  decoration: getDefaultDecorationWithColor(
                      Colors.white, (radius / 1.5)),
                  child: getCustomTextWidget(
                      "Shop Now",
                      Colors.black,
                      getPercentSize(height, 7),
                      FontWeight.w400,
                      TextAlign.start,
                      1,
                      context),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
