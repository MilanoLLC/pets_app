// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:comment_box/comment/comment.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pets_app/controllers/community_controller.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/model/Post_model.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/button_widget.dart';
import 'package:pets_app/widgets/photos_widget.dart';

class AddPost extends GetView<CommunityController> {
  dynamic argumentData = Get.arguments;

  AddPost({Key? key}) : super(key: key);
  double cellHeight = 0;
  double defMargin = 0;
  double fontSize = 0;

  Future<bool> _requestPop() {
    Get.back();
    controller.onClose();
    return Future.value(true);
  }

  var storage = LocalStorageService();

  @override
  Widget build(BuildContext context) {
    PostModel model = PostModel();
    if (argumentData != null) {
      model = argumentData[0]['model'];
      controller.textContentController.text = model.postContent!;
    }
    // else {
    //   print("argument null");
    //   controller.onClose();
    // }

    SizeConfig().init(context);

    double margin = getWidthPercentSize(context, 2.5);
    double height = getScreenPercentSize(context, 20);
    cellHeight = getScreenPercentSize(context, 6.5);
    defMargin = getHorizontalSpace(context);
    fontSize = getPercentSize(cellHeight, 28);

    return GetBuilder<CommunityController>(
        init: CommunityController(),
        builder: (controller) {
          return LoaderOverlay(
            child: Scaffold(
              // backgroundColor: backgroundColor,
              appBar: appBarBack(context,
                  "Add New Post", true),
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  storage.get(STORAGE_KEYS.userImage) == null
                                      ? CommentBox.commentImageParser(
                                          imageURLorPath:
                                              'assets/images/profile.png',
                                        )
                                      : CommentBox.commentImageParser(
                                          imageURLorPath: networkPath +
                                              storage
                                                  .get(STORAGE_KEYS.userImage)),
                              radius: 30,
                              backgroundColor: Colors.white,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getCustomTextWidget2(
                                      storage.get(STORAGE_KEYS.fullName),
                                      Theme.of(context).hintColor,
                                      18,
                                      FontWeight.bold,
                                      TextAlign.start,
                                      1),
                                  getCustomTextWidget2(
                                      storage.get(STORAGE_KEYS.userName),
                                      Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.6),
                                      16,
                                      FontWeight.normal,
                                      TextAlign.start,
                                      1),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: margin * 2,
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        const Text(
                          "Content",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        textFiledWidgetLarge(
                            context, "", controller.textContentController),
                        // Container(
                        //   // height: MediaQuery.of(context).size.height / 3,
                        //   margin: EdgeInsets.symmetric(
                        //       vertical: getScreenPercentSize(context, 1.2)),
                        //   padding: const EdgeInsets.all(20),
                        //   alignment: Alignment.centerLeft,
                        //   decoration: getShapeDecoration(),
                        //   child: TextField(
                        //     maxLines: 10,
                        //     controller: controller.textContentController,
                        //     textAlign: TextAlign.start,
                        //     textAlignVertical: TextAlignVertical.center,
                        //     style: TextStyle(
                        //         fontFamily: fontFamily,
                        //         color: Colors.black,
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: fontSize),
                        //     decoration: InputDecoration(
                        //         contentPadding: EdgeInsets.only(
                        //             left: getWidthPercentSize(context, 2)),
                        //         border: InputBorder.none,
                        //         focusedBorder: InputBorder.none,
                        //         enabledBorder: InputBorder.none,
                        //         errorBorder: InputBorder.none,
                        //         disabledBorder: InputBorder.none,
                        //         hintText: "Write your content",
                        //         suffixIcon: Icon(
                        //           Icons.add,
                        //           color: Colors.transparent,
                        //           size: getPercentSize(cellHeight, 40),
                        //         ),
                        //         hintStyle: TextStyle(
                        //             fontFamily: fontFamily,
                        //             color: subTextColor,
                        //             fontWeight: FontWeight.w400,
                        //             fontSize: fontSize)),
                        //   ),
                        // ),
                        //   ],
                        // ),
                        SizedBox(
                          height: margin,
                        ),
                        const Text(
                          "Upload ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: margin,
                        ),
                        InkWell(
                          onTap: () {
                            controller.selectImages();
                          },
                          child: Container(
                            height: 80,
                            decoration: getShapeDecoration(context),
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
                                Text('Photos/Videos',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: getPercentSize(height, 11),
                                        decoration: TextDecoration.none,
                                        fontFamily: customFontFamily,
                                        color: primaryColor))
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: margin * 2,
                        ),
                        controller.imageFileList!.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Photos",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  listOfImagesWidget(context, controller)
                                ],
                              )
                            : const SizedBox(),

                        // ? SizedBox(
                        //     width: 150,
                        //     height: 150,
                        //     child: Image.file(
                        //         File(controller.imageFileList![0].path)))
                        // : const SizedBox()
                      ],
                    ),
                  ),
                  buttonWidget(context, "Save", primaryColor,Colors.white, () {
                    Loader.show(context,
                        isSafeAreaOverlay: false,
                        progressIndicator: const CircularProgressIndicator(),
                        isBottomBarOverlay: false,
                        overlayFromBottom: 0,
                        themeData: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.fromSwatch()
                                .copyWith(secondary: Colors.black38)),
                        overlayColor: const Color(0x33E8EAF6));
                    controller.addPost().then((value) => Loader.hide());
                    controller.onClose();
                  })
                ],
              ),
            ),
          );
        });
  }

  // getTitle(BuildContext context, String string) {
  //   return Container(
  //     margin: EdgeInsets.only(top: getScreenPercentSize(context, 3)),
  //     child: getTextWidget(string, textColor,
  //         getScreenPercentSize(context, 1.8), FontWeight.w600, TextAlign.start),
  //   );
  // }

  // Widget getTextFiledNewPetWidget(BuildContext context, String s,
  //     TextEditingController textEditingController, String title) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         title,
  //         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //       ),
  //       Container(
  //         height: MediaQuery.of(context).size.height / 3,
  //         margin: EdgeInsets.symmetric(
  //             vertical: getScreenPercentSize(context, 1.2)),
  //         alignment: Alignment.centerLeft,
  //         decoration: getShapeDecoration(context),
  //         child: TextField(
  //           maxLines: 1,
  //           controller: textEditingController,
  //           textAlign: TextAlign.start,
  //           textAlignVertical: TextAlignVertical.center,
  //           style: TextStyle(
  //               fontFamily: fontFamily,
  //               color: Colors.black,
  //               fontWeight: FontWeight.w500,
  //               fontSize: fontSize),
  //           decoration: InputDecoration(
  //               contentPadding:
  //                   EdgeInsets.only(left: getWidthPercentSize(context, 2)),
  //               border: InputBorder.none,
  //               focusedBorder: InputBorder.none,
  //               enabledBorder: InputBorder.none,
  //               errorBorder: InputBorder.none,
  //               disabledBorder: InputBorder.none,
  //               hintText: s,
  //               suffixIcon: Icon(
  //                 Icons.add,
  //                 color: Colors.transparent,
  //                 size: getPercentSize(cellHeight, 40),
  //               ),
  //               hintStyle: TextStyle(
  //                   fontFamily: fontFamily,
  //                   color: subTextColor,
  //                   fontWeight: FontWeight.w400,
  //                   fontSize: fontSize)),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // getShapeDecoration(context) {
  //   double radius = getPercentSize(cellHeight, 20);
  //
  //   return ShapeDecoration(
  //     color: Theme.of(context).cardColor,
  //     shape: SmoothRectangleBorder(
  //       side: BorderSide(color: primaryColor.withOpacity(0.8), width: 0.3),
  //       borderRadius: SmoothBorderRadius(
  //         cornerRadius: radius,
  //         cornerSmoothing: 0.8,
  //       ),
  //     ),
  //   );
  // }
}
