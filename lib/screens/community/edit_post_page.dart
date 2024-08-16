// ignore_for_file: must_be_immutable

import 'package:comment_box/comment/comment.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/controllers/edit_post_controller.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/model/Post_model.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/button_widget.dart';
import 'package:pets_app/widgets/photos_widget.dart';

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
    var storage = LocalStorageService();

    return GetBuilder<EditPostController>(
        init: EditPostController(model),
        builder: (controller) {
          return Scaffold(
            // backgroundColor: backgroundColor,
            appBar: appBarBack(context, "Edit Post", true),
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
                            backgroundImage: storage
                                        .get(STORAGE_KEYS.userImage) ==
                                    null
                                ? CommentBox.commentImageParser(
                                    imageURLorPath: 'assets/images/profile.png',
                                  )
                                : CommentBox.commentImageParser(
                                    imageURLorPath: networkPath +
                                        storage.get(STORAGE_KEYS.userImage)),
                            radius: 30,
                            backgroundColor: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      SizedBox(
                        height: margin,
                      ),
                      controller.images.isNotEmpty
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
                                showListOfImagesWidget(
                                    context, controller, controller.imagesModel)
                              ],
                            )
                          : const SizedBox(),
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
                      SizedBox(
                        height: margin * 2,
                      ),

                      // ? SizedBox(
                      //     width: 150,
                      //     height: 150,
                      //     child: Image.file(
                      //         File(controller.imageFileList![0].path)))
                      // : const SizedBox()
                    ],
                  ),
                ),
                buttonWidget(context, "Update", primaryColor,Colors.white, () {
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
}
