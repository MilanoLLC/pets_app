import 'package:flutter/material.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:pets_app/widgets/button_widget.dart';

import 'PhoneVerification.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPage createState() {
    return _ForgotPasswordPage();
  }
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  int themeMode = 0;
  TextEditingController phoneController = TextEditingController();
  String countryCode = "IN";

  Future<bool> _requestPop() {
    Navigator.of(context).pop();

    return Future.value(false);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      setThemePosition(context: context);
      setState(() {});
    });
  }

  TextEditingController textNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          // backgroundColor: backgroundColor,
          appBar: AppBar(
            // backgroundColor: backgroundColor,
            elevation: 0,
            title: const Text(""),
            leading: InkWell(
              onTap: _requestPop,
              child: Icon(
                Icons.keyboard_backspace,
                color: textColor,
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: getHorizontalSpace(context)),
            child: ListView(
              children: [


                SizedBox(
                  height: getScreenPercentSize(context, 3),
                ),


                getTextWithFontFamilyWidget(
                  "Forgot Password",
                  getScreenPercentSize(context, 3),
                  FontWeight.w400,
                  TextAlign.left,
                ),



                SizedBox(
                  height: getScreenPercentSize(context, 0.7),
                ),

                getTextWidget(
                  "We need your registration email to send you password reset code!",
                  textColor,
                  getScreenPercentSize(context, 1.9),
                  FontWeight.w400,
                  TextAlign.left,
                ),

                // getTextWidget(
                //   "Forgot Password",
                //   textColor,
                //   getScreenPercentSize(context, 4),
                //   FontWeight.bold,
                //   TextAlign.left,
                // ),
                // SizedBox(
                //   height: getScreenPercentSize(context, 0.5),
                // ),
                // getTextWidget(
                //   "We need your registration email to send you password reset code!",
                //   subTextColor,
                //   getScreenPercentSize(context, 1.8),
                //   FontWeight.w400,
                //   TextAlign.start,
                // ),
                SizedBox(
                  height: getScreenPercentSize(context, 3),
                ),
                getDefaultTextFiledWidget(context, "Your Email",
                    Icons.account_circle_outlined, textNameController,
                        (value){
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      return null;
                    }),
                SizedBox(
                  height: getScreenPercentSize(context, 2),
                ),
                buttonWidget(context, "Next", primaryColor,Colors.white, () {
                  sendPage();
                }),
              ],
            ),
          ),
        ));
  }

  void sendPage() {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PhoneVerification(false),
        ));
  }
}
