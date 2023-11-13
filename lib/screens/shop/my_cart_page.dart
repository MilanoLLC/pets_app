import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/controllers/shop_controller.dart';
import 'package:pets_app/model/OrderItemModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/PrefData.dart';
import 'package:pets_app/widgets/SizeConfig.dart';

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
    double height = getScreenPercentSize(context, 11);
    double margin = getScreenPercentSize(context, 2);
    defaultMargin = getHorizontalSpace(context);

    double imageSize = getPercentSize(height, 100);
    double radius = getPercentSize(height, 15);
    return GetBuilder<ShopController>(
        init: ShopController(),
        builder: (controller) {
          return Scaffold(
            // backgroundColor: backgroundColor,
            appBar: AppBar(
                title: const Text("My Cart"),
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_outlined),
                  onPressed: () {
                    Get.back();
                  },
                )),

            body: controller.orderItems.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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

                              return getMaterialCell(context,
                                  widget: InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => TrackOrderPage()));
                                    },
                                    child: Container(
                                      decoration: getDecorationWithRadius(
                                          radius,
                                          Theme.of(context).colorScheme.background),
                                      margin: EdgeInsets.symmetric(
                                          vertical: getPercentSize(height, 10)),
                                      width: double.infinity,
                                      padding: EdgeInsets.all(
                                        getPercentSize(height, 6),
                                      ),
                                      // height: itemHeight,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: imageSize,
                                            width: imageSize,
                                            margin: EdgeInsets.only(
                                                right: (margin / 2)),
                                            child: Card(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(radius)),
                                              clipBehavior: Clip.antiAlias,
                                              child: Image.network(
                                                networkPath +
                                                    model.item!.images![0],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child:
                                                          getCustomTextWithFontFamilyWidget(
                                                              model.item!
                                                                  .enName!,
                                                              Theme.of(context)
                                                                  .hintColor,
                                                              getPercentSize(
                                                                  height, 18),
                                                              FontWeight.w500,
                                                              TextAlign.start,
                                                              1),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: IconButton(
                                                            onPressed: () {
                                                              AwesomeDialog(
                                                                context:
                                                                    context,
                                                                dialogType:
                                                                    DialogType
                                                                        .question,
                                                                headerAnimationLoop:
                                                                    true,
                                                                animType: AnimType
                                                                    .BOTTOMSLIDE,
                                                                title:
                                                                    'Are you sure?',
                                                                // reverseBtnOrder: true,
                                                                btnOkOnPress:
                                                                    () {
                                                                  controller
                                                                      .removeItem(
                                                                          index);
                                                                },
                                                                btnOkText: "ok",
                                                                btnCancelOnPress:
                                                                    () {},
                                                                // desc:
                                                                // 'Lorem ipsum dolor sit amet consectetur adipiscing elit eget ornare tempus, vestibulum sagittis rhoncus felis hendrerit lectus ultricies duis vel, id morbi cum ultrices tellus metus dis ut donec. Ut sagittis viverra venenatis eget euismod faucibus odio ligula phasellus,',
                                                              ).show();
                                                            },
                                                            icon: const Icon(
                                                                Icons.delete)))
                                                    // getCustomTextWidget(
                                                    //
                                                    //     DateFormat('yyyy/MM/dd').format( DateTime.parse(model.item!.createdAt!)).toString(),
                                                    //     Colors.grey,
                                                    //     getPercentSize(height, 18),
                                                    //     FontWeight.w400, TextAlign.start,
                                                    //     1)
                                                  ],
                                                ),

                                                SizedBox(
                                                  height:
                                                      getPercentSize(height, 7),
                                                ),

                                                // getCustomTextWidget(
                                                //     model.item!.serviceType!,
                                                //     Colors.grey,
                                                //     getPercentSize(height, 18),
                                                //     FontWeight.w400,
                                                //     TextAlign.start,
                                                //     1),
                                                //
                                                //
                                                // SizedBox(
                                                //   height: getPercentSize(height, 9),
                                                // ),

                                                Row(
                                                  children: [
                                                    // Expanded(
                                                    //   flex: 1,
                                                    //   child:
                                                    getCustomTextWidget(
                                                        model.item!.price!
                                                            .toString(),
                                                        primaryColor,
                                                        getPercentSize(
                                                            height, 20),
                                                        FontWeight.w600,
                                                        TextAlign.start,
                                                        1),
                                                    Text("   X   ${model.quantity}")
                                                    // ),

                                                    // Container(
                                                    //   padding: EdgeInsets.symmetric(horizontal: getWidthPercentSize(context,2),
                                                    //       vertical: getPercentSize(height, 4)),
                                                    //
                                                    //   decoration: ShapeDecoration(
                                                    //     color: color.withOpacity(0.1),
                                                    //
                                                    //     shape: SmoothRectangleBorder(
                                                    //       side: BorderSide(color: iconColor, width: 0.1),
                                                    //       borderRadius: SmoothBorderRadius(
                                                    //         cornerRadius: radius,
                                                    //         cornerSmoothing: 0.8,
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    //   child: getCustomTextWithFontFamilyWidget(
                                                    //       s,
                                                    //       color,
                                                    //       getPercentSize(height, 16),
                                                    //       FontWeight.w400,
                                                    //       TextAlign.start,
                                                    //       1),
                                                    // )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          )),
                      getMaterialCell(context,
                          widget: Container(
                            // color: primaryColor,
                            margin: EdgeInsets.only(
                                bottom: getScreenPercentSize(context, 2)),
                            padding: EdgeInsets.all(
                                getScreenPercentSize(context, 2)),
                            // decoration: getDecorationWithRadius(
                            //     getScreenPercentSize(context, 1.5),
                            //     primaryColor),
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
                        margin: EdgeInsets.only(
                            top: getScreenPercentSize(context, 0.5)),
                        child: getButtonWidget(
                            context, "Checkout", primaryColor, () {
                          Get.toNamed(Routes.CHECKADDRESS);
                        }),
                      )
                    ],
                  )
                : emptyWidget(context),
          );
        });
  }

  getRow(BuildContext context, String s, String s1, {bool? isTotal}) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: leftMargin),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: getTextWidget(
                      s,
                      Theme.of(context).hintColor,
                      (isTotal != null)
                          ? getScreenPercentSize(context, 2.7)
                          : getScreenPercentSize(context, 2),
                      FontWeight.w400,
                      TextAlign.start)),
              Visibility(
                visible: (isTotal == null),
                child: getTextWidget(
                    s1,
                    Theme.of(context).hintColor,
                    getScreenPercentSize(context, 1.7),
                    FontWeight.bold,
                    TextAlign.start),
              ),
              Visibility(
                visible: (isTotal != null),
                child: getTextWidget(
                    s1,
                    primaryColor,
                    getScreenPercentSize(context, 2.3),
                    FontWeight.bold,
                    TextAlign.start),
              ),
            ],
          ),
          Visibility(
            visible: (isTotal == null),
            child: Container(
              height: 1,
              color: borderColor,
              margin: EdgeInsets.symmetric(
                  vertical: getScreenPercentSize(context, 1.5)),
            ),
          )
        ],
      ),
    );
  }

  emptyWidget(BuildContext context) {
    PrefData.setIsOrder(true);
    double width = getWidthPercentSize(context, 45);
    double height = getScreenPercentSize(context, 7);
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "${assetsPath}no_orders.png",
            height: getScreenPercentSize(context, 20),
          ),
          SizedBox(
            height: getScreenPercentSize(context, 3),
          ),
          getCustomTextWithFontFamilyWidget(
              "No Orders Yet!",
              Theme.of(context).hintColor,
              getScreenPercentSize(context, 2.5),
              FontWeight.w500,
              TextAlign.center,
              1),
          SizedBox(
            height: getScreenPercentSize(context, 1),
          ),
          getCustomTextWidget(
              "Explore more and shortlist some products & Pets.",
              Theme.of(context).hintColor,
              getScreenPercentSize(context, 2),
              FontWeight.w400,
              TextAlign.center,
              1),
          InkWell(
            onTap: () {
              PrefData.setIsCart(true);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
            },
            child: getMaterialCell(context,
                widget: Container(
                    margin:
                        EdgeInsets.only(top: getScreenPercentSize(context, 4)),
                    width: width,
                    height: height,
                    decoration: ShapeDecoration(
                      // color: backgroundColor,
                      shadows: [
                        BoxShadow(
                            color: primaryColor.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 5,
                            offset: const Offset(0, 5))
                      ],
                      shape: SmoothRectangleBorder(
                        side: BorderSide(color: primaryColor, width: 1.5),
                        borderRadius: SmoothBorderRadius(
                          cornerRadius: getPercentSize(height, 25),
                          cornerSmoothing: 0.8,
                        ),
                      ),
                    ),
                    child: Center(
                      child: getCustomTextWidget(
                          "Go to Shop",
                          primaryColor,
                          getPercentSize(width, 10),
                          FontWeight.w600,
                          TextAlign.center,
                          1),
                    ))),
          )
        ],
      ),
    );
  }
}
