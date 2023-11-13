import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';

Widget cartButtonWidget(BuildContext context,controller){
  double bottomHeight = getScreenPercentSize(context, 7.4);

  return Align(
    alignment: Alignment.bottomRight,
    child: Container(
      width: 70,
      height: bottomHeight,
      margin: EdgeInsets.only(
          bottom: getScreenPercentSize(context, 3),
          right: 10),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius:
        const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.MYCART);
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_basket,
                      color: Colors.white,
                    ),
                    controller.orderItems.isNotEmpty
                        ? Text(
                        "  ${controller.orderItems.length}")
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}