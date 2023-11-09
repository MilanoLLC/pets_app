// ignore_for_file: must_be_immutable

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/controllers/edit_post_controller.dart';
import 'package:pets_app/model/Post_model.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';

class EditPost extends StatelessWidget {
  dynamic argumentData = Get.arguments;

  EditPost({Key? key}) : super(key: key);
  double cellHeight = 0;
  double defMargin = 0;
  double fontSize = 0;

  @override
  Widget build(BuildContext context) {
    PostModel model = argumentData['editPost'];

    SizeConfig().init(context);

    double margin = getWidthPercentSize(context, 2.5);
    double height = getScreenPercentSize(context, 20);
    cellHeight = getScreenPercentSize(context, 6.5);
    defMargin = getHorizontalSpace(context);
    fontSize = getPercentSize(cellHeight, 28);

    return GetBuilder<EditPostController>(
        init: EditPostController(model),
        builder: (controller) {
          return Scaffold(
            // backgroundColor: backgroundColor,
            appBar: AppBar(
              title: const Text("Edit Post"),
              elevation: 0,
              centerTitle: true,
            ),
            body: Column(
              children: [
                SizedBox(
                  height: getScreenPercentSize(context, 1.5),
                ),
                Expanded(
                  flex: 1,
                  child: ListView(
                    shrinkWrap: true,
                    primary: true,
                    padding: EdgeInsets.symmetric(horizontal: defMargin),
                    children: [
                      SizedBox(
                        height: margin,
                      ),
                      getTextFiledNewPetWidget(context, "",
                          controller.textContentController, "Content"),
                      SizedBox(
                        height: margin,
                      ),
                      const Text(
                        "List of Images",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          controller.selectImages();
                        },
                        child: Container(
                          height: height,
                          decoration: getShapeDecoration(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "${assetsPath}camera fill.png",
                                height: getPercentSize(height, 15),
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: getWidthPercentSize(context, 2),
                              ),
                              // getTextWithFontFamilyWidget(
                              //     'Add Photo',
                              //     primaryColor,
                              //     getPercentSize(height, 12),
                              //     FontWeight.w500,
                              //     TextAlign.center)
                              Text('Add Photo',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: getPercentSize(height, 12),
                                      decoration: TextDecoration.none,
                                      fontFamily: customFontFamily,
                                      color: primaryColor))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                getButtonWidget(context, "Save", primaryColor, () {
                  controller.editPost(model.serial);
                  controller.onClose();
                }),
                SizedBox(
                  height: margin,
                )
              ],
            ),
          );
        });
  }

  getTitle(BuildContext context, String string) {
    return Container(
      margin: EdgeInsets.only(top: getScreenPercentSize(context, 3)),
      child: getTextWidget(string, textColor,
          getScreenPercentSize(context, 1.8), FontWeight.w600, TextAlign.start),
    );
  }

  Widget getTextFiledNewPetWidget(BuildContext context, String s,
      TextEditingController textEditingController, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          height: cellHeight,
          margin: EdgeInsets.symmetric(
              vertical: getScreenPercentSize(context, 1.2)),
          alignment: Alignment.centerLeft,
          decoration: getShapeDecoration(),
          child: TextField(
            maxLines: 1,
            controller: textEditingController,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
                fontFamily: fontFamily,
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: fontSize),
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: getWidthPercentSize(context, 2)),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: s,
                suffixIcon: Icon(
                  Icons.add,
                  color: Colors.transparent,
                  size: getPercentSize(cellHeight, 40),
                ),
                hintStyle: TextStyle(
                    fontFamily: fontFamily,
                    color: subTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: fontSize)),
          ),
        ),
      ],
    );
  }

  getShapeDecoration() {
    double radius = getPercentSize(cellHeight, 20);

    return ShapeDecoration(
      color: cellColor,
      shape: SmoothRectangleBorder(
        side: BorderSide(color: primaryColor.withOpacity(0.8), width: 0.3),
        borderRadius: SmoothBorderRadius(
          cornerRadius: radius,
          cornerSmoothing: 0.8,
        ),
      ),
    );
  }
}
