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
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/button_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double profileHeight = getScreenPercentSize(context, 18);
    defaultMargin = getHorizontalSpace(context);
    double editSize = getPercentSize(profileHeight, 24);

    return WillPopScope(
        onWillPop: _requestPop,
        child: LoaderOverlay(
          child: Scaffold(
            // extendBodyBehindAppBar: true,
            appBar: appBarBack(context, "Edit Profile", true),
            body:
                // InkWell(
                // onTap: () {
                //   FocusScope.of(context).unfocus();
                // },
                // child:
                Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: getScreenPercentSize(context, 4),
                ),
                ListView(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  children: [
                    Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.only(top: defaultMargin),
                            height: profileHeight,
                            width: profileHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border:
                              Border.all(width: 5, color: primaryColor),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipOval(
                                child: Material(
                                  color: Colors.transparent,
                                  child: getProfileImage(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: getScreenPercentSize(context, 12),
                                  top: getScreenPercentSize(context, 15)),
                              height: editSize,
                              width: editSize,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: primaryColor.withOpacity(0.1),
                                        blurRadius: 4,
                                        spreadRadius: 3,
                                        offset: const Offset(0, 3))
                                  ],
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "${assetsPath}edit.png",
                                    color: Colors.white,
                                    height: getPercentSize(editSize, 55),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () async {
                              _imgFromGallery();
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: (defaultMargin * 2),
                    ),
                    textFiledWidget(
                        context,
                        "First Name",
                        controller.firstNameController,
                        Icons.person_outline,
                        TextInputType.text, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter First Name';
                      }
                      return null;
                    }),
                    textFiledWidget(
                        context,
                        "Last Name",
                        controller.lastNameController,
                        Icons.person_outline,
                        TextInputType.text, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Last Name';
                      }
                      return null;
                    }),
                    textFiledWidget(
                        context,
                        "Email",
                        controller.mailController,
                        Icons.email_outlined,
                        TextInputType.emailAddress, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email';
                      }
                      return null;
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    phoneTextFiledWidget(
                        context, "Phone", controller.phoneController),
                  ],
                ),
                Positioned(
                  bottom: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: buttonWidget(
                        context, "Update", primaryColor,Colors.white, () {
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
                    }),
                  ),
                ),
              ],
            ),
            // ),
          ),
        ));
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
}
