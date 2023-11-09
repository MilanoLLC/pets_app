// ignore_for_file: must_be_immutable

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
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

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final controller = Get.put(SettingController());
// class ProfileWidget extends StatefulWidget {
//   final Function function;
//
//   ProfileWidget(this.function, {Key? key}) : super(key: key);
//
//   @override
//   State<ProfileWidget> createState() => _ProfileWidgetState();
// }
//
// class _ProfileWidgetState extends State<ProfileWidget> {

  var storage = getIt<ILocalStorageService>();

  double padding = 0;
  double defMargin = 0;
  double height = 0;

  // ProfileModel profileModel = DataFile.getProfileModel();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    padding = getScreenPercentSize(context, 2);
    defMargin = getHorizontalSpace(context);
    height = getScreenPercentSize(context, 5.5);

    Container divider = Container(
      margin: EdgeInsets.symmetric(
          vertical: (defMargin / 1.5), horizontal: defMargin),
      height: getScreenPercentSize(context, 0.03),
      color: primaryColor.withOpacity(0.7),
    );
    var token = storage.get(STORAGE_KEYS.token);
    print("token = $token");

    return Scaffold(
      appBar: AppBar(
        title: const Text("More"),
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
            child: token == null || token == ""
                ? emptyWidget(context)
                : ListView(
                    children: [
                      SizedBox(
                        height: getScreenPercentSize(context, 1.5),
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
                        child: _getCell(
                            context, "Edit Address", Icons.location_on),
                        onTap: () {
                          Get.toNamed(Routes.ADDRESS);
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
                        child: _getCell(context, 'My Orders', Icons.shopping_bag),
                        onTap: () {
                          Get.toNamed(Routes.MYORDERS);
                          //   sendAction(MyOrderPage(false));
                        },
                      ),
                      divider,
                      InkWell(
                        child: _getCell(context, "My Posts", Icons.post_add),
                        onTap: () {
                          Get.toNamed(Routes.MYPOST);
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
                      // divider,
                      // InkWell(
                      //   child: _getCell(context, 'Track Order', Icons.shopping_cart),
                      //   onTap: () {
                      //     Get.toNamed(Routes.TRACKORDER);
                      //   },
                      // ),

                      // divider,
                      // InkWell(
                      //   child: _getCell(
                      //       context, S.of(context).mySavedCards, Icons.credit_card),
                      //   onTap: () {
                      //     //   sendAction(MySavedCardsPage());
                      //   },
                      // ),
                      // divider,
                      //
                      // InkWell(
                      //   child: _getCell(context, 'My Adoption', Icons.credit_card,
                      //       image: "pet.png"),
                      //   onTap: () {
                      //     //   sendAction(MyAdoptionPage());
                      //   },
                      // ),
                      divider,

                      // InkWell(
                      //   child: _getCell(
                      //       context,
                      //       'Night Mode',
                      //       themMode
                      //           ? Icons.sunny //false = night
                      //           : Icons.nightlight), //true = light
                      //   onTap: () {
                      //     print("themeMode = $themMode}");
                      //     controller.isDarkTheme.value = val;
                      //     Get.changeThemeMode(
                      //       controller.isDarkTheme.value
                      //           ? ThemeMode.dark
                      //           : ThemeMode.light,
                      //     );
                      //     controller.saveThemeStatus();
                      //     // setState(() {
                      //     //   if (themMode) {
                      //     //     PrefData.setNightTheme(false);
                      //     //   } else {
                      //     //     PrefData.setNightTheme(true);
                      //     //   }
                      //     //   getThemeMode();
                      //     // });
                      //
                      //     // widget.function();
                      //   },
                      // ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: defMargin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: getScreenPercentSize(context, 1)),
                                height: getScreenPercentSize(context, 6),
                                width: getScreenPercentSize(context, 6),
                                decoration: BoxDecoration(
                                    color: alphaColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(getPercentSize(
                                            getScreenPercentSize(context, 6),
                                            15)))),
                                child: Icon(
                                  Icons.dark_mode,
                                  size: getPercentSize(
                                      getScreenPercentSize(context, 6), 50),
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Night Mode",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: getScreenPercentSize(context, 2),
                                  fontFamily: fontFamily,
                                  // color: textColor,
                                ),
                              ),
                              const Spacer(),
                              ObxValue(
                                (data) => Switch(
                                  value: controller.isDarkTheme.value,
                                  activeColor: primaryColor,
                                  onChanged: (val) {
                                    print("val = $val");
                                    controller.isDarkTheme.value = val;
                                    if (val == true) {
                                      textColor = Colors.white;
                                      subTextColor = Colors.white70;
                                      iconColor = Colors.grey.shade500;
                                      defBgColor = Colors.black87;
                                    } else {
                                      textColor = Colors.black;
                                      subTextColor = '#79757F'.toColor();
                                      iconColor = "#C4CDDE".toColor();
                                      defBgColor = "#F4F4F4".toColor();
                                    }
                                    Get.changeThemeMode(
                                      controller.isDarkTheme.value
                                          ? ThemeMode.dark
                                          : ThemeMode.light,
                                    );
                                    controller.saveThemeStatus();
                                  },
                                ),
                                false.obs,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ListTile(
                      //   title: Text("Dark Mode".tr),
                      //   contentPadding:
                      //       EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      //   leading: Container(
                      //     margin: EdgeInsets.only(
                      //         right: getScreenPercentSize(context, 1)),
                      //     height: getScreenPercentSize(context, 6),
                      //     width: getScreenPercentSize(context, 6),
                      //     decoration: BoxDecoration(
                      //         color: alphaColor,
                      //         borderRadius: BorderRadius.all(Radius.circular(
                      //             getPercentSize(
                      //                 getScreenPercentSize(context, 6), 15)))),
                      //     child: Icon(
                      //       Icons.sunny,
                      //       size: getPercentSize(
                      //           getScreenPercentSize(context, 6), 50),
                      //       color: primaryColor,
                      //     ),
                      //   ),
                      //   trailing: ObxValue(
                      //     (data) => Switch(
                      //       value: controller.isDarkTheme.value,
                      //       activeColor: Colors.red,
                      //       onChanged: (val) {
                      //         controller.isDarkTheme.value = val;
                      //         Get.changeThemeMode(
                      //           controller.isDarkTheme.value
                      //               ? ThemeMode.dark
                      //               : ThemeMode.light,
                      //         );
                      //         controller.saveThemeStatus();
                      //       },
                      //     ),
                      //     false.obs,
                      //   ),
                      // ),

                      // divider,
                      // InkWell(
                      //   child: _getCell(
                      //       context, S.of(context).review, Icons.rate_review),
                      //   onTap: () {
                      //     // sendAction(WriteReviewPage());
                      //   },
                      // ),
                      divider,
                      InkWell(
                        child: _getCell(
                            context, S.of(context).aboutUs, Icons.info),
                        onTap: () {
                          // sendAction(AboutUsPage());
                        },
                      ),

                      SizedBox(
                        height: getScreenPercentSize(context, 2),
                      ),
                      getButtonWidget(
                          context, S.of(context).logout, primaryColor, () {
                        controller.logout();
                      }),
                    ],
                  ),
          ),
        ],
      ),
    );

    //   Container(
    //   width: double.infinity,
    //   // color: backgroundColor,
    //   child: Column(
    //     children: [
    //       getAppBar(context, "More"),
    //       SizedBox(
    //         height: getScreenPercentSize(context, 1.5),
    //       ),
    //       token == null || token == ""
    //           ? emptyWidget(context)
    //           : Expanded(
    //               flex: 1,
    //               child: ListView(
    //                 children: [
    //                   SizedBox(
    //                     height: getScreenPercentSize(context, 1.5),
    //                   ),
    //                   InkWell(
    //                     child: _getCell(
    //                         context, S.of(context).editProfiles, Icons.edit),
    //                     onTap: () {
    //                       Get.toNamed(Routes.EDITPROFILE);
    //                     },
    //                   ),
    //                   divider,
    //                   InkWell(
    //                     child: _getCell(
    //                         context, "Edit Address", Icons.location_on),
    //                     onTap: () {
    //                       Get.toNamed(Routes.ADDRESS);
    //                     },
    //                   ),
    //                   divider,
    //                   InkWell(
    //                     child: _getCell(context, 'My Pets', Icons.shopping_bag),
    //                     onTap: () {
    //                       //   sendAction(MyOrderPage(false));
    //                     },
    //                   ),
    //                   divider,
    //
    //                   InkWell(
    //                     child: _getCell(
    //                         context, 'Notification', Icons.notifications_none),
    //                     onTap: () {
    //                       Get.toNamed(Routes.NOTIFICATIONS);
    //                       // sendAction(NotificationList());
    //                     },
    //                   ),
    //                   // divider,
    //                   // InkWell(
    //                   //   child: _getCell(context, 'Track Order', Icons.shopping_cart),
    //                   //   onTap: () {
    //                   //     Get.toNamed(Routes.TRACKORDER);
    //                   //   },
    //                   // ),
    //
    //                   // divider,
    //                   // InkWell(
    //                   //   child: _getCell(
    //                   //       context, S.of(context).mySavedCards, Icons.credit_card),
    //                   //   onTap: () {
    //                   //     //   sendAction(MySavedCardsPage());
    //                   //   },
    //                   // ),
    //                   // divider,
    //                   //
    //                   // InkWell(
    //                   //   child: _getCell(context, 'My Adoption', Icons.credit_card,
    //                   //       image: "pet.png"),
    //                   //   onTap: () {
    //                   //     //   sendAction(MyAdoptionPage());
    //                   //   },
    //                   // ),
    //                   divider,
    //
    //                   // InkWell(
    //                   //   child: _getCell(
    //                   //       context,
    //                   //       'Night Mode',
    //                   //       themMode
    //                   //           ? Icons.sunny //false = night
    //                   //           : Icons.nightlight), //true = light
    //                   //   onTap: () {
    //                   //     print("themeMode = $themMode}");
    //                   //     controller.isDarkTheme.value = val;
    //                   //     Get.changeThemeMode(
    //                   //       controller.isDarkTheme.value
    //                   //           ? ThemeMode.dark
    //                   //           : ThemeMode.light,
    //                   //     );
    //                   //     controller.saveThemeStatus();
    //                   //     // setState(() {
    //                   //     //   if (themMode) {
    //                   //     //     PrefData.setNightTheme(false);
    //                   //     //   } else {
    //                   //     //     PrefData.setNightTheme(true);
    //                   //     //   }
    //                   //     //   getThemeMode();
    //                   //     // });
    //                   //
    //                   //     // widget.function();
    //                   //   },
    //                   // ),
    //                   InkWell(
    //                     child: Container(
    //                       margin: EdgeInsets.symmetric(horizontal: defMargin),
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           Container(
    //                             margin: EdgeInsets.only(
    //                                 right: getScreenPercentSize(context, 1)),
    //                             height: getScreenPercentSize(context, 6),
    //                             width: getScreenPercentSize(context, 6),
    //                             decoration: BoxDecoration(
    //                                 color: alphaColor,
    //                                 borderRadius: BorderRadius.all(
    //                                     Radius.circular(getPercentSize(
    //                                         getScreenPercentSize(context, 6),
    //                                         15)))),
    //                             child: Icon(
    //                               Icons.dark_mode,
    //                               size: getPercentSize(
    //                                   getScreenPercentSize(context, 6), 50),
    //                               color: Colors.black,
    //                             ),
    //                           ),
    //                           Text(
    //                             "Night Mode",
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.w400,
    //                               fontSize: getScreenPercentSize(context, 2),
    //                               fontFamily: fontFamily,
    //                               // color: textColor,
    //                             ),
    //                           ),
    //                           const Spacer(),
    //                           ObxValue(
    //                             (data) => Switch(
    //                               value: controller.isDarkTheme.value,
    //                               activeColor: Colors.red,
    //                               onChanged: (val) {
    //                                 controller.isDarkTheme.value = val;
    //                                 Get.changeThemeMode(
    //                                   controller.isDarkTheme.value
    //                                       ? ThemeMode.dark
    //                                       : ThemeMode.light,
    //                                 );
    //                                 controller.saveThemeStatus();
    //                               },
    //                             ),
    //                             false.obs,
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //
    //                   // ListTile(
    //                   //   title: Text("Dark Mode".tr),
    //                   //   contentPadding:
    //                   //       EdgeInsets.symmetric(horizontal: 15, vertical: 0),
    //                   //   leading: Container(
    //                   //     margin: EdgeInsets.only(
    //                   //         right: getScreenPercentSize(context, 1)),
    //                   //     height: getScreenPercentSize(context, 6),
    //                   //     width: getScreenPercentSize(context, 6),
    //                   //     decoration: BoxDecoration(
    //                   //         color: alphaColor,
    //                   //         borderRadius: BorderRadius.all(Radius.circular(
    //                   //             getPercentSize(
    //                   //                 getScreenPercentSize(context, 6), 15)))),
    //                   //     child: Icon(
    //                   //       Icons.sunny,
    //                   //       size: getPercentSize(
    //                   //           getScreenPercentSize(context, 6), 50),
    //                   //       color: primaryColor,
    //                   //     ),
    //                   //   ),
    //                   //   trailing: ObxValue(
    //                   //     (data) => Switch(
    //                   //       value: controller.isDarkTheme.value,
    //                   //       activeColor: Colors.red,
    //                   //       onChanged: (val) {
    //                   //         controller.isDarkTheme.value = val;
    //                   //         Get.changeThemeMode(
    //                   //           controller.isDarkTheme.value
    //                   //               ? ThemeMode.dark
    //                   //               : ThemeMode.light,
    //                   //         );
    //                   //         controller.saveThemeStatus();
    //                   //       },
    //                   //     ),
    //                   //     false.obs,
    //                   //   ),
    //                   // ),
    //
    //                   // divider,
    //                   // InkWell(
    //                   //   child: _getCell(
    //                   //       context, S.of(context).review, Icons.rate_review),
    //                   //   onTap: () {
    //                   //     // sendAction(WriteReviewPage());
    //                   //   },
    //                   // ),
    //                   divider,
    //                   InkWell(
    //                     child: _getCell(
    //                         context, S.of(context).aboutUs, Icons.info),
    //                     onTap: () {
    //                       // sendAction(AboutUsPage());
    //                     },
    //                   ),
    //
    //                   SizedBox(
    //                     height: getScreenPercentSize(context, 2),
    //                   ),
    //                   getButtonWidget(
    //                       context, S.of(context).logout, primaryColor, () {
    //                     controller.logout();
    //                   }),
    //                 ],
    //               ),
    //             ),
    //     ],
    //   ),
    // );
  }

  bool themMode = false;

  getThemeMode() async {
    themMode = await PrefData.getNightTheme();
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
            decoration: BoxDecoration(
                color: alphaColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(getPercentSize(size, 15)))),
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
              fontSize: getScreenPercentSize(context, 2),
              fontFamily: fontFamily,
              // color: textColor,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Image.asset(
                "${assetsPath}right-chevron.png",
                color: Theme.of(context).hintColor,
                height: getScreenPercentSize(context, 2),
              ),
            ),
          )
        ],
      ),
    );
  }

  emptyWidget(BuildContext context) {
    double height = getScreenPercentSize(context, 7);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "${iconsPath}box.png",
          height: getScreenPercentSize(context, 20),
        ),
        SizedBox(
          height: getScreenPercentSize(context, 3),
        ),
        getCustomTextWithFontFamilyWidget(
            "You are not logged in!",
            Theme.of(context).hintColor,
            getScreenPercentSize(context, 2.5),
            FontWeight.w500,
            TextAlign.center,
            1),
        const SizedBox(
          height: 15,
        ),
        MaterialButton(
          onPressed: () {
            Get.toNamed(Routes.SIGNIN);
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
              color: Theme.of(context).primaryColor,
              shape: SmoothRectangleBorder(
                side: BorderSide(color: primaryColor, width: 1.5),
                borderRadius: SmoothBorderRadius(
                  cornerRadius: getPercentSize(height, 25),
                  cornerSmoothing: 0.8,
                ),
              ),
            ),
            child: Center(
                child: getDefaultTextWidget("Log in", TextAlign.center,
                    FontWeight.w500, 20, Theme.of(context).cardColor)),
          ),
        ),
      ],
    );
  }
}
