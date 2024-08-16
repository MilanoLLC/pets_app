import 'package:flutter/material.dart';
import 'package:pets_app/controllers/sign_up_controller.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/button_widget.dart';
import 'sign_in_page.dart';
import '../../generated/l10n.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = getScreenPercentSize(context, 7);
    double fontSize = getPercentSize(height, 27);

    return WillPopScope(
        child: GetBuilder<SignUpController>(
            init: SignUpController(),
            builder: (controller) {
              return Scaffold(
                // backgroundColor: backgroundColor,
                appBar: appBarBack(context, "Sign Up", true),
                body: Stack(
                  alignment: Alignment.center,
                  // padding: EdgeInsets.symmetric(
                  //     horizontal: getHorizontalSpace(context)),
                  children: [
                    ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: getHorizontalSpace(context)),
                      children: [
                        SizedBox(
                          height: getScreenPercentSize(context, 2),
                        ),
                        Row(
                          children: [
                            getTextWidget(
                              "Create ",
                              Theme.of(context).hintColor,
                              getScreenPercentSize(context, 2.5),
                              FontWeight.bold,
                              TextAlign.start,
                            ),
                            getTextWidget(
                              "Account",
                              Theme.of(context).hintColor,
                              getScreenPercentSize(context, 2.6),
                              FontWeight.bold,
                              TextAlign.start,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            getTextWidget(
                              "For Meet New ",
                              Theme.of(context).hintColor,
                              getScreenPercentSize(context, 2.4),
                              FontWeight.w400,
                              TextAlign.start,
                            ),
                            getTextWidget(
                              "Friends",
                              primaryColor,
                              getScreenPercentSize(context, 2.7),
                              FontWeight.bold,
                              TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getScreenPercentSize(context, 2),
                        ),
                        textFiledWidget(
                            context,
                            "First Name *",
                            controller.textFirstNameController,
                            Icons.person_outline,
                            TextInputType.text, (value) {
                          if (value.isEmpty) {
                            return 'Please enter your first name';
                          } else if (value.length > 30) {
                            return 'first name should be less than 30 characters';
                          }
                          return null;
                        }),
                        textFiledWidget(
                            context,
                            "Last Name *",
                            controller.textLastNameController,
                            Icons.person_outline,
                            TextInputType.text, (value) {
                          if (value.isEmpty) {
                            return 'Please enter your Last name';
                          } else if (value.length > 30) {
                            return 'Last name should be less than 30 characters';
                          }
                          return null;
                        }),
                        textFiledWidget(
                            context,
                            "User Name *",
                            controller.textUserNameController,
                            Icons.person_outline,
                            TextInputType.text, (value) {
                          if (value.isEmpty) {
                            return 'Please enter a username';
                          } else if (value.length < 3 || value.length > 20) {
                            return 'Username should be between 3 and 20 characters';
                          }
                          return null;
                        }),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getScreenPercentSize(context, 1.4)),
                          child: phoneTextFiledWidget(
                              context, "Phone *", controller.textPhoneController),
                        ),
                        textFiledWidget(
                            context,
                            "Email *",
                            controller.textEmailController,
                            Icons.mail_outline,
                            TextInputType.emailAddress, (value) {
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (value.isEmpty) {
                            return 'Please enter an email address';
                          } else if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null; // Return null if the input is valid
                        }),
                        passwordFieldWidget(
                            context,
                            controller.textPasswordController,
                            controller.passwordVisible, () {
                          controller.changePasswordVisible();
                        }),
                        SizedBox(
                          height: getScreenPercentSize(context, 1.5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                // setState(() {
                                controller.checkTerms();
                                // });
                              },
                              child: Container(
                                height: getScreenPercentSize(context, 3),
                                width: getScreenPercentSize(context, 3),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: primaryColor, width: 1),
                                    color: (controller.isTermsCondition)
                                        ? primaryColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(getScreenPercentSize(
                                            context, 0.5)))),
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    size: getScreenPercentSize(context, 2.5),
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
                                ' I agree with ',
                                Theme.of(context).hintColor,
                                getScreenPercentSize(context, 1.8),
                                FontWeight.w400,
                                TextAlign.start),
                            getTextWidget(
                                "Terms",
                                primaryColor,
                                getScreenPercentSize(context, 1.9),
                                FontWeight.bold,
                                TextAlign.start),
                            getTextWidget(
                                " & ",
                                Theme.of(context).hintColor,
                                getScreenPercentSize(context, 1.8),
                                FontWeight.w400,
                                TextAlign.start),
                            getTextWidget(
                                "Condition",
                                primaryColor,
                                getScreenPercentSize(context, 1.9),
                                FontWeight.bold,
                                TextAlign.start),
                          ],
                        ),
                        SizedBox(
                          height: getScreenPercentSize(context, 3),
                        ),
                      ],
                    ),

                    Positioned(
                      bottom: 1,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: [
                            buttonWidget(
                              context,
                              "Sign Up",
                              primaryColor,
                              Colors.white,
                              controller.isTermsCondition == false
                                  ? () {
                                      Get.snackbar('Error',
                                          "Please agree on our terms and conditions",
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white);
                                    }
                                  : () async {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        await controller.register();

                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.
                                        // ScaffoldMessenger.of(context).showSnackBar(
                                        //   const SnackBar(content: Text('Processing Data')),
                                        // );
                                      }
                                    },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getTextWidget(
                                    S.of(context).youHaveAnAlreadyAccount,
                                    Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.6),
                                    getScreenPercentSize(context, 1.8),
                                    FontWeight.w400,
                                    TextAlign.center),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  child: getTextWidget(
                                      "Sign In",
                                      primaryColor,
                                      getScreenPercentSize(context, 2.3),
                                      FontWeight.bold,
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
                            SizedBox(
                              height: getScreenPercentSize(context, 2),
                            ),
                          ],
                        ),
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
              );
            }),
        onWillPop: () async {
          Get.back();
          return true;
        });
  }
}
