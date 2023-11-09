import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pets_app/controllers/shop_controller.dart';
import 'package:pets_app/model/DataModel.dart';
import 'package:pets_app/model/ServiceModel.dart';
import 'package:pets_app/routes/app_pages.dart';
// import 'package:pets_app/model/ProductModel.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/DataFile.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:get/get.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin {
  late TabController tabcontroller;
  int _selectedIndex = 0;

  final controller = Get.put(ShopController());

  double padding = 0;
  double defMargin = 0;
  double height = 0;

  List<DataModel> dataList = DataFile.getCategoryData();
  // List<ProductModel> productList = DataFile.getProductModel();

  // final controller = Get.put(HomeController());

  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    tabcontroller = TabController(length: 2, vsync: this);
    // controller.services = [];
    // if (_selectedIndex == 0) {
    //   controller.getAllServicesByTyp("SERVICE");
    // } else if (_selectedIndex == 1) {
    //   controller.getAllServicesByTyp("GOODS");
    // }
    tabcontroller.addListener(() {
      setState(() {
        _selectedIndex = tabcontroller.index;
      });
      print("Selected Index: ${tabcontroller.index}");
      if (tabcontroller.index == 1) {
        Loader.show(context,
            isSafeAreaOverlay: false,
            progressIndicator: const CircularProgressIndicator(),
            isBottomBarOverlay: false,
            overlayFromBottom: 0,
            themeData: Theme.of(context).copyWith(
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: Colors.black38)),
            overlayColor: const Color(0x33E8EAF6));

        controller.services = [];
        controller
            .getAllServicesByTyp("SERVICE")
            .then((value) => Loader.hide());
      } else if (tabcontroller.index == 0) {
        Loader.show(context,
            isSafeAreaOverlay: false,
            progressIndicator: const CircularProgressIndicator(),
            isBottomBarOverlay: false,
            overlayFromBottom: 0,
            themeData: Theme.of(context).copyWith(
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: Colors.black38)),
            overlayColor: const Color(0x33E8EAF6));

        controller.services = [];
        controller.getAllServicesByTyp("GOODS").then((value) => Loader.hide());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    padding = getScreenPercentSize(context, 2);
    defMargin = getScreenPercentSize(context, 2);
    height = getScreenPercentSize(context, 6);
    double bottomHeight = getScreenPercentSize(context, 7.4);
    double bottomWidth = getWidthPercentSize(context, 48);
    double radius = getScreenPercentSize(context, 1.5);
    return LoaderOverlay(
        child: GetBuilder<ShopController>(
            init: ShopController(),
            builder: (controller) {
              return Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    controller: tabcontroller,
                    tabs: [

                      Tab(
                        child: Text(
                          "Goods",
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Services",
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                      ),
                    ],
                  ),
                  title: const Text("Shop"),
                  elevation: 0,
                  centerTitle: true,
                ),
                body: TabBarView(controller: tabcontroller, children: [
                  Stack(
                    children: [
                      // Expanded(
                      //   flex: 1,
                      //   child:
                      ListView(
                        children: [
                          SizedBox(
                            height: getScreenPercentSize(context, 1.5),
                          ),

                          Row(
                            children: [
                              SizedBox(
                                width: defMargin,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
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
                                        // prefixIcon: Icon(Icons.search),
                                        suffixIcon: Icon(
                                          Icons.search,
                                          color: subTextColor,
                                        ),
                                        hintStyle: TextStyle(
                                          color: subTextColor,
                                          fontFamily: fontFamily,
                                          fontSize: getScreenPercentSize(
                                              context, 1.7),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        filled: true,
                                        isDense: true,
                                        fillColor: Colors.transparent,
                                        disabledBorder:
                                            getOutLineBorder(radius),
                                        enabledBorder: getOutLineBorder(radius),
                                        focusedBorder: getOutLineBorder(radius),
                                      ),
                                      onChanged: (string) {
                                        controller
                                            .filterSearchResultsByType(string);
                                      },
                                    ),
                                  )),
                              SizedBox(width: defMargin),
                            ],
                          ),

                          // Container(
                          //   margin: EdgeInsets.all(defMargin),
                          //   decoration: getDecoration(radius),
                          //   child: TextField(
                          //     style: TextStyle(
                          //       fontFamily: fontFamily,
                          //       color: textColor,
                          //       fontWeight: FontWeight.w400,
                          //       fontSize: getScreenPercentSize(context, 1.7),
                          //     ),
                          //     onChanged: (string) {},
                          //     maxLines: 1,
                          //     textAlignVertical: TextAlignVertical.center,
                          //     textAlign: TextAlign.left,
                          //     decoration: InputDecoration(
                          //       contentPadding: EdgeInsets.only(left: defMargin),
                          //       hintText: 'Search food , accessories..',
                          //       // prefixIcon: Icon(Icons.search),
                          //       suffixIcon: Icon(
                          //         Icons.search,
                          //         color: subTextColor,
                          //       ),
                          //       hintStyle: TextStyle(
                          //         color: subTextColor,
                          //         fontFamily: fontFamily,
                          //         fontSize: getScreenPercentSize(context, 1.7),
                          //         fontWeight: FontWeight.w400,
                          //       ),
                          //       filled: true,
                          //       isDense: true,
                          //       fillColor: Colors.transparent,
                          //       disabledBorder: getOutLineBorder(radius),
                          //       enabledBorder: getOutLineBorder(radius),
                          //       focusedBorder: getOutLineBorder(radius),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: (defMargin / 2),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: defMargin),
                          //   child: getTextWithFontFamilyWidget(
                          //       'Category',
                          //       textColor,
                          //       getScreenPercentSize(context, 2),
                          //       FontWeight.w500,
                          //       TextAlign.start),
                          // ),
                          // SizedBox(height: (defMargin/2),),

                          // getCategoryList(),
                          // SizedBox(
                          //   height: getScreenPercentSize(context, 1),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.all(defMargin),
                          //   child: getTextWidget(
                          //       'Product',
                          //       textColor,
                          //       getScreenPercentSize(context, 1.8),
                          //       FontWeight.bold,
                          //       TextAlign.start),
                          // ),
                          sellerList(context)
                        ],
                      ),
                      // ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 70,
                          height: bottomHeight,
                          margin: EdgeInsets.only(
                              bottom: getScreenPercentSize(context, 3),
                              right: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                primaryColor,
                                const Color(0xFF8e82c7),
                                const Color(0xFF9e93d2),
                                const Color(0xFFaba1d7),
                              ],
                            ),
                            // border: Border.all(
                            //   color: Colors.white,
                            //   width: 1,
                            // ),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 9,
                                offset:
                                    const Offset(0, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.MYCART);

                                    // filterDialog(context);
                                  },
                                  child:  Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.shopping_basket,
                                            color: Colors.white,
                                          ),
                                          controller.orderItems.isNotEmpty
                                              ? Text("  ${controller.orderItems.length}")
                                              : const SizedBox(),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      // Expanded(
                      //   flex: 1,
                      //   child:
                      ListView(
                        children: [
                          SizedBox(
                            height: getScreenPercentSize(context, 1.5),
                          ),

                          Row(
                            children: [
                              SizedBox(
                                width: defMargin,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
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
                                        // prefixIcon: Icon(Icons.search),
                                        suffixIcon: Icon(
                                          Icons.search,
                                          color: subTextColor,
                                        ),
                                        hintStyle: TextStyle(
                                          color: subTextColor,
                                          fontFamily: fontFamily,
                                          fontSize: getScreenPercentSize(
                                              context, 1.7),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        filled: true,
                                        isDense: true,
                                        fillColor: Colors.transparent,
                                        disabledBorder:
                                        getOutLineBorder(radius),
                                        enabledBorder: getOutLineBorder(radius),
                                        focusedBorder: getOutLineBorder(radius),
                                      ),
                                      onChanged: (string) {
                                        controller
                                            .filterSearchResultsByType(string);
                                      },
                                    ),
                                  )),
                              SizedBox(width: defMargin),
                            ],
                          ),

                          // Container(
                          //   margin: EdgeInsets.all(defMargin),
                          //   decoration: getDecoration(radius),
                          //   child: TextField(
                          //     style: TextStyle(
                          //       fontFamily: fontFamily,
                          //       color: textColor,
                          //       fontWeight: FontWeight.w400,
                          //       fontSize: getScreenPercentSize(context, 1.7),
                          //     ),
                          //     onChanged: (string) {},
                          //     maxLines: 1,
                          //     textAlignVertical: TextAlignVertical.center,
                          //     textAlign: TextAlign.left,
                          //     decoration: InputDecoration(
                          //       contentPadding: EdgeInsets.only(left: defMargin),
                          //       hintText: 'Search food , accessories..',
                          //       // prefixIcon: Icon(Icons.search),
                          //       suffixIcon: Icon(
                          //         Icons.search,
                          //         color: subTextColor,
                          //       ),
                          //       hintStyle: TextStyle(
                          //         color: subTextColor,
                          //         fontFamily: fontFamily,
                          //         fontSize: getScreenPercentSize(context, 1.7),
                          //         fontWeight: FontWeight.w400,
                          //       ),
                          //       filled: true,
                          //       isDense: true,
                          //       fillColor: Colors.transparent,
                          //       disabledBorder: getOutLineBorder(radius),
                          //       enabledBorder: getOutLineBorder(radius),
                          //       focusedBorder: getOutLineBorder(radius),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: (defMargin / 2),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: defMargin),
                          //   child: getTextWithFontFamilyWidget(
                          //       'Category',
                          //       textColor,
                          //       getScreenPercentSize(context, 2),
                          //       FontWeight.w500,
                          //       TextAlign.start),
                          // ),
                          // SizedBox(height: (defMargin/2),),

                          // getCategoryList(),
                          // SizedBox(
                          //   height: getScreenPercentSize(context, 1),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.all(defMargin),
                          //   child: getTextWidget(
                          //       'Product',
                          //       textColor,
                          //       getScreenPercentSize(context, 1.8),
                          //       FontWeight.bold,
                          //       TextAlign.start),
                          // ),
                          sellerList(context)
                        ],
                      ),
                      // ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 70,
                          height: bottomHeight,
                          margin: EdgeInsets.only(
                              bottom: getScreenPercentSize(context, 3),
                              right: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                primaryColor,
                                const Color(0xFF8e82c7),
                                const Color(0xFF9e93d2),
                                const Color(0xFFaba1d7),
                              ],
                            ),
                            // border: Border.all(
                            //   color: Colors.white,
                            //   width: 1,
                            // ),
                            borderRadius: const BorderRadius.all( Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 9,
                                offset:
                                const Offset(0, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.MYCART);
                                    // filterDialog(context);
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
                                              ? Text("  ${controller.orderItems.length}")
                                              : const SizedBox(),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
              );
            }));

    // )
  }

  int selectedCategory = 0;

  sellerList(BuildContext context) {
    defMargin = getScreenPercentSize(context, 1.5);

    var height = getScreenPercentSize(context, 35);

    double width = getWidthPercentSize(context, 40);
    double imgHeight = getPercentSize(height, 45);
    double remainHeight = height - imgHeight;

    double radius = getPercentSize(height, 5);

    double crossAxisSpacing = 0;
    var screenWidth = MediaQuery.of(context).size.width;
    var crossAxisCount = 2;
    var width0 = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;

    var aspectRatio = width0 / height;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: (defMargin * 1.2)),
      scrollDirection: Axis.vertical,
      primary: false,
      crossAxisSpacing: (defMargin * 2),
      mainAxisSpacing: 0,
      childAspectRatio: aspectRatio,
      children: List.generate(controller.services.length, (index) {
        ServiceModel model = controller.services[index];

        return InkWell(
          child: Container(
            width: width,
            margin: EdgeInsets.only(top: defMargin, bottom: (defMargin)),
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.background,
              shadows: [
                BoxShadow(
                    color: subTextColor.withOpacity(0.1),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: const Offset(0, 1))
              ],
              shape: SmoothRectangleBorder(
                // side: BorderSide(color: iconColor, width: 0.1),
                borderRadius: SmoothBorderRadius(
                  cornerRadius: radius,
                  cornerSmoothing: 0.8,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: imgHeight,
                  // color: Colors.red,
                  margin: EdgeInsets.only(
                      top: getPercentSize(width, 7),
                      bottom: getPercentSize(width, 5)),
                  child: Stack(
                    children: [
                      Center(
                        child:
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(radius),
                            //
                            //   child:
                            Image.network(
                          networkPath + model.images![0],
                          height: getPercentSize(imgHeight, 75),
                          // fit: BoxFit.fill,
                          // ),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: Container(
                      //     margin: EdgeInsets.symmetric(
                      //       horizontal: getPercentSize(imgHeight, 9),
                      //       // vertical: getPercentSize(imgHeight, 6)
                      //     ),
                      //     height: getPercentSize(imgHeight, 18),
                      //     width: getPercentSize(imgHeight, 18),
                      //     // decoration: ShapeDecoration(
                      //     // color: backgroundColor,
                      //     // shape: SmoothRectangleBorder(
                      //     //   side: BorderSide(color: iconColor, width: 0.1),
                      //     //   borderRadius: SmoothBorderRadius(
                      //     //     cornerRadius: getPercentSize(imgHeight, 5),
                      //     //     cornerSmoothing: 0.8,
                      //     //   ),
                      //     // ),
                      //     // ),
                      //     child: Center(
                      //       child: Image.asset(assetsPath + "heart.png",
                      //           color: primaryColor,
                      //           height: getPercentSize(imgHeight, 20)),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: getPercentSize(width, 5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: getCustomTextWidget(
                                      "${model.price.toString()} AED",
                                      Theme.of(context).hintColor,
                                      getPercentSize(remainHeight, 11),
                                      FontWeight.bold,
                                      TextAlign.start,
                                      1)),
                              // Expanded(
                              //     flex: 1,
                              //     child:
                              // getCustomTextWidget(
                              //     "10 \$",
                              //     textColor,
                              //     getPercentSize(remainHeight, 8),
                              //     FontWeight.bold,
                              //     TextAlign.start,
                              //     1)
                              // ),
                            ],
                          ),
                          // SizedBox(
                          //   height: getPercentSize(remainHeight, 4),
                          // ),
                          // SizedBox(
                          //   height: getPercentSize(remainHeight, 5),
                          // ),
                          // Row(
                          //   children: [
                          //     Image.asset(
                          //       assetsPath + "star.png",
                          //       height: getPercentSize(remainHeight, 9),
                          //     ),
                          //     SizedBox(
                          //       width: getPercentSize(width, 2),
                          //     ),
                          // getTextWidget(
                          //     '4.5',
                          //     subTextColor,
                          //     getPercentSize(remainHeight, 8),
                          //     FontWeight.w400,
                          //     TextAlign.start),
                          // SizedBox(
                          //   width: getPercentSize(width, 4.5),
                          // ),
                          // Expanded(
                          //   child: getTextWidget(
                          //       '19 Reviews',
                          //       subTextColor,
                          //       getPercentSize(remainHeight, 8),
                          //       FontWeight.w400,
                          //       TextAlign.start),
                          // )
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: getPercentSize(remainHeight, 5),
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //
                          //   children: [
                          //     Text("one"),
                          //     Text("two")
                          //
                          //   ],
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Column(
                              //   children: [
                              // Expanded(
                              //     child:
                              getCustomTextWidget(
                                  model.enName.toString(),
                                  Colors.grey,
                                  getPercentSize(remainHeight, 8),
                                  FontWeight.bold,
                                  TextAlign.start,
                                  1)
                              // )
                              ,
                              // getCustomTextWidget(
                              //     "type : ",
                              //     textColor,
                              //     getPercentSize(remainHeight, 8),
                              //     FontWeight.bold,
                              //     TextAlign.start,
                              //     1)
                              //   ],
                              // ),
                              // SizedBox(
                              //   width: getPercentSize(width, 2),
                              // ),

                              // color: Colors.transparent,
                              // shadowColor: primaryColor.withOpacity(0.3),
                              // elevation: getPercentSize(height, 25),
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.all(Radius.circular(radius))),
                              // child: widget,

                              Material(
                                //Wrap with Material
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 0.0,

                                // color: primaryColor,
                                clipBehavior: Clip.antiAlias, // Add This
                                child: MaterialButton(
                                  minWidth: 50.0,
                                  height: 40,
                                  color: primaryColor,
                                  child: const Center(
                                      child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )),
                                  onPressed: () {
                                    controller.addToCart(
                                        model, controller.quantity.value);
                                  },
                                ),
                              ),
                              // MaterialButton(
                              //   onPressed: () {},
                              //   child: Container(
                              //     height: getPercentSize(remainHeight, 15),
                              //     width: getPercentSize(remainHeight, 15),
                              //     decoration: getDecorationWithColor(
                              //         getPercentSize(remainHeight, 3),
                              //         primaryColor),
                              //     child: Center(
                              //       child: Icon(Icons.add,
                              //           color: Colors.white,
                              //           size: getPercentSize(remainHeight, 15)),
                              //     ),
                              //   ),
                              // ),
                              // getAddMaterialWidget(
                              //     context,
                              //     Container(
                              //       height: getPercentSize(remainHeight, 15),
                              //       width: getPercentSize(remainHeight, 15),
                              //       decoration: getDecorationWithColor(
                              //           getPercentSize(remainHeight, 3),
                              //           primaryColor),
                              //       child: Center(
                              //         child: Icon(Icons.add,
                              //             color: Colors.white,
                              //             size:
                              //                 getPercentSize(remainHeight, 15)),
                              //       ),
                              //     ),
                              //     getPercentSize(remainHeight, 3),
                              //     getPercentSize(remainHeight, 16))
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          onTap: () {
            Get.toNamed(Routes.PRODUCTDETAILS, arguments: [
              {'model': model}
            ]);

            // Get.toNamed(Routes.ORDERDETAILS);
          },
        );
      }),
    );
    //
    // double margin = getScreenPercentSize(context, 1);
    // var height = getScreenPercentSize(context, 36);
    //
    // double width = getWidthPercentSize(context, 40);
    // double sideMargin = margin * 1.2;
    // double imgHeight = getPercentSize(height, 47);
    // double remainHeight = height - imgHeight;
    //
    // double radius = getPercentSize(height, 5);
    //
    // double _crossAxisSpacing = 0;
    // var _screenWidth = MediaQuery.of(context).size.width;
    // var _crossAxisCount = 2;
    // var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
    //     _crossAxisCount;
    //
    // var _aspectRatio = _width / height;
    //
    // return Container(
    //
    //   child: GridView.count(
    //     crossAxisCount: _crossAxisCount,
    //     shrinkWrap: true,
    //     padding: EdgeInsets.symmetric(horizontal: defMargin),
    //     scrollDirection: Axis.vertical,
    //     primary: false,
    //     crossAxisSpacing: (defMargin),
    //     mainAxisSpacing: 0,
    //     childAspectRatio: _aspectRatio,
    //     children: List.generate(productList.length, (index) {
    //       ProductModel model = productList[index];
    //
    //       return InkWell(
    //         child: getMaterialCell(context,widget: Container(
    //           width: width,
    //           margin: EdgeInsets.symmetric(vertical: (defMargin/2)),
    //
    //           decoration: ShapeDecoration(
    //             color: backgroundColor,
    //             // shadows: [
    //             //   BoxShadow(
    //             //       color: primaryColor.withOpacity(0.1),
    //             //       blurRadius: 3,
    //             //       spreadRadius: 3,
    //             //       offset: Offset(0, 1))
    //             // ],
    //             shape: SmoothRectangleBorder(
    //               // side: BorderSide(color: iconColor, width: 0.1),
    //               borderRadius: SmoothBorderRadius(
    //                 cornerRadius: radius,
    //                 cornerSmoothing: 0.8,
    //               ),
    //             ),
    //           ),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Container(
    //                 height: imgHeight,
    //                 margin: EdgeInsets.only(top: getPercentSize(width, 7),bottom: getPercentSize(width, 5)),
    //                 child: Stack(
    //                   children: [
    //                     Center(
    //                       child: ClipRRect(
    //                         borderRadius: BorderRadius.circular(radius),
    //
    //                         child: Image.asset(
    //                           assetsPath + model.image!,
    //                           width: width,
    //                           fit: BoxFit.fill,
    //                         ),
    //                       ),
    //                     ),
    //                     Align(
    //                       alignment: Alignment.topRight,
    //                       child: Container(
    //                         margin: EdgeInsets.symmetric(horizontal: getPercentSize(imgHeight, 14),vertical: getPercentSize(imgHeight, 6)),
    //                         height: getPercentSize(imgHeight, 18),
    //                         width: getPercentSize(imgHeight, 18),
    //                         decoration: ShapeDecoration(
    //                           color: backgroundColor,
    //                           shape: SmoothRectangleBorder(
    //                             side: BorderSide(color: iconColor, width: 0.1),
    //                             borderRadius: SmoothBorderRadius(
    //                               cornerRadius: getPercentSize(imgHeight, 5),
    //                               cornerSmoothing: 0.8,
    //                             ),
    //                           ),
    //                         ),
    //                         child: Center(
    //                           child: Image.asset(assetsPath + "heart.png",
    //                               color: primaryColor,
    //                               height: getPercentSize(imgHeight, 10)),
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               Expanded(
    //                   child: Container(
    //                     margin: EdgeInsets.symmetric(
    //                         horizontal: getPercentSize(width, 5)),
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Row(
    //                           children: [
    //                             Expanded(
    //                                 child: getTextWidget(
    //                                     model.name!,
    //                                     textColor,
    //                                     getPercentSize(remainHeight, 10),
    //                                     FontWeight.bold,
    //                                     TextAlign.start)),
    //                             getTextWithFontFamilyWidget(
    //                                 model.price!,
    //                                 primaryColor,
    //                                 getPercentSize(remainHeight, 10),
    //                                 FontWeight.w500,
    //                                 TextAlign.start)
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           height: getPercentSize(remainHeight, 4),
    //                         ),
    //                         Row(
    //                           children: [
    //                             Image.asset(
    //                               assetsPath + "location.png",
    //                               height: getPercentSize(remainHeight, 9),
    //                             ),
    //                             SizedBox(
    //                               width: getPercentSize(width, 2),
    //                             ),
    //                             Expanded(
    //                                 child: getTextWidget(
    //                                     model.address!,
    //                                     textColor,
    //                                     getPercentSize(remainHeight, 9),
    //                                     FontWeight.w400,
    //                                     TextAlign.start)),
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           height: getPercentSize(remainHeight, 6),
    //                         ),
    //                         Row(
    //                           children: [
    //                             Expanded(
    //                                 child: getTextWidget(
    //                                     model.desc!,
    //                                     subTextColor,
    //                                     getPercentSize(remainHeight, 8),
    //                                     FontWeight.w400,
    //                                     TextAlign.start)),
    //                             SizedBox(
    //                               width: getPercentSize(width, 2),
    //                             ),
    //
    //
    //
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   )),
    //             ],
    //           ),
    //         )),
    //         onTap: () {
    //           Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (context) => ProductDetailPage(model)));
    //         },
    //       );
    //     }),
    //   ),
    // );
  }

  getCategoryList(BuildContext context) {
    double height = getScreenPercentSize(context, 7);
    double width = getWidthPercentSize(context, 30);
    return Container(
        height: height,
        margin: EdgeInsets.symmetric(vertical: padding),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: dataList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Color color = "#F1DDD3".toColor();

              if (index % 3 == 0) {
                color = "#F7E1BD".toColor();
              } else if (index % 3 == 1) {
                color = "#DBF0E5".toColor();
              } else if (index % 3 == 2) {
                color = "#F1DDD3".toColor();
              }
              return InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: selectedCategory == index
                              ? primaryColor
                              : Colors.transparent,
                          width: selectedCategory == index ? 1 : 0),
                      borderRadius: BorderRadius.all(
                          Radius.circular(getPercentSize(height, 50)))),
                  margin: EdgeInsets.only(
                      left: index == 0 ? (defMargin) : (defMargin / 1.5)),
                  child: Container(
                    margin: const EdgeInsets.all(1),

                    width: width,

                    decoration: ShapeDecoration(
                      color: color,
                      shape: SmoothRectangleBorder(
                        // side: BorderSide(color: primaryColor,width: selectedCategory==index?1:0),

                        borderRadius: SmoothBorderRadius(
                          cornerRadius: getPercentSize(height, 50),
                          cornerSmoothing: 0.8,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: height,
                          width: height,
                          decoration: const BoxDecoration(
                            color: Colors.white54,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              assetsPath + dataList[index].image!,
                              height: getPercentSize(height, 60),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getPercentSize(width, 10),
                        ),
                        Expanded(
                            child: getCustomTextWidget(
                                dataList[index].name!,
                                Colors.black,
                                getPercentSize(width - height, 22),
                                FontWeight.w500,
                                TextAlign.start,
                                1))
                      ],
                    ),

                    // child: Container(
                    //   margin: EdgeInsets.only(left: defMargin),
                    //   child: Stack(
                    //     children: [
                    //       Container(
                    //         height: imageSize,
                    //         width: imageSize,
                    //         decoration: BoxDecoration(
                    //           color: cellColor,
                    //           shape: BoxShape.circle,
                    //         ),
                    //         child: Center(
                    //           child: Image.asset(
                    //             assetsPath + dataList[index].image!,
                    //             height: getPercentSize(imageSize, 90),
                    //           ),
                    //         ),
                    //       ),
                    //       Visibility(
                    //         visible: (selectedCategory == index),
                    //         child: Container(
                    //           height: imageSize,
                    //           width: imageSize,
                    //           decoration: BoxDecoration(
                    //             color: primaryColor.withOpacity(0.4),
                    //             shape: BoxShape.circle,
                    //           ),
                    //           child: Center(
                    //             child: getCustomTextWidget(
                    //                 dataList[index].name!,
                    //                 Colors.white,
                    //                 getPercentSize(imageSize, 20),
                    //                 FontWeight.w500,
                    //                 TextAlign.center,
                    //                 1),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ),
                ),
                onTap: () {
                  // setState(() {
                  selectedCategory = index;
                  // });
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => SubCategoriesPage()));
                },
              );
            }));
  }

  // getCategoryList() {
  //   double height = getScreenPercentSize(context, 6);
  //   double width = getWidthPercentSize(context, 20);
  //   double radius = getPercentSize(height, 20);
  //   return Container(
  //       height: height,
  //       child: ListView.builder(
  //           padding: EdgeInsets.zero,
  //           shrinkWrap: true,
  //           itemCount: dataList.length,
  //           scrollDirection: Axis.horizontal,
  //           itemBuilder: (context, index) {
  //             double imageSize = getPercentSize(height, 50);
  //             double remainSize = height - getPercentSize(height, 50);
  //
  //             bool isSelected = (selectedCategory == index);
  //
  //             return InkWell(
  //               child: Container(
  //                 decoration: ShapeDecoration(
  //                   color: isSelected?primaryColor:alphaColor,
  //                   shadows: [
  //                     BoxShadow(
  //                         color: isSelected?subTextColor.withOpacity(0.1):Colors.transparent,
  //                         blurRadius: 2,
  //                         spreadRadius: 1,
  //                         offset: Offset(0, 1))
  //                   ],
  //                   shape: SmoothRectangleBorder(
  //                     side: BorderSide(color: iconColor, width: 0.1),
  //                     borderRadius: SmoothBorderRadius(
  //                       cornerRadius: radius,
  //                       cornerSmoothing: 0.8,
  //                     ),
  //                   ),
  //                 ),
  //                 padding: EdgeInsets.all(getPercentSize(height, 5)),
  //                 margin: EdgeInsets.only(
  //                     left: defMargin,
  //                     right: getWidthPercentSize(context, 2),
  //                     bottom: getScreenPercentSize(context, 0.5),
  //                     top: getScreenPercentSize(context, 0.5)),
  //                 width: width,
  //                 child:
  //                 Center(
  //                   child: getCustomTextWidget(
  //                               dataList[index].name!,
  //                               isSelected ? Colors.white : subTextColor,
  //                               getPercentSize(height, 30),
  //                               FontWeight.w500,
  //                               TextAlign.center,
  //                               1),
  //                 )
  //
  //                 // child: Column(
  //                 //   children: [
  //                 //     Container(
  //                 //       height: imageSize,
  //                 //       width: double.infinity,
  //                 //       decoration: BoxDecoration(
  //                 //         color: isSelected ? Colors.white : Colors.transparent,
  //                 //         borderRadius:
  //                 //             BorderRadius.circular(getPercentSize(radius, 80)),
  //                 //         // shape: BoxShape.circle,
  //                 //       ),
  //                 //       child: Center(
  //                 //         child: Image.asset(
  //                 //           assetsPath + dataList[index].image!,
  //                 //           height: getPercentSize(imageSize, 90),
  //                 //         ),
  //                 //       ),
  //                 //     ),
  //                 //
  //                 //     Expanded(
  //                 //       child: Center(
  //                 //         child: getCustomTextWidget(
  //                 //             dataList[index].name!,
  //                 //             isSelected ? Colors.white : textColor,
  //                 //             getPercentSize(remainSize, 25),
  //                 //             FontWeight.w500,
  //                 //             TextAlign.center,
  //                 //             1),
  //                 //       ),
  //                 //     )
  //                 //     // Visibility(
  //                 //     //   visible: (selectedCategory == index),
  //                 //     //   child: Container(
  //                 //     //     height: imageSize,
  //                 //     //     width: imageSize,
  //                 //     //     decoration: BoxDecoration(
  //                 //     //       color: primaryColor.withOpacity(0.4),
  //                 //     //       shape: BoxShape.circle,
  //                 //     //     ),
  //                 //     //     child: Center(
  //                 //     //       child: getCustomTextWidget(
  //                 //     //           dataList[index].name!,
  //                 //     //           Colors.white,
  //                 //     //           getPercentSize(imageSize, 20),
  //                 //     //           FontWeight.w500,
  //                 //     //           TextAlign.center,
  //                 //     //           1),
  //                 //     //     ),
  //                 //     //   ),
  //                 //     // ),
  //                 //   ],
  //                 // ),
  //               ),
  //               onTap: () {
  //                 setState(() {
  //                   selectedCategory= index;
  //                 });
  //                 // Navigator.push(
  //                 //     context,
  //                 //     MaterialPageRoute(
  //                 //         builder: (context) => SubCategoriesPage()));
  //               },
  //             );
  //           }));
  // }

  List<String> list = [
    "Latest Products",
    "Best Selling",
    "Lowest Price",
    "Highest Price"
  ];

  int position = 0;

  filterDialog(BuildContext context) {
    double height = getScreenPercentSize(context, 60);
    double radius = getScreenPercentSize(context, 3);
    double subHeight = getPercentSize(height, 12);
    double margin = getScreenPercentSize(context, 2);

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius))),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.6,
            child: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  // height: height,
                  // padding: EdgeInsets.symmetric(horizontal: getScreenPercentSize(context, 2)),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: getScreenPercentSize(context, 2),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: Row(
                          children: [
                            // Expanded(
                            //   child: getTextWithFontFamilyWidget(
                            //       'Sort By',
                            //       textColor,
                            //       getPercentSize(height, 5),
                            //       FontWeight.w500,
                            //       TextAlign.start),
                            //   flex: 1,
                            // ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  size: getPercentSize(height, 5),
                                  color: textColor,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getPercentSize(height, 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: getTextWidget(
                            'Arrange based on the following types',
                            subTextColor,
                            getPercentSize(height, 3),
                            FontWeight.w400,
                            TextAlign.start),
                      ),
                      SizedBox(
                        height: getPercentSize(height, 2),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                position = index;
                                // Navigator.of(context).pop();
                                // filterDialog1();
                              });
                            },
                            child: Container(
                              height: subHeight,
                              margin: EdgeInsets.symmetric(
                                  vertical: getPercentSize(height, 1.5),
                                  horizontal: margin),
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidthPercentSize(context, 3)),
                              decoration: ShapeDecoration(
                                color: cellColor,
                                shape: SmoothRectangleBorder(
                                  side: BorderSide(
                                      color: primaryColor.withOpacity(0.5),
                                      width: 0.3),
                                  borderRadius: SmoothBorderRadius(
                                    cornerRadius: getPercentSize(subHeight, 25),
                                    cornerSmoothing: 0.8,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: getTextWidget(
                                        list[index],
                                        textColor,
                                        getPercentSize(subHeight, 27),
                                        FontWeight.w400,
                                        TextAlign.start),
                                  ),
                                  Visibility(
                                    visible: (position == index),
                                    child: Icon(
                                      Icons.check_circle,
                                      size: getPercentSize(subHeight, 35),
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: getPercentSize(height, 6),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: margin),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(),));

                                  Navigator.of(context).pop();
                                },
                                child: getMaterialCell(context,
                                    widget: Container(
                                      margin: EdgeInsets.only(
                                          right:
                                              getWidthPercentSize(context, 2)),
                                      height: getScreenPercentSize(context, 7),
                                      decoration: ShapeDecoration(
                                        color: alphaColor,
                                        // shadows: [
                                        //   BoxShadow(
                                        //       color: textColor.withOpacity(0.1),
                                        //       blurRadius: 2,
                                        //       spreadRadius: 1,
                                        //       offset: Offset(0, 4))
                                        // ],
                                        shape: SmoothRectangleBorder(
                                          side: BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius: SmoothBorderRadius(
                                            cornerRadius: getScreenPercentSize(
                                                context, 1.8),
                                            cornerSmoothing: 0.8,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: getTextWidget(
                                            'Reset',
                                            textColor,
                                            getScreenPercentSize(context, 2),
                                            FontWeight.bold,
                                            TextAlign.center),
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  // if(_position==3){
                                  //   PrefData.setIsIntro(false);
                                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage(),));
                                  // }else {
                                  //   if (_position < (introModelList.length - 1)) {
                                  //     setState(() {
                                  //       _position = _position + 1;
                                  //       controller.jumpToPage(_position);
                                  //     });
                                  //   } else {
                                  //     skip();
                                  //   }
                                  // }
                                },
                                child: getMaterialCell(context,
                                    widget: Container(
                                      margin: EdgeInsets.only(
                                          left:
                                              getWidthPercentSize(context, 2)),
                                      height: getScreenPercentSize(context, 7),
                                      decoration: ShapeDecoration(
                                        color: primaryColor,
                                        // shadows: [BoxShadow(
                                        //     color: textColor.withOpacity(0.1),
                                        //     blurRadius: 2,
                                        //     spreadRadius: 1,
                                        //     offset: Offset(0, 4))],
                                        shape: SmoothRectangleBorder(
                                          borderRadius: SmoothBorderRadius(
                                            cornerRadius: getScreenPercentSize(
                                                context, 1.8),
                                            cornerSmoothing: 0.8,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: getTextWidget(
                                            'Apply',
                                            Colors.white,
                                            getScreenPercentSize(context, 2),
                                            FontWeight.bold,
                                            TextAlign.center),
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  List<String> materialList = [
    'King',
    'Pedigree',
    'Baker',
    'Whiskies',
    'Chomp',
    'Pet Toys',
    'Meow',
    'Bash',
    'Domino'
  ];

  int materialPosition = 0;

  RangeValues _currentRangeValues = const RangeValues(100, 1000);

  filterDialog1(BuildContext context) {
    double height = getScreenPercentSize(context, 45);
    double radius = getScreenPercentSize(context, 3);
    double margin = getScreenPercentSize(context, 2);

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius))),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return FractionallySizedBox(
                heightFactor: 0.6,
                child: Container(
                  // padding: EdgeInsets.symmetric(ver: getScreenPercentSize(context, 2)),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: margin,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: Row(
                          children: [
                            // Expanded(
                            //   child: getTextWithFontFamilyWidget(
                            //       'Filter',
                            //       textColor,
                            //       getPercentSize(height, 5),
                            //       FontWeight.w500,
                            //       TextAlign.start),
                            //   flex: 1,
                            // ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  size: getPercentSize(height, 6),
                                  color: textColor,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getPercentSize(height, 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: getTextWidget(
                            'Filter products with more specific types',
                            subTextColor,
                            getPercentSize(height, 3.5),
                            FontWeight.w400,
                            TextAlign.start),
                      ),
                      SizedBox(
                        height: getPercentSize(height, 4),
                      ),
                      // Padding(
                      //   padding:  EdgeInsets.symmetric(horizontal: margin),
                      //   child: getTextWithFontFamilyWidget(
                      //       'Price',
                      //       textColor,
                      //       getPercentSize(height, 4),
                      //       FontWeight.w500,
                      //       TextAlign.start),
                      // ),
                      SizedBox(
                        height: getPercentSize(height, 2),
                      ),
                      RangeSlider(
                        values: _currentRangeValues,
                        min: 10,
                        max: 1000,
                        activeColor: primaryColor,
                        inactiveColor: primaryColor.withOpacity(0.5),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                          });
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: margin),
                        child: Row(
                          children: [
                            Expanded(
                              child: getTextWidget(
                                  "\$50",
                                  primaryColor,
                                  getScreenPercentSize(context, 2),
                                  FontWeight.w600,
                                  TextAlign.start),
                            ),

                            getTextWidget(
                                "\$250",
                                primaryColor,
                                getScreenPercentSize(context, 2),
                                FontWeight.w600,
                                TextAlign.start),

                            // getTextWidget(
                            //     '\$1000',
                            //     disableIconColor,
                            //     TextAlign.start,
                            //     FontWeight.w600,
                            //     getScreenPercentSize(context, 2))
                          ],
                        ),
                      ),

                      SizedBox(
                        height: getScreenPercentSize(context, 3),
                      ),

                      // Padding(
                      //   padding:  EdgeInsets.symmetric(horizontal: margin),
                      //   child: getTextWithFontFamilyWidget(
                      //       'Brand',
                      //       textColor,
                      //       getPercentSize(height, 4),
                      //       FontWeight.w500,
                      //       TextAlign.start),
                      // ),
                      SizedBox(
                        height: getPercentSize(height, 2),
                      ),

                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: margin),
                          child: getGrid(context)),
                      SizedBox(
                        height: getPercentSize(height, 10),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: margin),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(),));

                                  Navigator.of(context).pop();
                                },
                                child: getMaterialCell(context,
                                    widget: Container(
                                      margin: EdgeInsets.only(
                                          right:
                                              getWidthPercentSize(context, 3)),
                                      height: getScreenPercentSize(context, 7),
                                      decoration: ShapeDecoration(
                                        color: alphaColor,
                                        // shadows: [
                                        //   BoxShadow(
                                        //       color: textColor.withOpacity(0.1),
                                        //       blurRadius: 2,
                                        //       spreadRadius: 1,
                                        //       offset: Offset(0, 4))
                                        // ],
                                        shape: SmoothRectangleBorder(
                                          side: BorderSide(
                                              color: primaryColor, width: 2),
                                          borderRadius: SmoothBorderRadius(
                                            cornerRadius: getScreenPercentSize(
                                                context, 1.8),
                                            cornerSmoothing: 0.8,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: getTextWidget(
                                            'Reset',
                                            textColor,
                                            getScreenPercentSize(context, 2),
                                            FontWeight.bold,
                                            TextAlign.center),
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  // if(_position==3){
                                  //   PrefData.setIsIntro(false);
                                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage(),));
                                  // }else {
                                  //   if (_position < (introModelList.length - 1)) {
                                  //     setState(() {
                                  //       _position = _position + 1;
                                  //       controller.jumpToPage(_position);
                                  //     });
                                  //   } else {
                                  //     skip();
                                  //   }
                                  // }
                                },
                                child: getMaterialCell(context,
                                    widget: Container(
                                      margin: EdgeInsets.only(
                                          left:
                                              getWidthPercentSize(context, 3)),
                                      height: getScreenPercentSize(context, 7),
                                      decoration: ShapeDecoration(
                                        color: primaryColor,
                                        // shadows: [BoxShadow(
                                        //     color: textColor.withOpacity(0.1),
                                        //     blurRadius: 2,
                                        //     spreadRadius: 1,
                                        //     offset: Offset(0, 4))],
                                        shape: SmoothRectangleBorder(
                                          borderRadius: SmoothBorderRadius(
                                            cornerRadius: getScreenPercentSize(
                                                context, 1.8),
                                            cornerSmoothing: 0.8,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: getTextWidget(
                                            'Apply',
                                            Colors.white,
                                            getScreenPercentSize(context, 2),
                                            FontWeight.bold,
                                            TextAlign.center),
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: getPercentSize(height, 10),
                      ),

                      // FlutterSlider(
                      //   handlerHeight: getScreenPercentSize(context, 1),
                      //   values: [_lowerValue, _upperValue],
                      //   rangeSlider: true,
                      //   max: 300,
                      //   min: 0,
                      //   step: FlutterSliderStep(step: 1),
                      //   jump: false,
                      //   trackBar: FlutterSliderTrackBar(
                      //       activeTrackBarHeight:
                      //           getScreenPercentSize(context, 1.2),
                      //       activeTrackBar: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(
                      //               getScreenPercentSize(context, 2)),
                      //           color: primaryColor),
                      //       inactiveTrackBarHeight:
                      //           getScreenPercentSize(context, 1.2),
                      //       inactiveTrackBar: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(
                      //               getScreenPercentSize(context, 2)),
                      //           color: subTextColor.withOpacity(0.5))),
                      //   tooltip: FlutterSliderTooltip(
                      //       disableAnimation: true,
                      //       alwaysShowTooltip: true,
                      //       boxStyle: FlutterSliderTooltipBox(
                      //           decoration:
                      //               BoxDecoration(color: Colors.transparent)),
                      //       textStyle: TextStyle(
                      //           fontFamily: fontFamily,
                      //           fontWeight: FontWeight.w800,
                      //           fontSize: 0,
                      //           color: Colors.transparent),
                      //       format: (String value) {
                      //         return '\$' + value;
                      //       }),
                      //   handler: FlutterSliderHandler(
                      //     decoration: BoxDecoration(),
                      //     child: Container(),
                      //   ),
                      //   rightHandler: FlutterSliderHandler(
                      //     decoration: BoxDecoration(),
                      //     child: Container(
                      //       height: 78,
                      //       width: 78,
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: Colors.red,
                      //       ),
                      //       padding:
                      //           EdgeInsets.all(getScreenPercentSize(context, 2)),
                      //     ),
                      //   ),
                      //   disabled: false,
                      //   onDragging: (handlerIndex, lowerValue, upperValue) {
                      //     _lowerValue = lowerValue;
                      //     _upperValue = upperValue;
                      //     setState(() {});
                      //   },
                      // ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  getGrid(BuildContext context) {
    var crossAxisSpacing = 1;
    var screenWidth = MediaQuery.of(context).size.width;
    var crossAxisCount = 3;
    var width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    var cellHeight = getScreenPercentSize(context, 5.5);

    var margin = getWidthPercentSize(context, 3);

    var aspectRatio = width / cellHeight;

    return Container(
      margin: const EdgeInsets.only(right: 1),
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        shrinkWrap: true,
        childAspectRatio: aspectRatio,
        mainAxisSpacing: margin,
        crossAxisSpacing: (margin),
        // childAspectRatio: 0.64,
        primary: false,
        children: List.generate(materialList.length, (index) {
          return InkWell(
            onTap: () {
              // setState(() {
              materialPosition = index;
              // });
            },
            child: SizedBox(
              width: cellHeight,
              child: Container(
                margin: EdgeInsets.only(
                    top: getPercentSize(cellHeight, 3), bottom: 1),
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: getWidthPercentSize(context, 3)),
                decoration: ShapeDecoration(
                  color:
                      (materialPosition == index) ? primaryColor : alphaColor,
                  // shadows: [
                  //   BoxShadow(
                  //       color: primaryColor.withOpacity(0.3),
                  //       blurRadius: 2,
                  //       spreadRadius: 1,
                  //       offset: Offset(0, 1))
                  // ],
                  shape: SmoothRectangleBorder(
                    side: BorderSide(color: iconColor, width: 0.3),
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: getPercentSize(cellHeight, 15),
                      cornerSmoothing: 0.8,
                    ),
                  ),
                ),
                // decoration: BoxDecoration(
                //     color: (materialPosition == index)
                //         ? primaryColor
                //         : alphaColor,
                //
                //
                //     borderRadius: BorderRadius.all(
                //         Radius.circular(getPercentSize(cellHeight, 15)))),
                child: Center(
                  child: getTextWidget(
                    materialList[index],
                    (index == materialPosition) ? Colors.white : textColor,
                    getPercentSize(cellHeight, 30),
                    FontWeight.w500,
                    TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
