import 'package:flutter/material.dart';
import 'package:pets_app/widgets/button_widget.dart';

import '../helpers/constant.dart';
import 'CustomWidget.dart';

class ResetPasswordDialogBox extends StatefulWidget {
  final Function? func;

  const ResetPasswordDialogBox({Key? key, this.func}) : super(key: key);

  @override
  _ResetPasswordDialogBoxState createState() => _ResetPasswordDialogBoxState();
}

class _ResetPasswordDialogBoxState extends State<ResetPasswordDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: backgroundColor,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(left: padding, right: padding, bottom: padding),
          margin: const EdgeInsets.only(top: avatarRadius),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                "${assetsPath}lock.png",
                height: getScreenPercentSize(context, 12),
              ),
              SizedBox(
                height: getScreenPercentSize(context, 5),
              ),
              getCustomTextWidget('Password Changed', textColor, getScreenPercentSize(context, 3),
                  FontWeight.w500, TextAlign.center, 1,context),
              SizedBox(
                height: getScreenPercentSize(context, 1.7),
              ),
              getCustomTextWidget('Your password has been successfully changed!',
                  textColor, getScreenPercentSize(context, 2), FontWeight.w400, TextAlign.center, 2,context),
              SizedBox(
                height: getScreenPercentSize(context, 5),
              ),

              buttonWidget(context, "Ok",primaryColor,Colors.white, (){
                Navigator.of(context).pop();
                widget.func!();
              }),

              SizedBox(
                height: getScreenPercentSize(context, 1.5),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
