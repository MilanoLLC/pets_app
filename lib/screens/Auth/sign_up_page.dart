import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pets_app/controllers/sign_up_controller.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:get/get.dart';
import 'sign_in_page.dart';
import '../../generated/l10n.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:figma_squircle/figma_squircle.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final controller = Get.put(SignUpController());

  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = getScreenPercentSize(context, 7);
    double radius = getPercentSize(height, 20);
    double fontSize = getPercentSize(height, 27);

    return WillPopScope(
        child: GetBuilder<SignUpController>(
            init: SignUpController(),
            builder: (controller) {
              return Scaffold(
                // backgroundColor: backgroundColor,
                appBar: AppBar(
                  // backgroundColor: backgroundColor,
                  elevation: 0,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    // statusBarColor: backgroundColor,
                    statusBarIconBrightness: Brightness.dark,
                    // For Android (dark icons)
                    statusBarBrightness:
                        Brightness.light, // For iOS (dark icons)
                  ),
                  title: const Text(""),
                  leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.keyboard_backspace,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
                body: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontalSpace(context)),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              SizedBox(
                                height: getScreenPercentSize(context, 3),
                              ),
                              getTextWithFontFamilyWidget(
                                "Sign Up",
                                getScreenPercentSize(context, 3),
                                FontWeight.w400,
                                TextAlign.left,
                              ),
                              SizedBox(
                                height: getScreenPercentSize(context, 1),
                              ),
                              getTextWidget(
                                "Create Account for meet now Friends!",
                                Theme.of(context).hintColor,
                                getScreenPercentSize(context, 1.9),
                                FontWeight.w400,
                                TextAlign.left,
                              ),
                              SizedBox(
                                height: getScreenPercentSize(context, 2.5),
                              ),
                              getDefaultTextFiledWidget(
                                  context,
                                  "First Name",
                                  Icons.account_circle_outlined,
                                  controller.textFirstNameController),
                              getDefaultTextFiledWidget(
                                  context,
                                  "Last Name",
                                  Icons.account_circle_outlined,
                                  controller.textLastNameController),
                              getDefaultTextFiledWidget(
                                  context,
                                  "User Name",
                                  Icons.account_circle_outlined,
                                  controller.textUserNameController),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        getScreenPercentSize(context, 1.2)),
                                child: IntlPhoneField(
                                  controller: controller.textPhoneController,
                                  flagsButtonPadding: const EdgeInsets.all(8),
                                  dropdownIconPosition: IconPosition.trailing,
                                  decoration: const InputDecoration(
                                    labelText: 'Phone Number',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  initialCountryCode: 'AE',
                                  onChanged: (phone) {
                                    controller.flagChanged(phone.countryCode);
                                    controller
                                        .phoneChanged(phone.completeNumber);
                                  },
                                ),
                              ),
                              getDefaultTextFiledWidget(
                                  context,
                                  "Email",
                                  Icons.mail_outline,
                                  controller.textEmailController),
                              Container(
                                height: height,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.symmetric(
                                    vertical:
                                        getScreenPercentSize(context, 1.2)),
                                decoration: ShapeDecoration(
                                  color: cellColor,
                                  shape: SmoothRectangleBorder(
                                    side: BorderSide(
                                        color: borderColor, width: 1),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        controller.checkTerms();
                                      });
                                    },
                                    child: Container(
                                      height: getScreenPercentSize(context, 3),
                                      width: getScreenPercentSize(context, 3),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  primaryColor.withOpacity(0.4),
                                              width: 1),
                                          color: (controller.isTermsCondition)
                                              ? primaryColor
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  getScreenPercentSize(
                                                      context, 0.5)))),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          size: getScreenPercentSize(
                                              context, 2.5),
                                          color: (controller.isTermsCondition)
                                              ? Colors.white
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  getTextWidget(
                                      'I agree with ',
                                      Theme.of(context).hintColor,
                                      getScreenPercentSize(context, 1.8),
                                      FontWeight.w600,
                                      TextAlign.center),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  getTextWidget(
                                      "Terms",
                                      primaryColor,
                                      getScreenPercentSize(context, 1.8),
                                      FontWeight.w600,
                                      TextAlign.center),
                                  getTextWidget(
                                      " & ",
                                      Theme.of(context).hintColor,
                                      getScreenPercentSize(context, 1.8),
                                      FontWeight.w600,
                                      TextAlign.center),
                                  getTextWidget(
                                      "Condition",
                                      primaryColor,
                                      getScreenPercentSize(context, 1.8),
                                      FontWeight.w600,
                                      TextAlign.center),
                                ],
                              ),
                              SizedBox(
                                height: getScreenPercentSize(context, 3),
                              ),
                              MaterialButton(
                                onPressed: controller.isTermsCondition == false
                                    ? () {
                                        Get.snackbar('Error',
                                            "Please agree on our terms and conditions",
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white);
                                      }
                                    : () async {
                                        await controller.register();
                                      },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            getPercentSize(radius, 85)))),
                                child: Container(
                                  height: getScreenPercentSize(context, 7),
                                  margin: EdgeInsets.only(
                                      top: getScreenPercentSize(context, 1.2),
                                      bottom: getHorizontalSpace(context),
                                      left: getHorizontalSpace(context),
                                      right: getHorizontalSpace(context)),
                                  decoration: ShapeDecoration(
                                    color: controller.isTermsCondition
                                        ? primaryColor
                                        : Colors.grey,
                                    shape: SmoothRectangleBorder(
                                      side: BorderSide(
                                          color: subTextColor, width: 0.3),
                                      borderRadius: SmoothBorderRadius(
                                        cornerRadius: radius,
                                        cornerSmoothing: 0.8,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                      child: getDefaultTextWidget(
                                          "Sign Up",
                                          TextAlign.center,
                                          FontWeight.w500,
                                          20,
                                          Colors.white)),
                                ),
                              ),
                              // getButtonWithoutSpaceWidget(
                              //     context, "Sign Up", primaryColor, () {
                              //   controller.register();
                              //   // Navigator.pop(context);
                              //   // Navigator.push(
                              //   //     context,
                              //   //     MaterialPageRoute(
                              //   //       builder: (context) => PhoneVerification(true),
                              //   //     ));
                              // }),
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
                                    S.of(context).youHaveAnAlreadyAccount,
                                    Theme.of(context).hintColor,
                                    getScreenPercentSize(context, 2),
                                    FontWeight.w400,
                                    TextAlign.center),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  child: getTextWidget(
                                      "Sign In",
                                      primaryColor,
                                      getScreenPercentSize(context, 2),
                                      FontWeight.w700,
                                      TextAlign.center),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignInPage()));
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
              );
            }),
        onWillPop: () async {
          Get.back();
          return true;
        });
  }
}
