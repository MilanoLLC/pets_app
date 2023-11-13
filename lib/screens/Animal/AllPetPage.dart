// import 'package:figma_squircle/figma_squircle.dart';
// import 'package:flutter/material.dart';
// import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
// import 'package:pets_app/controllers/home_controller.dart';
// import 'package:pets_app/model/AnimalModel.dart';
// import 'package:pets_app/screens/Animal/PetDetailPage.dart';
// import 'package:pets_app/utils/constant.dart';
// import 'package:pets_app/utils/CustomWidget.dart';
// import 'package:pets_app/utils/DataFile.dart';
// import 'package:pets_app/utils/SizeConfig.dart';
// import 'package:get/get.dart';
//
// import '../MyPetPage.dart';
// // import 'PetDetailPage.dart';
//
// class AllPetPage extends StatelessWidget {
//    AllPetPage({this.function,Key? key}) : super(key: key);
//    final controller =Get.put(HomeController());
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container();
// //   }
// // }
// //
// // class AllPetPage extends StatefulWidget {
//   final Function? function;
// //
// //   AllPetPage({this.function});
// //
// //   @override
// //   _AllPetPage createState() {
// //     return _AllPetPage();
// //   }
// // }
//
// // class _AllPetPage extends State<AllPetPage> {
// //   List<AnimalModel> productList = DataFile.getAdoptModel();
//
//   // _AllPetPage();
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   // }
//
//   Future<bool> _requestPop() {
//     if (function != null) {
//       function!();
//     } else {
//       Get.back();
//     }
//
//     return new Future.value(true);
//   }
//
//   void doNothing(BuildContext context) {}
//
//   double defMargin = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     double height = getScreenPercentSize(context, 3);
//
//     defMargin = getHorizontalSpace(context);
//     return WillPopScope(
//         onWillPop: _requestPop,
//         child: Scaffold(
//           backgroundColor: backgroundColor,
//           appBar: AppBar(
//             backgroundColor: backgroundColor,
//             elevation: 0,
//             toolbarHeight: 0,
//           ),
//           body: Container(
//             child: Column(
//               children: [
//                 getAppBar(context, "All pets", isBack: true, function: () {
//                   _requestPop();
//                 }),
//                 SizedBox(
//                   height: getScreenPercentSize(context, 1.5),
//                 ),
//                 Expanded(child: sellerList(context))
//               ],
//             ),
//           ),
//         ));
//   }
//
//   sellerList(BuildContext context) {
//
//     var height = getScreenPercentSize(context, 40);
//
//     double width = getWidthPercentSize(context, 40);
//     double imgHeight = getPercentSize(height, 50);
//     double remainHeight = height - imgHeight;
//
//     double radius = getPercentSize(height, 5);
//
//     double _crossAxisSpacing = 0;
//     var _screenWidth = MediaQuery.of(context).size.width;
//     var _crossAxisCount = 2;
//     var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
//         _crossAxisCount;
//
//     var _aspectRatio = _width / height;
//    return  Obx(() =>  LazyLoadScrollView(
//         onEndOfPage: controller.loadNextPage,
//         isLoading: controller.lastPage,
//         child: GridView.count(
//           crossAxisCount: _crossAxisCount,
//           shrinkWrap: true,
//           padding: EdgeInsets.symmetric(horizontal: (defMargin)),
//           scrollDirection: Axis.vertical,
//           primary: false,
//           crossAxisSpacing: (defMargin),
//           mainAxisSpacing: 0,
//           childAspectRatio: _aspectRatio,
//           children: List.generate(controller.products.length, (index) {
//             AnimalModel model = controller.products[index];
//
//             return InkWell(
//               child: getMaterialCell(context,widget: Container(
//                 width: width,
//                 margin: EdgeInsets.symmetric(vertical: (defMargin/1.5)),
//                 decoration: ShapeDecoration(
//                   color: backgroundColor,
//
//
//                   shape: SmoothRectangleBorder(
//
//                     borderRadius: SmoothBorderRadius(
//                       cornerRadius: radius,
//                       cornerSmoothing: 0.8,
//                     ),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: imgHeight,
//                       margin: EdgeInsets.only(top: getPercentSize(width, 6)),
//                       child: Stack(
//                         children: [
//                           Align(
//                             alignment: Alignment.topCenter,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(radius),
//                               child: model.images==null?
//                               Image.asset( 'assets/images/no image.jpg')
//                                   :FadeInImage.assetNetwork(
//                                 placeholder: 'assets/images/no image.jpg',
//                                 image:
//                                 networkPath + model.images!,
//                               ),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: Container(
//                               margin: EdgeInsets.symmetric(horizontal: getPercentSize(imgHeight, 14),vertical: getPercentSize(imgHeight, 6)),
//                               height: getPercentSize(imgHeight, 18),
//                               width: getPercentSize(imgHeight, 18),
//                               decoration: ShapeDecoration(
//                                 color: backgroundColor,
//                                 shape: SmoothRectangleBorder(
//                                   side: BorderSide(color: iconColor, width: 0.1),
//                                   borderRadius: SmoothBorderRadius(
//                                     cornerRadius: getPercentSize(imgHeight, 5),
//                                     cornerSmoothing: 0.8,
//                                   ),
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Image.asset(assetsPath + "heart.png",
//                                     color: primaryColor,
//                                     height: getPercentSize(imgHeight, 10)),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                         child: Container(
//                           margin: EdgeInsets.only(left: getPercentSize(width, 5),bottom: getPercentSize(width, 6),right:getPercentSize(width, 5) ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Expanded(
//                                       child: getCustomTextWidget(
//                                           model.animalName!,
//                                           textColor,
//                                           getPercentSize(remainHeight, 11),
//                                           FontWeight.w900,
//                                           TextAlign.start,1)),
//
//                                   // getCustomTextWidget(
//                                   //     model.price!,
//                                   //     primaryColor,
//                                   //     getPercentSize(remainHeight, 10),
//                                   //     FontWeight.bold,
//                                   //     TextAlign.start,1)
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: getPercentSize(remainHeight, 6),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     assetsPath + "location.png",
//                                     height: getPercentSize(remainHeight, 10),
//                                   ),
//                                   SizedBox(
//                                     width: getPercentSize(width, 2),
//                                   ),
//                                   getCustomTextWidget(
//                                       model.location!,
//                                       textColor,
//                                       getPercentSize(remainHeight, 9.4),
//                                       FontWeight.w500,
//                                       TextAlign.start,1),
//                                   Expanded(
//                                       child: getCustomTextWidget(
//                                           " (3 km)",
//                                           textColor,
//                                           getPercentSize(remainHeight, 8.2),
//                                           FontWeight.w500,
//                                           TextAlign.start,1)),
//                                 ],
//                               ),
//                               // SizedBox(
//                               //   height: getPercentSize(remainHeight, 6),
//                               // ),
//                               Expanded(child: Container(),flex: 1,),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                       child: getTextWidget(
//                                           model.description!,
//                                           subTextColor,
//                                           getPercentSize(remainHeight, 9),
//                                           FontWeight.w500,
//                                           TextAlign.start)),
//                                   SizedBox(
//                                     width: getPercentSize(width, 2),
//                                   ),
//                                   // getMaterialWidget(context, Container(
//                                   //   height: getPercentSize(remainHeight, 14),
//                                   //   width: getPercentSize(remainHeight, 14),
//                                   //   decoration: getDecorationWithColor(
//                                   //       getPercentSize(remainHeight, 3), primaryColor),
//                                   //   child: Center(
//                                   //     child: Icon(Icons.add,
//                                   //         color: Colors.white,
//                                   //         size: getPercentSize(remainHeight, 9)),
//                                   //   ),
//                                   // ), getPercentSize(remainHeight, 3), getPercentSize(remainHeight, 14))
//                                 ],
//                               ),
//                             ],
//                           ),
//                         )),
//                   ],
//                 ),
//               )),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => PetDetailPage(model)));
//               },
//             );
//           }),
//         )
//       ),
//    );
//   }
// }
