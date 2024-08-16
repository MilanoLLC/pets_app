import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/button_widget.dart';
import 'package:pets_app/widgets/custom_icon.dart';

Widget filterWidget(BuildContext context, controller) {
  double height = getScreenPercentSize(context, 45);
  double margin = getScreenPercentSize(context, 1);
  double padding = getScreenPercentSize(context, 3);
  double defMargin = getHorizontalSpace(context);

  return ListView(
    padding: EdgeInsets.symmetric(horizontal: padding),
    children: [
      SizedBox(
        height: margin,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: margin, vertical: 10),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: getTextWithFontFamilyWidget('Filter By',
                  getPercentSize(height, 5), FontWeight.w500, TextAlign.start),
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black
                        .withOpacity(0.8), // Adjust color as needed
                  ),
                  child: Icon(
                    Icons.close,
                    size: getPercentSize(height, 4),
                    color: Theme.of(context).hintColor,
                  ),
                )),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(
            vertical: (defMargin / 2.2), horizontal: defMargin),
        height: getScreenPercentSize(context, 0.03),
        color: primaryColor.withOpacity(0.7),
      ),
      SizedBox(
        height: getPercentSize(height, 4),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: getTextWidget('Age', Colors.grey, getPercentSize(height, 3.5),
            FontWeight.normal, TextAlign.start),
      ),
      MultiSelectChipField(
        items: controller.ages,
        chipShape: SmoothRectangleBorder(
          side: BorderSide(color: primaryColor),
          borderRadius: SmoothBorderRadius(
            cornerRadius: 6,
            cornerSmoothing: 0.8,
          ),
        ),
        // initialValue: [],
        showHeader: false,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 0),
        ),
        selectedChipColor: primaryColor,
        textStyle: TextStyle(color: Theme.of(context).hintColor),
        selectedTextStyle: const TextStyle(color: Colors.white),
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
        chipColor: Theme.of(context).cardColor,
        scroll: false,
        onTap: (values) {
          //_selectedAnimals4 = values;
        },
      ),
      SizedBox(
        height: margin,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: getTextWidget('Gender', Colors.grey, getPercentSize(height, 3.5),
            FontWeight.normal, TextAlign.start),
      ),
      MultiSelectChipField(
        items: controller.gender,
        chipShape: SmoothRectangleBorder(
          side: BorderSide(color: primaryColor),
          borderRadius: SmoothBorderRadius(
            cornerRadius: 6,
            cornerSmoothing: 0.8,
          ),
        ),
        // initialValue: [],
        showHeader: false,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 0),
        ),
        selectedChipColor: primaryColor,
        textStyle: TextStyle(color: Theme.of(context).hintColor),
        selectedTextStyle: const TextStyle(color: Colors.white),
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
        chipColor: Theme.of(context).cardColor,
        scroll: false,
        onTap: (values) {
          //_selectedAnimals4 = values;
        },
      ),
      SizedBox(
        height: margin,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: getTextWidget('Friendly', Colors.grey,
            getPercentSize(height, 3.5), FontWeight.normal, TextAlign.start),
      ),
      MultiSelectChipField(
        items: controller.friendly,
        chipShape: SmoothRectangleBorder(
          side: BorderSide(color: primaryColor),
          borderRadius: SmoothBorderRadius(
            cornerRadius: 6,
            cornerSmoothing: 0.8,
          ),
        ),
        // initialValue: [],
        showHeader: false,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 0),
        ),
        selectedChipColor: primaryColor,
        textStyle: TextStyle(color: Theme.of(context).hintColor),
        selectedTextStyle: const TextStyle(color: Colors.white),
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
        chipColor: Theme.of(context).cardColor,
        scroll: false,
        onTap: (values) {
          //_selectedAnimals4 = values;
        },
      ),
      SizedBox(
        height: margin,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: getTextWidget('Vaccinated', Colors.grey,
            getPercentSize(height, 3.5), FontWeight.normal, TextAlign.start),
      ),
      MultiSelectChipField(
        items: controller.vaccinated,
        chipShape: SmoothRectangleBorder(
          side: BorderSide(color: primaryColor),
          borderRadius: SmoothBorderRadius(
            cornerRadius: 6,
            cornerSmoothing: 0.8,
          ),
        ),
        // initialValue: [],
        showHeader: false,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 0),
        ),
        selectedChipColor: primaryColor,
        textStyle: TextStyle(color: Theme.of(context).hintColor),
        selectedTextStyle: const TextStyle(color: Colors.white),
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
        chipColor: Theme.of(context).cardColor,
        scroll: false,
        onTap: (values) {
          //_selectedAnimals4 = values;
        },
      ),
      SizedBox(
        height: margin,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: getTextWidget('Location', Colors.grey,
            getPercentSize(height, 3.5), FontWeight.normal, TextAlign.start),
      ),
      SizedBox(
        height: getPercentSize(height, 2),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: MultiSelectDialogField(
          onConfirm: (values) {},
          dialogWidth: MediaQuery.of(context).size.width * 0.7,
          items: controller.emirates,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor),
          ),
          backgroundColor: Theme.of(context).cardColor,
          itemsTextStyle: TextStyle(color: Theme.of(context).hintColor),
          selectedItemsTextStyle: TextStyle(color: primaryColor),
          // initialValue: controller.emirates[
          //     0], // setting the value of this in initState() to pre-select values.
        ),
      ),
      SizedBox(
        height: margin,
      ),
      SizedBox(
        height: margin,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: getTextWidget('Color', Colors.grey, getPercentSize(height, 3.5),
            FontWeight.normal, TextAlign.start),
      ),
      SizedBox(
        height: margin,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: margin),
        child: MultiSelectDialogField(
          onConfirm: (values) {},
          dialogWidth: MediaQuery.of(context).size.width * 0.7,
          items: controller.colors,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor),
          ),
          backgroundColor: Theme.of(context).cardColor,
          itemsTextStyle: TextStyle(color: Theme.of(context).hintColor),
          selectedItemsTextStyle: TextStyle(color: primaryColor),
          // initialValue: controller.emirates[
          //     0], // setting the value of this in initState() to pre-select values.
        ),
      ),
      SizedBox(
        height: getScreenPercentSize(context, 3),
      ),

      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20),
      //   child: DropdownButton(
      //     value: controller.dropdownValue,
      //     icon: const Icon(Icons.keyboard_arrow_down),
      //     items: controller.items.map((String items) {
      //       return DropdownMenuItem(
      //         value: items,
      //         child: Text(items),
      //       );
      //     }).toList(),
      //     onChanged: func,
      //   ),
      // ),
      // SizedBox(
      //   height: getScreenPercentSize(context, 3),
      // ),
      // Padding(
      //   padding: EdgeInsets.symmetric(horizontal: margin),
      //   child: getTextWithFontFamilyWidget(
      //       'Friendly',
      //       getPercentSize(height, 4),
      //       FontWeight.w500,
      //       TextAlign.start),
      // ),
      //
      // // const Text(
      // //   "Friendly",
      // //   style:
      // //       TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      // // ),
      // Row(
      //   children: [
      //     // getRadioButton(
      //     //     context,
      //     //     "Yes",
      //     //     controller.friendly[0],
      //     //     controller.selectedFriendly,
      //     //     controller.changeFriendly),
      //
      //     Expanded(
      //       flex: 1,
      //       child: ListTile(
      //         contentPadding: const EdgeInsets.all(0),
      //         title: const Text("Yes"),
      //         tileColor: Colors.transparent,
      //         selectedTileColor: Colors.black,
      //         selectedColor: Colors.black,
      //         textColor: Theme.of(context).hintColor,
      //         leading: Radio(
      //           value: controller.friendly[0],
      //           groupValue: controller.selectedFriendly,
      //           // onChanged: controller.changeGender,
      //           onChanged: (String? value) {
      //             setState(() {
      //               controller.selectedFriendly = value!;
      //             });
      //           },
      //           activeColor: Colors.blue,
      //           fillColor: MaterialStateColor.resolveWith(
      //               (states) => Colors.blue),
      //         ),
      //         iconColor: Colors.black,
      //       ),
      //     ),
      //     SizedBox(
      //       width: (margin),
      //     ),
      //     // getRadioButton(
      //     //     context,
      //     //     "No",
      //     //     controller.friendly[1],
      //     //     controller.selectedFriendly,
      //     //     controller.changeFriendly),
      //
      //     Expanded(
      //       flex: 1,
      //       child: ListTile(
      //         contentPadding: const EdgeInsets.all(0),
      //         title: const Text("No"),
      //         tileColor: Colors.transparent,
      //         selectedTileColor: Colors.black,
      //         selectedColor: Colors.black,
      //         textColor: Theme.of(context).hintColor,
      //         leading: Radio(
      //           value: controller.friendly[1],
      //           groupValue: controller.selectedFriendly,
      //           // onChanged: controller.changeGender,
      //           onChanged: (String? value) {
      //             setState(() {
      //               controller.selectedFriendly = value!;
      //             });
      //           },
      //           activeColor: Colors.blue,
      //           fillColor: MaterialStateColor.resolveWith(
      //               (states) => Colors.blue),
      //         ),
      //         iconColor: Colors.black,
      //       ),
      //     ),
      //   ],
      // ),
      // SizedBox(
      //   height: getPercentSize(height, 2),
      // ),
      // Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Expanded(
      //       child: ListTile(
      //         contentPadding: const EdgeInsets.all(0),
      //         title: const Text('Yes'),
      //         leading: Radio<Friendly>(
      //           value: Friendly.friendly,
      //           groupValue: _friendly,
      //           onChanged: (Friendly? value) {
      //             setState(() {
      //               _friendly = value;
      //             });
      //           },
      //         ),
      //       ),
      //     ),
      //     Expanded(
      //       child: ListTile(
      //         contentPadding: const EdgeInsets.all(0),
      //         title: const Text('No'),
      //         leading: Radio<Friendly>(
      //           value: Friendly.unfriendly,
      //           groupValue: _friendly,
      //           onChanged: (Friendly? value) {
      //             setState(() {
      //               _friendly = value;
      //             });
      //           },
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      // SizedBox(
      //   height: getScreenPercentSize(context, 5),
      // ),

      // Padding(
      //   padding: EdgeInsets.symmetric(horizontal: margin),
      //   child: getTextWithFontFamilyWidget(
      //       'Vaccinated',
      //       getPercentSize(height, 4),
      //       FontWeight.w500,
      //       TextAlign.start),
      // ),
      // SizedBox(
      //   height: getPercentSize(height, 2),
      // ),
      // Row(
      //   children: [
      //     // getRadioButton(
      //     //     context,
      //     //     "Yes",
      //     //     controller.vaccinated[0],
      //     //     controller.selectedVaccinated,
      //     //     controller.changeVaccinated),
      //     Expanded(
      //       flex: 1,
      //       child: ListTile(
      //         contentPadding: const EdgeInsets.all(0),
      //         title: const Text("Yes"),
      //         tileColor: Colors.transparent,
      //         selectedTileColor: Colors.black,
      //         selectedColor: Colors.black,
      //         textColor: Theme.of(context).hintColor,
      //         leading: Radio(
      //           value: controller.vaccinated[0],
      //           groupValue: controller.selectedVaccinated,
      //           // onChanged: controller.changeGender,
      //           onChanged: (String? value) {
      //             setState(() {
      //               controller.selectedVaccinated = value!;
      //             });
      //           },
      //           activeColor: Colors.blue,
      //           fillColor: MaterialStateColor.resolveWith(
      //               (states) => Colors.blue),
      //         ),
      //         iconColor: Colors.black,
      //       ),
      //     ),
      //     SizedBox(
      //       width: (margin),
      //     ),
      //     // getRadioButton(
      //     //     context,
      //     //     "No",
      //     //     controller.vaccinated[1],
      //     //     controller.selectedVaccinated,
      //     //     controller.changeVaccinated),
      //
      //     Expanded(
      //       flex: 1,
      //       child: ListTile(
      //         contentPadding: const EdgeInsets.all(0),
      //         title: const Text("No"),
      //         tileColor: Colors.transparent,
      //         selectedTileColor: Colors.black,
      //         selectedColor: Colors.black,
      //         textColor: Theme.of(context).hintColor,
      //         leading: Radio(
      //           value: controller.vaccinated[1],
      //           groupValue: controller.selectedVaccinated,
      //           // onChanged: controller.changeGender,
      //           onChanged: (String? value) {
      //             setState(() {
      //               controller.selectedVaccinated = value!;
      //             });
      //           },
      //           activeColor: Colors.blue,
      //           fillColor: MaterialStateColor.resolveWith(
      //               (states) => Colors.blue),
      //         ),
      //         iconColor: Colors.black,
      //       ),
      //     ),
      //   ],
      // ),
      // SizedBox(
      //   height: getPercentSize(height, 10),
      // ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: buttonWidget(context, "Clear Filter",primaryColor, Colors.white, () {
              controller.filterAnimals().then((value) => Loader.hide());
            }),
          ),
          Expanded(
            child: buttonWidget(context, "Apply", primaryColor,Colors.white, () {
              controller.filterAnimals().then((value) => Loader.hide());
            }),
          ),
        ],
      ),
      SizedBox(
        height: getPercentSize(height, 3),
      ),
    ],
  );
}
