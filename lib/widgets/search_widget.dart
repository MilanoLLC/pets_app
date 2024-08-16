import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';

Widget searchWidget(BuildContext context, searchFunc) {
  double radius = getScreenPercentSize(context, 1.5);
  double defMargin = getScreenPercentSize(context, 2);

  return Container(
    width: MediaQuery.of(context).size.width-defMargin,
    padding: EdgeInsets.only(left: 10,right: 10,bottom: defMargin),
    child: TextField(
        textInputAction: TextInputAction.search,
        style: TextStyle(color: Theme.of(context).hintColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: defMargin),
          hintText: 'Search Here',
          prefixIcon: Icon(
            Icons.search,
            color: subTextColor,
          ),
          hintStyle: TextStyle(
            color: subTextColor,
            fontFamily: fontFamily,
            fontSize: getScreenPercentSize(context, 1.7),
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          isDense: true,
          fillColor: Theme.of(context).cardColor,
          disabledBorder: getOutLineBorder(radius),
          enabledBorder: getOutLineBorder(radius),
          focusedBorder: getOutLineBorder(radius),

        ),
        onChanged: searchFunc),
  );
}
