// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pets_app/controllers/edit_profile_controller.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);
  final controller = Get.put(EditProfileController());
  double defaultMargin = 0;
  XFile? _image;
  final picker = ImagePicker();

  Future<bool> _requestPop() {
    Get.back();
    return Future.value(true);
  }

  _imgFromGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    _image = image;
  }

  getProfileImage() {
    if (_image != null && _image!.path.isNotEmpty) {
      return Image.file(
        File(_image!.path),
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "${assetsPath}profile.png",
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double profileHeight = getScreenPercentSize(context, 12);
    defaultMargin = getHorizontalSpace(context);
    double editSize = getPercentSize(profileHeight, 26);

    return WillPopScope(
        onWillPop: _requestPop,
        child: LoaderOverlay(
          child: Scaffold(
            // backgroundColor: backgroundColor,
            appBar: AppBar(
              title: const Text("Edit Profile"),
              elevation: 0,
              centerTitle: true,
            ),

            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  // getAppBar(context, "Edit Profile", isBack: true,
                  //     function: () {
                  //   _requestPop();
                  // }),
                  SizedBox(
                    height: getScreenPercentSize(context, 2),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      children: [
                        SizedBox(
                            height: profileHeight + (profileHeight / 5),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(top: defaultMargin),
                                      height: profileHeight,
                                      width: profileHeight,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child: Material(
                                          color: primaryColor,
                                          child: getProfileImage(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Align(
                                  //   alignment: Alignment.bottomCenter,
                                  //   child: InkWell(
                                  //     child: Container(
                                  //       margin: EdgeInsets.only(
                                  //           left:
                                  //               getScreenPercentSize(context, 9),
                                  //           bottom: getScreenPercentSize(
                                  //               context, 1.6)),
                                  //       height: editSize,
                                  //       width: editSize,
                                  //       child: Container(
                                  //         decoration: BoxDecoration(
                                  //           shape: BoxShape.circle,
                                  //           color: Colors.white,
                                  //           boxShadow: [
                                  //             BoxShadow(
                                  //                 color: primaryColor
                                  //                     .withOpacity(0.1),
                                  //                 blurRadius: 4,
                                  //                 spreadRadius: 3,
                                  //                 offset: const Offset(0, 3))
                                  //           ],
                                  //         ),
                                  //         child: Center(
                                  //           child: Image.asset(
                                  //             "${assetsPath}edit.png",
                                  //             color: primaryColor,
                                  //             height:
                                  //                 getPercentSize(editSize, 55),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     onTap: () async {
                                  //       _imgFromGallery();
                                  //     },
                                  //   ),
                                  // )
                                ],
                              ),
                            )),
                        SizedBox(
                          height: (defaultMargin * 2),
                        ),
                        getEditProfileTextFiledWidget(context, "First Name",
                            controller.firstNameController),
                        getEditProfileTextFiledWidget(
                            context, "Last Name", controller.lastNameController),
                        getEditProfilePhoneTextFiledWidget(
                            context, "Phone", controller.phoneController),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: (defaultMargin / 2)),
                    child: getButtonWidget(context, "Save", primaryColor, () {
                      Loader.show(context,
                          isSafeAreaOverlay: false,
                          progressIndicator: const CircularProgressIndicator(),
                          isBottomBarOverlay: false,
                          overlayFromBottom: 0,
                          themeData: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.fromSwatch()
                                  .copyWith(secondary: Colors.black38)),
                          overlayColor: const Color(0x33E8EAF6));
                      controller.modify().then((value) => Loader.hide());
                      controller.onClose();
                      // Navigator.of(context).pop(true);
                    }),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  getTitle(BuildContext context, String string) {
    return Container(
      margin: EdgeInsets.only(top: getScreenPercentSize(context, 3)),
      child: getTextWidget(string, textColor,
          getScreenPercentSize(context, 1.8), FontWeight.w600, TextAlign.start),
    );
  }
}
