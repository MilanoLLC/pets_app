import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/controllers/shop_controller.dart';
import 'package:pets_app/model/OrderItemModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/button_widget.dart';
import 'package:pets_app/widgets/cart_widget.dart';
import 'package:pets_app/widgets/empty_widget.dart';

class MyCartPage extends GetView<ShopController> {
  MyCartPage({Key? key}) : super(key: key);
  double defaultMargin = 0;

  double getSubtotal() {
    double subtotal = 0;
    for (int i = 0; i < controller.orderItems.length; i++) {
      subtotal = subtotal +
          (controller.orderItems[i].item!.price! *
              controller.orderItems[i].quantity!);
    }
    return subtotal;
  }

  double getShipping() {
    double shipping = 5;
    return shipping;
  }

  double getTax() {
    double tax = 0;
    double temp = getSubtotal() + getShipping();
    tax = temp * 5 / 100;
    return tax;
  }

  double getTotal() {
    double total = getSubtotal() + getShipping() + getTax();
    return total;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    defaultMargin = getHorizontalSpace(context);

    return GetBuilder<ShopController>(
        init: ShopController(),
        builder: (controller) {
          return Scaffold(
              // backgroundColor: backgroundColor,
              appBar: appBarBack(context, "My Cart", true),
              body: controller.orderItems.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: getScreenPercentSize(context, 2),
                        ),

                        // Visibility(
                        //   visible: isData,
                        //   child: Padding(
                        //     padding:  EdgeInsets.symmetric(horizontal: defaultMargin),
                        //     child: getTextWithFontFamilyWidget("List of your orders", textColor, getScreenPercentSize(context, 2),
                        //         FontWeight.w500, TextAlign.center),
                        //   ),
                        // ),

                        SizedBox(
                          height: getScreenPercentSize(context, 1),
                        ),
                        Expanded(
                          flex: 1,
                          child: ListView.builder(
                            primary: true,
                            shrinkWrap: true,
                            padding:
                                EdgeInsets.symmetric(horizontal: defaultMargin),
                            itemCount: controller.orderItems.length,
                            itemBuilder: (context, index) {
                              OrderItemModel model =
                                  controller.orderItems[index];
                              // String s="Delivered";
                              // Color color="#2BBB4D".toColor();
                              //
                              // if(index %4==0){
                              //   s="Pending";
                              //   color="#DE9C2B".toColor();
                              // }else if(index %4==1){
                              //   s="Adopted";
                              //   color="#2BBB4D".toColor();
                              // }else if(index %4==2){
                              //   s="Cancelled";
                              //   color="#FA001D".toColor();
                              // }
                              return cartWidget(context, model, controller, index);
                            },
                          ),
                        ),
                        // const Divider(
                        //   color: Colors.grey,
                        //   height: 10,
                        //   thickness: 0.5,
                        //   indent: 20,
                        //   endIndent: 20,
                        // ),
                        getMaterialCell(context,
                            widget: Container(
                              // color: Theme.of(context).cardColor,
                              margin: EdgeInsets.all(
                                  getScreenPercentSize(context, 2)),
                              padding: EdgeInsets.all(
                                  getScreenPercentSize(context, 2)),
                              decoration: getDecorationWithRadius(
                                  getScreenPercentSize(context, 1.5),
                                  Theme.of(context).cardColor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getRow(context, "Subtotal",
                                      "${getSubtotal()} AED"),
                                  getRow(context, "Shipping",
                                      "${getShipping()} AED"),
                                  getRow(
                                      context, "Tax ( 2% )", "${getTax()} AED"),
                                  getRow(context, "Total", "${getTotal()} AED",
                                      isTotal: true),
                                ],
                              ),
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          margin: EdgeInsets.only(
                              top: getScreenPercentSize(context, 0.5)),
                          child: buttonWidget(
                              context, "Checkout", primaryColor,Colors.white, () {
                            Get.toNamed(Routes.CHECKADDRESS);
                          }),
                        )
                      ],
                    )
                  : emptyWidgetWithButton(
                      context,
                      "${iconsPath}search.png",
                      "",
                      "No Orders Yet",
                      "Explore more and shortlist some products & Pets.",
                      "Go to Shop", () {
                      Get.toNamed(Routes.MAIN);
                    })
              // emptyWidget(context),
              );
        });
  }

  getRow(BuildContext context, String s, String s1, {bool? isTotal}) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: getTextWidget(
                    s,
                    Theme.of(context).hintColor,
                    (isTotal != null)
                        ? getScreenPercentSize(context, 2)
                        : getScreenPercentSize(context, 1.8),
                    (isTotal != null) ? FontWeight.bold : FontWeight.normal,
                    TextAlign.start)),
            Visibility(
              visible: (isTotal == null),
              child: getTextWidget(
                  s1,
                  Theme.of(context).hintColor,
                  getScreenPercentSize(context, 2),
                  FontWeight.bold,
                  TextAlign.start),
            ),
            Visibility(
              visible: (isTotal != null),
              child: getTextWidget(
                  s1,
                  primaryColor,
                  getScreenPercentSize(context, 2.2),
                  FontWeight.bold,
                  TextAlign.start),
            ),
          ],
        ),
        Visibility(
          visible: (isTotal == null),
          child: Container(
            height: 1,
            color: borderColor.withOpacity(0.3),
            margin: EdgeInsets.symmetric(
                vertical: getScreenPercentSize(context, 1.5),

            ),
          ),
        )
      ],
    );
  }
}
