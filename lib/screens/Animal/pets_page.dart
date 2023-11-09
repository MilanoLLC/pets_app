// ignore_for_file: must_be_immutable

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pets_app/controllers/home_controller.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:get/get.dart';

// enum Age { less, oneTo3, threeTo6, more }
//
// enum Gender { male, female }
//
//
// enum Vaccinated { vaccinated, unvaccinated }

class PetsPage extends GetView<HomeController> {
  PetsPage({Key? key}) : super(key: key);

  // Age? _age = Age.less;
  // Gender? _gender = Gender.male;
  // Vaccinated? _vaccinated = Vaccinated.vaccinated;
  double padding = 0;
  double defMargin = 0;
  double height = 0;
  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;

  double cellHeight = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    padding = getScreenPercentSize(context, 2);
    defMargin = getHorizontalSpace(context);
    height = getScreenPercentSize(context, 5.5);
    double radius = getScreenPercentSize(context, 1.5);
    return LoaderOverlay(
      child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return Scaffold(
              // backgroundColor: backgroundColor,
              appBar: AppBar(
                title: const Text("All Pets"),
                elevation: 0,
                centerTitle: true,
              ),

              body: Column(
                children: [
                  SizedBox(
                    height: defMargin,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: defMargin,
                      ),
                      Expanded(
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return Container(
                              decoration: getDecorationWithBorder(
                                  radius, Theme.of(context).cardColor,
                                  color: Colors.transparent),
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
                                    fontSize:
                                        getScreenPercentSize(context, 1.7),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  filled: true,
                                  isDense: true,
                                  fillColor: Colors.transparent,
                                  disabledBorder: getOutLineBorder(radius),
                                  enabledBorder: getOutLineBorder(radius),
                                  focusedBorder: getOutLineBorder(radius),
                                ),
                                onChanged: (string) {
                                  controller.filterSearchResultsByType(string);
                                  // debouncer.run(() {
                                  //   setState(() {
                                  //     controller.products = controller.productList
                                  //         .where(
                                  //           (u) =>
                                  //               (u.animalName!.toLowerCase().contains(
                                  //                     string.toLowerCase(),
                                  //                   )),
                                  //         )
                                  //         .toList();
                                  //   });
                                  // });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: (defMargin / 2),
                      ),
                      InkWell(
                        onTap: () {
                          filterDialog1(context);
                        },
                        child: getMaterialWidget(
                            context,
                            Container(
                              height: height,
                              width: height,
                              decoration:
                                  getDecorationWithColor(radius, primaryColor),
                              child: Center(
                                child: Image.asset(
                                    "${assetsPath}filter bold.png",
                                    color: Colors.white,
                                    height: getPercentSize(height, 55)),
                              ),
                            ),
                            radius,
                            height),
                      ),
                      SizedBox(
                        width: (defMargin),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getScreenPercentSize(context, 1.5),
                  ),
                  Expanded(
                      child: controller.products.isNotEmpty
                          ? animalList(context)
                          : emptyWidget(context))
                ],
              ),
            );
          }),
    );
  }

  emptyWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "${iconsPath}box.png",
          height: getScreenPercentSize(context, 20),
        ),
        SizedBox(
          height: getScreenPercentSize(context, 3),
        ),
        getCustomTextWithFontFamilyWidget(
            "There is no data!",
            Theme.of(context).hintColor,
            getScreenPercentSize(context, 2.5),
            FontWeight.w500,
            TextAlign.center,
            1),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  animalList(BuildContext context) {
    defMargin = getScreenPercentSize(context, 1.5);
    var height = getScreenPercentSize(context, 35);
    double width = getWidthPercentSize(context, 40);
    double imgHeight = getPercentSize(height, 45);
    double remainHeight = height - imgHeight;
    double radius = getPercentSize(height, 5);
    var crossAxisCount = 2;

    return Obx(
      () => LazyLoadScrollView(
          onEndOfPage: controller.loadNextPage,
          isLoading: controller.lastPage,
          child: GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: (defMargin * 1.2)),
            scrollDirection: Axis.vertical,
            primary: false,
            crossAxisSpacing: (defMargin * 2),
            mainAxisSpacing: 0,
            childAspectRatio: 0.6,
            children: List.generate(controller.products.length, (index) {
              AnimalModel model = controller.products[index];

              return InkWell(
                child: Container(
                  width: width,
                  margin: EdgeInsets.only(top: defMargin, bottom: (defMargin)),
                  decoration: ShapeDecoration(
                    color: Theme.of(context).cardColor,
                    shadows: [
                      BoxShadow(
                          color: subTextColor.withOpacity(0.1),
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: const Offset(0, 1))
                    ],
                    shape: SmoothRectangleBorder(
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
                        margin: EdgeInsets.only(
                            top: getPercentSize(width, 7),
                            bottom: getPercentSize(width, 5)),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: getPercentSize(imgHeight, 9),
                                  // vertical: getPercentSize(imgHeight, 6)
                                ),
                                child: Center(
                                  child: model.images![0] == null
                                      ? Image.asset(
                                          'assets/images/no image.jpg')
                                      : FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/images/no image.jpg',
                                          image: networkPath + model.images![0],
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: getPercentSize(width, 5)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: getCustomTextWidget(
                                        model.animalName!,
                                        Theme.of(context).hintColor,
                                        getPercentSize(remainHeight, 8),
                                        FontWeight.bold,
                                        TextAlign.center,
                                        1)),
                              ],
                            ),
                            SizedBox(
                              height: getPercentSize(remainHeight, 5),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: getTextWidget(
                                      model.type.toString(),
                                      subTextColor,
                                      getPercentSize(remainHeight, 8),
                                      FontWeight.w400,
                                      TextAlign.center),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getPercentSize(remainHeight, 5),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            "assets/icons/gender.png"),
                                        width: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      getTextWidget(
                                          model.gender!,
                                          subTextColor,
                                          getPercentSize(remainHeight, 8),
                                          FontWeight.w400,
                                          TextAlign.start),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            "assets/icons/paint-tube.png"),
                                        width: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      getTextWidget(
                                          model.color.toString(),
                                          subTextColor,
                                          getPercentSize(remainHeight, 8),
                                          FontWeight.w400,
                                          TextAlign.start),
                                    ],
                                  ),
                                  // )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getPercentSize(remainHeight, 5),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            "assets/icons/calendar.png"),
                                        width: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      getTextWidget(
                                          "${model.age!} ${model.agePrefix!}",
                                          subTextColor,
                                          getPercentSize(remainHeight, 8),
                                          FontWeight.w400,
                                          TextAlign.start),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            "assets/icons/scale.png"),
                                        width: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      getTextWidget(
                                          model.weight.toString(),
                                          subTextColor,
                                          getPercentSize(remainHeight, 8),
                                          FontWeight.w400,
                                          TextAlign.start),
                                    ],
                                  ),

                                  // )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getPercentSize(remainHeight, 5),
                            ),
                            SizedBox(
                              width: getPercentSize(width, 2),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
                onTap: () {
                  Get.toNamed(Routes.PETDETAILS, arguments: [
                    {'model': model}
                  ]);
                },
              );
            }),
          )),
    );
  }

  filterDialog1(BuildContext context) {
    double height = getScreenPercentSize(context, 45);
    double radius = getScreenPercentSize(context, 3);
    double margin = getScreenPercentSize(context, 2);

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).cardColor),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius))),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return FractionallySizedBox(
                heightFactor: 0.6,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: margin,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: margin),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: getTextWithFontFamilyWidget(
                                'Filter',
                                getPercentSize(height, 5),
                                FontWeight.w500,
                                TextAlign.start),
                          ),
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
                      height: getPercentSize(height, 4),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: margin),
                      child: getTextWithFontFamilyWidget(
                          'Age',
                          getPercentSize(height, 4),
                          FontWeight.w500,
                          TextAlign.start),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("less than one year"),
                            tileColor: Colors.transparent,
                            selectedTileColor: Colors.black,
                            selectedColor: Colors.black,
                            textColor: Theme.of(context).hintColor,
                            leading: Radio(
                              value: controller.age[0],
                              groupValue: controller.selectedAge,
                              // onChanged: controller.changeGender,
                              onChanged: (String? value) {
                                setState(() {
                                  controller.selectedAge = value!;
                                });
                              },
                              activeColor: Colors.blue,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue),
                            ),
                            iconColor: Colors.black,
                          ),
                        ),
                        // getRadioButton(
                        //     context,
                        //     "less than one year",
                        //     controller.age[0],
                        //     controller.selectedAge,
                        //     controller.changeAge),
                        SizedBox(
                          width: (margin),
                        ),
                        // getRadioButton(
                        //     context,
                        //     "1 year to 3 years ",
                        //     controller.age[1],
                        //     controller.selectedAge,
                        //     controller.changeAge),

                        Expanded(
                          flex: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("1 year to 3 years"),
                            tileColor: Colors.transparent,
                            selectedTileColor: Colors.black,
                            selectedColor: Colors.black,
                            textColor: Theme.of(context).hintColor,
                            leading: Radio(
                              value: controller.age[1],
                              groupValue: controller.selectedAge,
                              // onChanged: controller.changeGender,
                              onChanged: (String? value) {
                                setState(() {
                                  controller.selectedAge = value!;
                                });
                              },
                              activeColor: Colors.blue,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue),
                            ),
                            iconColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // getRadioButton(
                        //     context,
                        //     "3 years to 6 years",
                        //     controller.age[2],
                        //     controller.selectedAge,
                        //     // setState(() {
                        //     controller.changeAge
                        //     // })
                        //
                        //     ),

                        Expanded(
                          flex: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("3 years to 6 years"),
                            tileColor: Colors.transparent,
                            selectedTileColor: Colors.black,
                            selectedColor: Colors.black,
                            textColor: Theme.of(context).hintColor,
                            leading: Radio(
                              value: controller.age[2],
                              groupValue: controller.selectedAge,
                              // onChanged: controller.changeGender,
                              onChanged: (String? value) {
                                setState(() {
                                  controller.selectedAge = value!;
                                });
                              },
                              activeColor: Colors.blue,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue),
                            ),
                            iconColor: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: (margin),
                        ),
                        // getRadioButton(
                        //     context,
                        //     "more than 6 years",
                        //     controller.age[3],
                        //     controller.selectedAge,
                        //     controller.changeAge),
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("more than 6 years"),
                            tileColor: Colors.transparent,
                            selectedTileColor: Colors.black,
                            selectedColor: Colors.black,
                            textColor: Theme.of(context).hintColor,
                            leading: Radio(
                              value: controller.age[3],
                              groupValue: controller.selectedAge,
                              // onChanged: controller.changeGender,
                              onChanged: (String? value) {
                                setState(() {
                                  controller.selectedAge = value!;
                                });
                              },
                              activeColor: Colors.blue,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue),
                            ),
                            iconColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: margin),
                    //   child: getTextWithFontFamilyWidget(
                    //       'Age',
                    //       getPercentSize(height, 4),
                    //       FontWeight.w500,
                    //       TextAlign.start),
                    // ),
                    // SizedBox(
                    //   height: getPercentSize(height, 2),
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: ListTile(
                    //         contentPadding: const EdgeInsets.all(0),
                    //         title: const Text('less than one year'),
                    //         leading: Radio<Age>(
                    //           value: Age.less,
                    //           groupValue: _age,
                    //           onChanged: (Age? value) {
                    //             setState(() {
                    //               _age = value;
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: ListTile(
                    //         contentPadding: const EdgeInsets.all(0),
                    //         title: const Text('1 year to 3 years '),
                    //         leading: Radio<Age>(
                    //           value: Age.oneTo3,
                    //           groupValue: _age,
                    //           onChanged: (Age? value) {
                    //             setState(() {
                    //               _age = value;
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: ListTile(
                    //         contentPadding: const EdgeInsets.all(0),
                    //         title: const Text('3 years to 6 years'),
                    //         leading: Radio<Age>(
                    //           value: Age.threeTo6,
                    //           groupValue: _age,
                    //           onChanged: (Age? value) {
                    //             setState(() {
                    //               _age = value;
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: ListTile(
                    //         contentPadding: const EdgeInsets.all(0),
                    //         title: const Text('more than 6 years'),
                    //         leading: Radio<Age>(
                    //           value: Age.more,
                    //           groupValue: _age,
                    //           onChanged: (Age? value) {
                    //             setState(() {
                    //               _age = value;
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: getScreenPercentSize(context, 3),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: margin),
                      child: getTextWithFontFamilyWidget(
                          'Gender',
                          getPercentSize(height, 4),
                          FontWeight.w500,
                          TextAlign.start),
                    ),
                    SizedBox(
                      height: getPercentSize(height, 2),
                    ),
                    Row(
                      children: [
                        // getRadioButton(context, "Male", controller.gender[0],
                        //     controller.selectedGender, controller.changeGender),
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("Male"),
                            tileColor: Colors.transparent,
                            selectedTileColor: Colors.black,
                            selectedColor: Colors.black,
                            textColor: Theme.of(context).hintColor,
                            leading: Radio(
                              value: controller.gender[0],
                              groupValue: controller.selectedGender,
                              // onChanged: controller.changeGender,
                              onChanged: (String? value) {
                                setState(() {
                                  controller.selectedGender = value!;
                                });
                              },
                              activeColor: Colors.blue,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue),
                            ),
                            iconColor: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: (margin),
                        ),
                        // getRadioButton(context, "Female", controller.gender[1],
                        //     controller.selectedGender, controller.changeGender),
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("Female"),
                            tileColor: Colors.transparent,
                            selectedTileColor: Colors.black,
                            selectedColor: Colors.black,
                            textColor: Theme.of(context).hintColor,
                            leading: Radio(
                              value: controller.gender[1],
                              groupValue: controller.selectedGender,
                              // onChanged: controller.changeGender,
                              onChanged: (String? value) {
                                setState(() {
                                  controller.selectedGender = value!;
                                });
                              },
                              activeColor: Colors.blue,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue),
                            ),
                            iconColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getScreenPercentSize(context, 3),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: margin),
                      child: getTextWithFontFamilyWidget(
                          'Location',
                          getPercentSize(height, 4),
                          FontWeight.w500,
                          TextAlign.start),
                    ),
                    SizedBox(
                      height: getPercentSize(height, 2),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButton(
                        value: controller.dropdownValue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            controller.dropdownValue = newValue!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: getScreenPercentSize(context, 3),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: margin),
                      child: getTextWithFontFamilyWidget(
                          'Friendly',
                          getPercentSize(height, 4),
                          FontWeight.w500,
                          TextAlign.start),
                    ),

                    // const Text(
                    //   "Friendly",
                    //   style:
                    //       TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    // ),
                    Row(
                      children: [
                        // getRadioButton(
                        //     context,
                        //     "Yes",
                        //     controller.friendly[0],
                        //     controller.selectedFriendly,
                        //     controller.changeFriendly),

                        Expanded(
                          flex: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("Yes"),
                            tileColor: Colors.transparent,
                            selectedTileColor: Colors.black,
                            selectedColor: Colors.black,
                            textColor: Theme.of(context).hintColor,
                            leading: Radio(
                              value: controller.friendly[0],
                              groupValue: controller.selectedFriendly,
                              // onChanged: controller.changeGender,
                              onChanged: (String? value) {
                                setState(() {
                                  controller.selectedFriendly = value!;
                                });
                              },
                              activeColor: Colors.blue,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue),
                            ),
                            iconColor: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: (margin),
                        ),
                        // getRadioButton(
                        //     context,
                        //     "No",
                        //     controller.friendly[1],
                        //     controller.selectedFriendly,
                        //     controller.changeFriendly),

                        Expanded(
                          flex: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("No"),
                            tileColor: Colors.transparent,
                            selectedTileColor: Colors.black,
                            selectedColor: Colors.black,
                            textColor: Theme.of(context).hintColor,
                            leading: Radio(
                              value: controller.friendly[1],
                              groupValue: controller.selectedFriendly,
                              // onChanged: controller.changeGender,
                              onChanged: (String? value) {
                                setState(() {
                                  controller.selectedFriendly = value!;
                                });
                              },
                              activeColor: Colors.blue,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue),
                            ),
                            iconColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getPercentSize(height, 2),
                    ),
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: margin),
                      child: getTextWithFontFamilyWidget(
                          'Color',
                          getPercentSize(height, 4),
                          FontWeight.w500,
                          TextAlign.start),
                    ),
                    SizedBox(
                      height: getPercentSize(height, 2),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        maxLines: 1,
                        controller: controller.colorEditingController,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                            fontFamily: fontFamily,
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: getWidthPercentSize(context, 2)),
                          border: const OutlineInputBorder(),
                          // focusedBorder: InputBorder.none,
                          // enabledBorder: InputBorder.none,
                          // errorBorder: InputBorder.none,
                          // disabledBorder: InputBorder.none,
                          // hintText: s,
                          // suffixIcon: Icon(
                          //   Icons.add,
                          //   color: Colors.transparent,
                          //   size: getPercentSize(cellHeight, 40),
                          // ),
                          // hintStyle: TextStyle(
                          //     fontFamily: fontFamily,
                          //     color: subTextColor,
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: fontSize)
                        ),
                      ),
                      // child: DropdownButton(
                      //   value: controller.dropdownValue,
                      //   icon: const Icon(Icons.keyboard_arrow_down),
                      //   items: controller.items.map((String items) {
                      //     return DropdownMenuItem(
                      //       value: items,
                      //       child: Text(items),
                      //     );
                      //   }).toList(),
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       controller.dropdownValue = newValue!;
                      //     });
                      //   },
                      // ),
                    ),
                    SizedBox(
                      height: getScreenPercentSize(context, 3),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: margin),
                      child: getTextWithFontFamilyWidget(
                          'Vaccinated',
                          getPercentSize(height, 4),
                          FontWeight.w500,
                          TextAlign.start),
                    ),
                    SizedBox(
                      height: getPercentSize(height, 2),
                    ),
                    Row(
                      children: [
                        // getRadioButton(
                        //     context,
                        //     "Yes",
                        //     controller.vaccinated[0],
                        //     controller.selectedVaccinated,
                        //     controller.changeVaccinated),
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("Yes"),
                            tileColor: Colors.transparent,
                            selectedTileColor: Colors.black,
                            selectedColor: Colors.black,
                            textColor: Theme.of(context).hintColor,
                            leading: Radio(
                              value: controller.vaccinated[0],
                              groupValue: controller.selectedVaccinated,
                              // onChanged: controller.changeGender,
                              onChanged: (String? value) {
                                setState(() {
                                  controller.selectedVaccinated = value!;
                                });
                              },
                              activeColor: Colors.blue,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue),
                            ),
                            iconColor: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: (margin),
                        ),
                        // getRadioButton(
                        //     context,
                        //     "No",
                        //     controller.vaccinated[1],
                        //     controller.selectedVaccinated,
                        //     controller.changeVaccinated),

                        Expanded(
                          flex: 1,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("No"),
                            tileColor: Colors.transparent,
                            selectedTileColor: Colors.black,
                            selectedColor: Colors.black,
                            textColor: Theme.of(context).hintColor,
                            leading: Radio(
                              value: controller.vaccinated[1],
                              groupValue: controller.selectedVaccinated,
                              // onChanged: controller.changeGender,
                              onChanged: (String? value) {
                                setState(() {
                                  controller.selectedVaccinated = value!;
                                });
                              },
                              activeColor: Colors.blue,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.blue),
                            ),
                            iconColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
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
                                // Loader.show(context,
                                //     isSafeAreaOverlay: false,
                                //     progressIndicator:
                                //         const CircularProgressIndicator(),
                                //     isBottomBarOverlay: false,
                                //     overlayFromBottom: 0,
                                //     themeData: Theme.of(context).copyWith(
                                //         colorScheme: ColorScheme.fromSwatch()
                                //             .copyWith(
                                //                 secondary: Colors.black38)),
                                //     overlayColor: const Color(0x33E8EAF6));

                                // age, color, friendly, gender, location, vaccinated

                                controller
                                    .filterAnimals()
                                    .then((value) => Loader.hide());
                              },
                              child: getMaterialCell(context,
                                  widget: Container(
                                    margin: EdgeInsets.only(
                                        left: getWidthPercentSize(context, 3)),
                                    height: getScreenPercentSize(context, 7),
                                    decoration: ShapeDecoration(
                                      color: primaryColor,
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
                  ],
                ),
              );
            },
          );
        });
  }

  getShapeDecoration(BuildContext context) {
    double radius = getPercentSize(cellHeight, 20);

    return ShapeDecoration(
      color: Colors.transparent,
      shape: SmoothRectangleBorder(
        side: const BorderSide(color: Colors.transparent, width: 0.3),
        borderRadius: SmoothBorderRadius(
          cornerRadius: radius,
          cornerSmoothing: 0.8,
        ),
      ),
    );
  }

  // Widget getRadioButton(BuildContext context, String s, String val,
  //     String controllerSelected, func) {
  //   return Expanded(
  //     flex: 1,
  //     // child: Container(
  //     // height: cellHeight,
  //     // width: double.infinity,
  //     // margin:
  //     //     EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 1.2)),
  //     // padding:
  //     //     EdgeInsets.symmetric(horizontal: getWidthPercentSize(context, 1)),
  //     // alignment: Alignment.centerLeft,
  //     // decoration: getShapeDecoration(context),
  //     child: ListTile(
  //       contentPadding: const EdgeInsets.all(0),
  //       title: Text(s),
  //       tileColor: Colors.transparent,
  //       selectedTileColor: Colors.black,
  //       selectedColor: Colors.black,
  //       textColor: Theme.of(context).hintColor,
  //       leading: Radio(
  //         value: val,
  //         groupValue: controllerSelected,
  //         // onChanged: func,
  //         onChanged: (String? value) {
  //           setState(() {
  //             controller.selectedGender = value!;
  //           });
  //         },
  //         activeColor: Colors.blue,
  //         fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
  //       ),
  //       iconColor: Colors.black,
  //       // ),
  //     ),
  //   );
  // }
}
