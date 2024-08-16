// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets_app/controllers/setting_controller.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/generated/l10n.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/PrefData.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/empty_widget.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final controller = Get.put(SettingController());
  XFile? _image;
  var storage = getIt<ILocalStorageService>();
  double padding = 0;
  double defMargin = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    padding = getScreenPercentSize(context, 2);
    defMargin = getHorizontalSpace(context);
    height = getScreenPercentSize(context, 5.5);
    double profileHeight = getScreenPercentSize(context, 18);
    var token = storage.get(STORAGE_KEYS.token);

    Container divider = Container(
      margin: EdgeInsets.symmetric(
          vertical: (defMargin / 2.2), horizontal: defMargin),
      height: getScreenPercentSize(context, 0.03),
      color: primaryColor.withOpacity(0.7),
    );

    return token == null || token == ""
        ? emptyWidgetUnauthorized(context)
        : Scaffold(
            appBar: appBarCustom(
                context,
                "Profile",
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: IconButton(
                      onPressed: () {
                        controller.mode();
                      },
                      icon: controller.isDarkTheme.value == true
                          ? const Icon(Icons.light_mode_outlined)
                          : const Icon(Icons.dark_mode_outlined)),
                ),
                false),
            body: Column(
              children: [
                SizedBox(
                  height: getScreenPercentSize(context, 1),
                ),
                Container(
                  height: profileHeight,
                  width: profileHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 5, color: primaryColor),
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
                SizedBox(
                  height: getScreenPercentSize(context, 1),
                ),
                Text(
                  storage.get(STORAGE_KEYS.fullName),
                  style: const TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: getScreenPercentSize(context, 0.5),
                ),
                Text(
                  storage.get(STORAGE_KEYS.userName),
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(
                  height: getScreenPercentSize(context, 2),
                ),
                Expanded(
                  flex: 1,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: getScreenPercentSize(context, 2),
                      ),
                      InkWell(
                        child: _getCell(
                            context, S.of(context).editProfiles, Icons.edit),
                        onTap: () {
                          Get.toNamed(Routes.EDITPROFILE);
                        },
                      ),
                      divider,
                      InkWell(
                        child:
                            _getCell(context, "Addresses", Icons.location_on),
                        onTap: () {
                          Get.toNamed(Routes.EDITADDRESS);
                        },
                      ),
                      divider,
                      InkWell(
                        child: _getCell(context, 'Favorite', Icons.favorite),
                        onTap: () {
                          Get.toNamed(Routes.FAV);
                        },
                      ),
                      divider,
                      InkWell(
                        child: _getCell(
                            context, 'Notification', Icons.notifications),
                        onTap: () {
                          Get.toNamed(Routes.NOTIFICATIONS);
                          // sendAction(NotificationList());
                        },
                      ),

                      divider,
                      InkWell(
                        child: _getCell(context, 'My Pets', Icons.pets),
                        onTap: () {
                          Get.toNamed(Routes.MYPETS);
                          //   sendAction(MyOrderPage(false));
                        },
                      ),
                      divider,
                      InkWell(
                        child:
                            _getCell(context, 'My Orders', Icons.shopping_cart),
                        onTap: () {
                          Get.toNamed(Routes.MYORDERS);
                          //   sendAction(MyOrderPage(false));
                        },
                      ),
                      // divider,
                      // InkWell(
                      //   child: _getCell(
                      //       context, 'Track Order', Icons.shopping_cart),
                      //   onTap: () {
                      //     // Get.toNamed(Routes.TRACKORDER);
                      //   },
                      // ),
                      divider,
                      InkWell(
                        child: _getCell(context, "My Posts", Icons.post_add),
                        onTap: () {
                          Get.toNamed(Routes.MYPOST);
                        },
                      ),
                      // divider,
                      // InkWell(
                      //   child: _getCell(context, S.of(context).mySavedCards,
                      //       Icons.credit_card),
                      //   onTap: () {
                      //     //   sendAction(MySavedCardsPage());
                      //   },
                      // ),
                      divider,
                      InkWell(
                        child: _getCell(
                            context, 'My Adoption', Icons.credit_card,
                            image: "pet.png"),
                        onTap: () {
                          //   sendAction(MyAdoptionPage());
                        },
                      ),
                      divider,
                      InkWell(
                        child: _getCell(
                            context, S.of(context).aboutUs, Icons.info),
                        onTap: () {
                          // sendAction(AboutUsPage());
                        },
                      ),
                      divider,
                      InkWell(
                        child: _getCell(
                            context, S.of(context).logout, Icons.logout),
                        onTap: () {
                          controller.logout();
                        },
                      ),
                      SizedBox(
                        height: getScreenPercentSize(context, 2),
                      ),
                      // buttonWidget(
                      //     context, S.of(context).logout, primaryColor, () {
                      //   controller.logout();
                      // }),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget _getCell(BuildContext context, String s, var icon, {String? image}) {
    double size = getScreenPercentSize(context, 6);
    double iconSize = getPercentSize(size, 50);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: defMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: getScreenPercentSize(context, 1)),
            height: size,
            width: size,
            decoration: ShapeDecoration(
              color: Theme.of(context).cardColor,
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: 10,
                  cornerSmoothing: 0.8,
                ),
              ),
              shadows: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 0.5,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 1))
              ],
            ),
            child: (image != null)
                ? Center(
                    child: Image.asset(
                      assetsPath + image,
                      height: iconSize,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Icon(
                    icon,
                    size: iconSize,
                    color: primaryColor,
                  ),
          ),
          Text(
            s,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: getScreenPercentSize(context, 1.8),
              fontFamily: fontFamily,
              // color: textColor,
            ),
          ),
          const Spacer(),
          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
                padding: EdgeInsets.only(right: 3),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 18,
                )),
          )
        ],
      ),
    );
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
