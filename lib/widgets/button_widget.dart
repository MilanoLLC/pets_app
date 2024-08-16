import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';

Widget buttonWidget(
    BuildContext context, title, btnColor, txtColor, function) {
  double height = getScreenPercentSize(context, 7);
  double fontSize = getPercentSize(height, 30);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    child: MaterialButton(
      onPressed: function,
      height: height,
      minWidth: double.infinity,
      color: btnColor,
      elevation: 0,
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 10,
          cornerSmoothing: 1,
        ),
      ),
      child: Center(
          child: getDefaultTextWidget(
              title, TextAlign.center, FontWeight.w500, fontSize, txtColor)),
    ),
  );
}

// Widget buttonWidgetWhite(BuildContext context, title, color, function) {
//   double height = getScreenPercentSize(context, 7);
//   double fontSize = getPercentSize(height, 30);
//   return Padding(
//     padding: const EdgeInsets.all(20),
//     child: Container(
//       decoration: ShapeDecoration(
//         color: Theme.of(context).cardColor,
//         shape: SmoothRectangleBorder(
//           borderRadius: SmoothBorderRadius(
//             cornerRadius: 10,
//             cornerSmoothing: 1,
//           ),
//         ),
//         shadows: [
//           BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               blurRadius: 0.5,
//               spreadRadius: 0.5,
//               offset: const Offset(0, 1))
//         ],
//       ),
//       child: MaterialButton(
//         onPressed: function,
//         height: height,
//         minWidth: double.infinity,
//         color: color,
//         elevation: 0,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(theRadius))),
//         child: Center(
//             child: getDefaultTextWidget(title, TextAlign.center, FontWeight.w500,
//                 fontSize, primaryColor)),
//       ),
//     ),
//   );
// }
