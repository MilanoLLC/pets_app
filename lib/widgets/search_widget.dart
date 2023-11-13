import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';

Widget searchWidget(BuildContext context,SearchFunc){
  double radius = getScreenPercentSize(context, 1.5);
  double defMargin = getScreenPercentSize(context, 2);

  return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: getDecorationWithBorder(
          radius,
          Theme.of(context).cardColor,
        ),
        child: TextField(
          textInputAction: TextInputAction.search,
          style: TextStyle(
              color: Theme.of(context).hintColor),
          decoration: InputDecoration(
            contentPadding:
            EdgeInsets.only(left: defMargin),
            hintText: 'Search by type..',
            suffixIcon: Icon(
              Icons.search,
              color: subTextColor,
            ),
            hintStyle: TextStyle(
              color: subTextColor,
              fontFamily: fontFamily,
              fontSize:
              getScreenPercentSize(context, 1.7),
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            isDense: true,
            fillColor: Colors.transparent,
            disabledBorder: getOutLineBorder(radius),
            enabledBorder: getOutLineBorder(radius),
            focusedBorder: getOutLineBorder(radius),
          ),
          onChanged: SearchFunc
        ),
      ));
}