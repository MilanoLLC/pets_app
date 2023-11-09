import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pets_app/controllers/sign_in_controller.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';
import 'package:figma_squircle/figma_squircle.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

//
class _SignInPageState extends State<SignInPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
//
// class SignInPage extends StatelessWidget {
  final controller = Get.put(SignInController());

  // SignInPage({Key? key}) : super(key: key); // inject controller
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    double height = getScreenPercentSize(context, 7);
    double radius = getPercentSize(height, 20);
    double fontSize = getPercentSize(height, 27);

    return LoaderOverlay(
      child: WillPopScope(
        child: Scaffold(
          // backgroundColor: backgroundColor,

          body: Container(
            padding:
                EdgeInsets.symmetric(horizontal: getHorizontalSpace(context)),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
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
                      getDefaultTextFiledWidget(
                          context,
                          "User name",
                          Icons.account_circle_outlined,
                          controller.textNameController),
                      Container(
                        height: height,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                            vertical: getScreenPercentSize(context, 1.2)),
                        decoration: ShapeDecoration(
                          color: cellColor,
                          shape: SmoothRectangleBorder(
                            side: BorderSide(color: borderColor, width: 1),
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: radius,
                              cornerSmoothing: 0.8,
                            ),
                          ),
                        ),
                        child: TextField(
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          controller: controller.textPasswordController,
                          style: TextStyle(
                              fontFamily: fontFamily,
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: fontSize),
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: getWidthPercentSize(context, 4)),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            isDense: true,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: fontFamily,
                                color: subTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: fontSize),
                            // labelText: "",
                            // helperText:
                            //     "Password must contain special character",
                            helperStyle: const TextStyle(color: Colors.green),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                            alignLabelWithHint: false,
                            // filled: true,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      SizedBox(
                        height: getScreenPercentSize(context, 1.5),
                      ),
                      SizedBox(
                        height: getScreenPercentSize(context, 4),
                      ),
                      getButtonWithoutSpaceWidget(
                          context, "Login", primaryColor, () {
                        Loader.show(context,
                            isSafeAreaOverlay: false,
                            progressIndicator:
                                const CircularProgressIndicator(),
                            isBottomBarOverlay: false,
                            overlayFromBottom: 0,
                            themeData: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.fromSwatch()
                                    .copyWith(secondary: Colors.black38)),
                            overlayColor: const Color(0x33E8EAF6));

                        controller.login().then((value) => Loader.hide());
                      }),
                    ],
                  ),
                  // flex: 1,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: getScreenPercentSize(context, 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getTextWidget(
                            "Don't have an account?",
                            Theme.of(context).hintColor,
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
            ),
          ),
        ),
        onWillPop: () async {
          Get.back();
          return true;
        },
      ),
    );
  }
}
