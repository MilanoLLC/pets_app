// import 'package:figma_squircle/figma_squircle.dart';
// import 'package:flutter/material.dart';
// import 'package:pets_app/screens/AdoptionFormPage.dart';
// import 'package:pets_app/model/AnimalModel.dart';
// import 'package:pets_app/utils/constant.dart';
// import 'package:pets_app/utils/CustomWidget.dart';
// import 'package:pets_app/utils/DataFile.dart';
// import 'package:pets_app/utils/SizeConfig.dart';
// import 'package:get/get.dart';
//
// // import 'LocationTrackMap.dart';
// class PetDetailPage extends StatelessWidget {
//  AnimalModel model;
//
//   PetDetailPage(this.model,{Key? key}) : super(key: key);
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container();
// //   }
// // }
// //
// // class PetDetailPage extends StatefulWidget {
// //   final ProductModel model;
// //
// //   PetDetailPage(this.model);
// //
// //   @override
// //   _PetDetailPage createState() {
// //     return _PetDetailPage();
// //   }
// // }
// //
// // class _PetDetailPage extends State<PetDetailPage> {
// //   // List<ProductModel> productList = DataFile.getProductModel();
// //
// //   _PetDetailPage();
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   // }
//
//   // Future<bool> _requestPop() {
//   //   Navigator.of(context).pop();
//   //   return new Future.value(true);
//   // }
//
//   void doNothing(BuildContext context) {}
//
//   double defMargin = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     defMargin= getHorizontalSpace(context);
//
//     double imgHeight = getWidthPercentSize(context, 75);
//     double margin = getWidthPercentSize(context, 3);
//
//     double height = getScreenPercentSize(context, 7);
//
//     return WillPopScope(
//         onWillPop: () async {
//           Get.back();
//           return true;
//         },
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
//                 getAppBar(context,model.animalName!, isBack: true,
//                     function: () {
//                   Get.back();
//                   // _requestPop();
//                 },
//                     widget: InkWell(
//                         onTap: () {},
//                         child: Image.asset(
//                           "${assetsPath}heart.png",
//                           height: getScreenPercentSize(context, 2.5),
//                           color: textColor,
//                         ))),
//                 SizedBox(
//                   height: getScreenPercentSize(context, 1.5),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: ListView(
//                     padding: EdgeInsets.symmetric(horizontal: defMargin),
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(getPercentSize(imgHeight, 4)),
//                         child: model.images![0]==null?
//                         Image.asset( 'assets/images/no image.jpg')
//                             :FadeInImage.assetNetwork(
//                           placeholder: 'assets/images/no image.jpg',
//                           image:
//                           networkPath + model.images![0],
//                         ),
//                       ),
//                       // SizedBox(height: getScreenPercentSize(context, 1)),
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: margin),
//                         child: Row(
//                           children: [
//                             Expanded(
//                                 child: getTextWithFontFamilyWidget(
//                                     model.animalName!,
//                                     textColor,
//                                     getScreenPercentSize(context, 3),
//                                     FontWeight.w500,
//                                     TextAlign.start)),
//                             // getTextWithFontFamilyWidget(
//                             //     model.price!,
//                             //     primaryColor,
//                             //     getScreenPercentSize(context, 3),
//                             //     FontWeight.w500,
//                             //     TextAlign.start)
//                           ],
//                         ),
//                       ),
//                       InkWell(
//                         onTap: (){
//                           // Navigator.push(context,MaterialPageRoute(builder: (context) => LocationTrackMap(widget.model),));
//                         },
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               "${assetsPath}location.png",
//                               height: getScreenPercentSize(context, 2.2),
//                             ),
//                             SizedBox(
//                               width: getWidthPercentSize(context, 2),
//                             ),
//                             Expanded(
//                                 child: getTextWidget(
//                                     model.location!,
//                                     textColor,
//                                     getScreenPercentSize(context, 2),
//                                     FontWeight.w400,
//                                     TextAlign.start)),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: getScreenPercentSize(context, 2),
//                       ),
//                       Row(
//                         children: [
//                           getCell(context,"Age", model.age!+model.agePrefix!),
//                           SizedBox(
//                             width: (margin * 1.5),
//                           ),
//                           getCell(context,'Gender', model.gender??""),
//                           SizedBox(
//                             width: (margin * 1.5),
//                           ),
//                           getCell(context,'Weight', model.weight.toString()),
//                         ],
//                       ),
//                       Container(
//                         margin:
//                             EdgeInsets.only(top: (margin * 2.5), bottom: margin),
//                         child: getTextWithFontFamilyWidget(
//                             'Description',
//                             textColor,
//                             getScreenPercentSize(context, 2),
//                             FontWeight.w500,
//                             TextAlign.start),
//                       ),
//                       getCustomTextWidget(
//                           model.description!,
//                           textColor,
//                           getScreenPercentSize(context, 1.9),
//                           FontWeight.w400,
//                           TextAlign.left,
//                           3),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: margin),
//                   child: Row(
//                     children: [
//                       // Container(
//                       //
//                       //
//                       //     width: height,
//                       //     height: height,
//                       //     margin: EdgeInsets.only(left: defMargin,bottom:getHorizontalSpace(context) ,top:getScreenPercentSize(context, 1.2)),
//                       //     decoration: ShapeDecoration(
//                       //       color: backgroundColor,
//                       //       shadows: [
//                       //         BoxShadow(
//                       //             color: primaryColor.withOpacity(0.1),
//                       //             blurRadius: 5,
//                       //             spreadRadius: 5,
//                       //             offset: Offset(0, 5))
//                       //       ],
//                       //       shape: SmoothRectangleBorder(
//                       //         side: BorderSide(color: primaryColor, width: 1.5),
//                       //         borderRadius: SmoothBorderRadius(
//                       //           cornerRadius: getPercentSize(height, 25),
//                       //           cornerSmoothing: 0.8,
//                       //         ),
//                       //       ),
//                       //     ),
//                       //     child: Center(
//                       //       child: Image.asset(
//                       //         assetsPath + "call.png",
//                       //         color: primaryColor,
//                       //         height: getPercentSize(height, 45),
//                       //       ),
//                       //     )),
//                       // SizedBox(width: margin,),
//                       Expanded(
//                         child: getButtonWidget(context, "Adopt Now",primaryColor,(){
//
//                           // Navigator.push(context, MaterialPageRoute(builder: (context) => AdoptionFormPage(widget.model),));
//
//                         }),
//                         flex: 1,
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
//
//   getCell(BuildContext context, String s, String s1) {
//     return Expanded(
//       child: getMaterialCell(context,widget: Container(
//         padding:
//         EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 2)),
//         decoration: getDecorationWithColor(getScreenPercentSize(context, 1.3),backgroundColor),
//         child: Column(
//           children: [
//             getTextWidget(s, primaryColor, getScreenPercentSize(context, 1.8),
//                 FontWeight.w500, TextAlign.start),
//             SizedBox(
//               height: getScreenPercentSize(context, 1),
//             ),
//             getTextWidget(s1, textColor, getScreenPercentSize(context, 2),
//                 FontWeight.w400, TextAlign.start),
//           ],
//         ),
//       )),
//       flex: 1,
//     );
//   }
//
// }
