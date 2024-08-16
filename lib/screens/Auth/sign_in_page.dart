import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pets_app/controllers/sign_in_controller.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/button_widget.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = getScreenPercentSize(context, 7);
    double fontSize = getPercentSize(height, 27);

    return LoaderOverlay(
      child: WillPopScope(
        child: GetBuilder<SignInController>(
            init: SignInController(),
            builder: (controller) {
              return Scaffold(
                body: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    SizedBox(
                      height: getScreenPercentSize(context, 2),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        "${assetsPath}splash_icon.png",
                        height: getScreenPercentSize(context, 7.5),
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: getScreenPercentSize(context, 1.5),
                    ),
                    getTextWithFontFamilyWidget(
                      "Hey,\nLogin Now",
                      getScreenPercentSize(context, 3),
                      FontWeight.w400,
                      TextAlign.left,
                    ),
                    SizedBox(
                      height: getScreenPercentSize(context, 1.5),
                    ),
                    getTextWidget(
                      "Glad to meet you again!",
                      Theme.of(context).hintColor,
                      getScreenPercentSize(context, 1.8),
                      FontWeight.w500,
                      TextAlign.left,
                    ),
                    SizedBox(
                      height: getScreenPercentSize(context, 2.5),
                    ),
                    textFiledWidget(
                        context,
                        "User Name",
                        controller.textNameController,
                        Icons.person_outline,
                        TextInputType.text, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter user name';
                      }
                      return null;
                    }),
                    SizedBox(
                      height: getScreenPercentSize(context, 1),
                    ),
                    passwordFieldWidget(
                        context,
                        controller.textPasswordController,
                        controller.passwordVisible, () {
                      controller.changePasswordVisible();
                    }),
                    SizedBox(
                      height: getScreenPercentSize(context, 1.5),
                    ),
                    buttonWidget(context, "Login", primaryColor,Colors.white,
                        () {
                      Loader.show(context,
                          isSafeAreaOverlay: false,
                          progressIndicator: const CircularProgressIndicator(),
                          isBottomBarOverlay: false,
                          overlayFromBottom: 0,
                          themeData: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.fromSwatch()
                                  .copyWith(secondary: Colors.black38)),
                          overlayColor: const Color(0x33E8EAF6));

                      controller.login().then((value) => Loader.hide());
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getTextWidget(
                            "Don't have an account?",
                            Theme.of(context).hintColor.withOpacity(0.6),
                            getScreenPercentSize(context, 1.8),
                            FontWeight.w400,
                            TextAlign.center),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          child: getTextWidget(
                              "Sign Up",
                              primaryColor,
                              getScreenPercentSize(context, 2.3),
                              FontWeight.bold,
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
                    )
                  ],
                ),
              );
            }),
        onWillPop: () async {
          Get.back();
          return true;
        },
      ),
    );
  }
}
