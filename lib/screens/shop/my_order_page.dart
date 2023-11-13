import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pets_app/controllers/shop_controller.dart';
import 'package:pets_app/model/OrderItemModel.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/PrefData.dart';
import 'package:pets_app/widgets/SizeConfig.dart';

class MyOrderPage extends GetView<ShopController> {
  // final bool isHomePage;

  MyOrderPage({Key? key}) : super(key: key);

//   @override
//   _MyOrderPage createState() {
//     return _MyOrderPage();
//   }
// }

// class _MyOrderPage extends State<MyOrderPage>
//     with SingleTickerProviderStateMixin {
  // List<AnimalModel> myOrderList = DataFile.getProductModel();
  //
  //   List<AnimalModel> orderList = DataFile.getOrderDescList();
  // List<AnimalModel> allOrderList = DataFile.getOrderList();

  bool isData = false;

  // @override
  // void initState() {
  //   super.initState();
  //
  //
  //   isDataAvailable();
  //   setState(() {});
  // }
  // isDataAvailable() async {
  //   isData = await PrefData.getIsOrder();
  //   setState(() {});
  // }

  // Future<bool> _requestPop() {
  //   Navigator.of(context).pop();
  //   return new Future.value(true);
  // }
  double defaultMargin = 0;

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
                title: const Text("My Orders"),
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_outlined),
                  onPressed: () {
                    Get.back();
                  },
                )),

            body: Column(
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
                  child: controller.orderItems.isNotEmpty
                      ? ListView.builder(
                          primary: true,
                          shrinkWrap: true,
                          padding:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          itemCount: controller.orderItems.length,
                          itemBuilder: (context, index) {
                            OrderItemModel model = controller.orderItems[index];
                            String s = "Delivered";
                            Color color = "#2BBB4D".toColor();

                            if (index % 4 == 0) {
                              s = "Pending";
                              color = "#DE9C2B".toColor();
                            } else if (index % 4 == 1) {
                              s = "Adopted";
                              color = "#2BBB4D".toColor();
                            } else if (index % 4 == 2) {
                              s = "Cancelled";
                              color = "#FA001D".toColor();
                            }

                            return getMaterialCell(context,
                                widget: InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => TrackOrderPage()));
                                  },
                                  child: Container(
                                    decoration: getDecorationWithRadius(radius,
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
                                              fit: BoxFit.fill,
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
                                                            model.item!.enName!,
                                                            Theme.of(context).hintColor,
                                                            getPercentSize(
                                                                height, 18),
                                                            FontWeight.w500,
                                                            TextAlign.start,
                                                            1),
                                                  ),
                                                  getCustomTextWidget(
                                                      DateFormat('yyyy/MM/dd')
                                                          .format(DateTime
                                                              .parse(model.item!
                                                                  .createdAt!))
                                                          .toString(),
                                                      Colors.grey,
                                                      getPercentSize(
                                                          height, 18),
                                                      FontWeight.w400,
                                                      TextAlign.start,
                                                      1)
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    getPercentSize(height, 7),
                                              ),
                                              getCustomTextWidget(
                                                  model.item!.serviceType!,
                                                  Theme.of(context).hintColor,
                                                  getPercentSize(height, 18),
                                                  FontWeight.w400,
                                                  TextAlign.start,
                                                  1),
                                              SizedBox(
                                                height:
                                                    getPercentSize(height, 9),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: getCustomTextWidget(
                                                        model.item!.price!
                                                            .toString(),
                                                        primaryColor,
                                                        getPercentSize(
                                                            height, 18),
                                                        FontWeight.w600,
                                                        TextAlign.start,
                                                        1),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal:
                                                            getWidthPercentSize(
                                                                context, 2),
                                                        vertical:
                                                            getPercentSize(
                                                                height, 4)),
                                                    decoration: ShapeDecoration(
                                                      color: color
                                                          .withOpacity(0.1),
                                                      shape:
                                                          SmoothRectangleBorder(
                                                        side: BorderSide(
                                                            color: iconColor,
                                                            width: 0.1),
                                                        borderRadius:
                                                            SmoothBorderRadius(
                                                          cornerRadius: radius,
                                                          cornerSmoothing: 0.8,
                                                        ),
                                                      ),
                                                    ),
                                                    child:
                                                        getCustomTextWithFontFamilyWidget(
                                                            s,
                                                            color,
                                                            getPercentSize(
                                                                height, 16),
                                                            FontWeight.w400,
                                                            TextAlign.start,
                                                            1),
                                                  )
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
                        )
                      : emptyWidget(context),
                ),
              ],
            ),
          );
        });
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
