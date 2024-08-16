// // ignore_for_file: must_be_immutable
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:im_stepper/stepper.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:pets_app/controllers/product_controller.dart';
// import 'package:pets_app/helpers/constant.dart';
// import 'package:pets_app/widgets/CustomWidget.dart';
// import 'package:pets_app/widgets/SizeConfig.dart';
// import 'package:pets_app/widgets/app_bar_custom.dart';
// import 'package:pets_app/widgets/button_widget.dart';
//
// class CheckoutPage extends StatefulWidget {
//   const CheckoutPage({super.key});
//
//   @override
//   State<CheckoutPage> createState() => _CheckoutPageState();
// }
//
// class _CheckoutPageState extends State<CheckoutPage> {
//   final controller = Get.put(ProductController());
//
//   dynamic argumentData = Get.arguments;
//   double cellHeight = 0;
//   double defMargin = 0;
//   double fontSize = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     double height = getScreenPercentSize(context, 20);
//     cellHeight = getScreenPercentSize(context, 6.5);
//     defMargin = getHorizontalSpace(context);
//     fontSize = getPercentSize(cellHeight, 28);
//
//     return LoaderOverlay(
//       child: GetBuilder<ProductController>(
//           init: ProductController(),
//           builder: (controller) {
//             return Scaffold(
//                 appBar: appBarBack(context, "Checkout", true),
//                 body: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       IconStepper(
//                         icons: const [
//                           Icon(Icons.first_page),
//                           Icon(Icons.pets),
//                           Icon(Icons.last_page),
//                         ],
//                         activeStep: controller.activeStep,
//                         activeStepColor: primaryColor,
//                         stepColor: Colors.grey.withOpacity(0.2),
//                         onStepReached: (index) {
//                           controller.stepReached(index);
//                         },
//                       ),
//                       Expanded(
//                           child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: stepperWidget(height),
//                       )),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: buttonWidget(
//                                 context, "Previous", Colors.white, primaryColor,
//                                 () {
//                               controller.previousButton();
//                             }),
//                           ),
//
//                           Expanded(
//                               child: controller.activeStep == 2
//                                   ? buttonWidget(context, "Save", primaryColor,
//                                       Colors.white, () {
//                                       controller.saveAnimal();
//                                     })
//                                   : buttonWidget(context, "Next", primaryColor,
//                                       Colors.white, () {
//                                       controller.nextButton();
//                                     }))
//
//                           // previousButton(),
//                           // nextButton(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ));
//           }),
//     );
//   }
//
//   Widget stepperWidget(height) {
//     double margin = getScreenPercentSize(context, 1.2);
//     switch (controller.activeStep) {
//       case 0:
//         return ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: addressList.length,
//             padding: EdgeInsets.all(20),
//             itemBuilder: (context, index) {
//               return InkWell(
//                 child: getMaterialCell(context,
//                     widget: Container(
//                       margin: EdgeInsets.only(
//                           bottom: getWidthPercentSize(context, 3)),
//                       padding: EdgeInsets.all(getPercentSize(cellHeight, 10)),
//                       // decoration: getDecoration(getPercentSize(cellHeight,10 )),
//                       decoration: getDecorationWithRadius(
//                           getPercentSize(cellHeight, 10), primaryColor),
//
//                       height: 100,
//
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             flex: 1,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Expanded(
//                                   flex: 1,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             (index == _selectedAddress)
//                                                 ? Icons.radio_button_checked
//                                                 : Icons.radio_button_unchecked,
//                                             color: (index == _selectedAddress)
//                                                 ? primaryColor
//                                                 : subTextColor,
//                                             size:
//                                                 getPercentSize(cellHeight, 25),
//                                           ),
//                                           SizedBox(
//                                             width:
//                                                 getWidthPercentSize(context, 2),
//                                           ),
//                                           Expanded(
//                                             flex: 1,
//                                             child: getCustomTextWithoutAlignWithFontFamily(
//                                                 "city : ${addressList[index].city!}",
//                                                 textColor,
//                                                 FontWeight.w500,
//                                                 getPercentSize(cellHeight, 20)),
//                                           ),
//                                         ],
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             top: (topMargin / 2),
//                                             left: (getWidthPercentSize(
//                                                     context, 2) +
//                                                 getPercentSize(
//                                                     cellHeight, 25))),
//                                         child: getCustomTextWidget(
//                                             addressList[index].street!,
//                                             textColor,
//                                             getPercentSize(cellHeight, 15),
//                                             FontWeight.w400,
//                                             TextAlign.start,
//                                             2,
//                                             context),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: Alignment.centerRight,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(right: 3),
//                                     child: InkWell(
//                                       onTap: () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   EditAddressPage(),
//                                             ));
//                                       },
//                                       child: Image.asset(
//                                         "${assetsPath}edit.png",
//                                         height: getPercentSize(cellHeight, 20),
//                                         // (index ==
//                                         //     _selectedAddress)
//                                         //     ? Icons
//                                         //     .radio_button_checked
//                                         //     : Icons
//                                         //     .radio_button_unchecked,
//                                         // color: (index ==
//                                         //     _selectedAddress)
//                                         //     ? primaryColor
//                                         //     : subTextColor,
//                                         // size: getPercentSize(cellHeight,
//                                         //     25),
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),
//                 onTap: () {
//                   _selectedAddress = index;
//                 },
//               );
//             });
//
//       case 1:
//         return ListView(
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           // mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const Text(
//               "Gender",
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.normal,
//                   color: Colors.grey),
//             ),
//             SizedBox(
//               height: margin,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 getRadioButton(context, "Male", controller.gender[0],
//                     controller.selectedGender, controller.changeGender),
//                 const SizedBox(
//                   width: (8),
//                 ),
//                 getRadioButton(context, "Female", controller.gender[1],
//                     controller.selectedGender, controller.changeGender),
//               ],
//             ),
//             SizedBox(
//               height: margin * 2,
//             ),
//             getTextFiledTitleWidget(context, "", controller.textColorController,
//                 "Color", TextInputType.text),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: getTextFiledTitleWidget(
//                       context,
//                       "",
//                       controller.textWeightController,
//                       "Weight",
//                       TextInputType.number),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 20),
//                     child: getDropDownWidget(
//                         context,
//                         controller.selectedWeight!,
//                         controller.weightList,
//                         controller.changeWeight),
//                   ),
//                 )
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: getTextFiledTitleWidget(
//                       context,
//                       "",
//                       controller.textAgeController,
//                       "Age",
//                       TextInputType.number),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 20),
//                     child: getDropDownWidget(
//                         context,
//                         controller.selectedAgePrefix!,
//                         controller.agePrefixList,
//                         controller.changeAgePrefix),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         );
//
//       case 2:
//         return ListView(
//           children: [
//             const Text(
//               "Vaccinated",
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.normal,
//                   color: Colors.grey),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: [
//                 getRadioButton(context, "Yes", controller.vaccinated[0],
//                     controller.selectedVaccinated, controller.changeVaccinated),
//                 const SizedBox(
//                   width: (10),
//                 ),
//                 getRadioButton(context, "No", controller.vaccinated[1],
//                     controller.selectedVaccinated, controller.changeVaccinated),
//               ],
//             ),
//             SizedBox(
//               height: margin * 2,
//             ),
//             controller.selectedVaccinated == "true"
//                 ? getTextFiledTitleWidget(
//                     context,
//                     "",
//                     controller.textNoOfVaccinatedController,
//                     "Number of vaccines",
//                     TextInputType.number)
//                 : const SizedBox(),
//             SizedBox(
//               height: margin,
//             ),
//             const Text(
//               "Passport",
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.normal,
//                   color: Colors.grey),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: [
//                 getRadioButton(context, "Yes", controller.passport[0],
//                     controller.selectedPassport, controller.changePassport),
//                 const SizedBox(
//                   width: (10),
//                 ),
//                 getRadioButton(context, "No", controller.passport[1],
//                     controller.selectedPassport, controller.changePassport),
//               ],
//             ),
//             SizedBox(
//               height: margin * 2,
//             ),
//             const Text(
//               "Friendly",
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.normal,
//                   color: Colors.grey),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: [
//                 getRadioButton(context, "Yes", controller.friendly[0],
//                     controller.selectedFriendly, controller.changeFriendly),
//                 const SizedBox(
//                   width: (10),
//                 ),
//                 getRadioButton(context, "No", controller.friendly[1],
//                     controller.selectedFriendly, controller.changeFriendly),
//               ],
//             ),
//             SizedBox(
//               height: margin * 2,
//             ),
//             const Text(
//               "More Description",
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.normal,
//                   color: Colors.grey),
//             ),
//             // const SizedBox(
//             //   height: 5,
//             // ),
//             textFiledWidgetLarge(context, "", controller.textDescController),
//           ],
//         );
//
//       default:
//         return Text("Default");
//     }
//   }
// }
