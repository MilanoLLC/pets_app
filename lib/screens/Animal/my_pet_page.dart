// ignore_for_file: must_be_immutable, no_logic_in_create_state, use_key_in_widget_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/controllers/product_controller.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';

class MyPetPage extends GetView<ProductController> {
  MyPetPage({Key? key}) : super(key: key);

  double leftMargin = 0;

  Future<bool> _requestPop() {
    Get.back();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    leftMargin = getHorizontalSpace(context);

    return GetBuilder<ProductController>(
        init: ProductController(),
        builder: (controller) {
          return WillPopScope(
              onWillPop: _requestPop,
              child: Scaffold(
                // backgroundColor: backgroundColor,
                appBar: AppBar(
                    title: const Text("My Pets"),
                    elevation: 0,
                    centerTitle: true,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.NEWPET);
                            },
                            child: const Icon(Icons.add)),
                      ),
                    ],
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_outlined),
                      onPressed: () {
                        Get.back();
                      },
                    )),
                body: (controller.isLoading.value)
                    ? const Center(child:  CircularProgressIndicator()) // Show loader
                    : Column(
                        children: [
                          SizedBox(
                            height: getScreenPercentSize(context, 1.5),
                          ),
                          Expanded(
                            child: controller.myPets.isNotEmpty
                                ? Container(
                                    margin: EdgeInsets.only(
                                        bottom:
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.myPets.length,
                                        itemBuilder: (context, index) {
                                          return ListItem(
                                              index, controller.myPets[index],
                                              () {
                                            AwesomeDialog(
                                              context: context,
                                              // dialogType: DialogType.infoReverse,
                                              headerAnimationLoop: true,
                                              // animType: AnimType.bottomSlide,
                                              title: 'Are you sure?',
                                              // reverseBtnOrder: true,
                                              btnOkOnPress: () {
                                                controller.removeItem(
                                                    controller
                                                        .myPets[index].serial,
                                                    index);
                                              },
                                              btnOkText: "ok",
                                              btnCancelOnPress: () {},
                                              // desc:
                                              // 'Lorem ipsum dolor sit amet consectetur adipiscing elit eget ornare tempus, vestibulum sagittis rhoncus felis hendrerit lectus ultricies duis vel, id morbi cum ultrices tellus metus dis ut donec. Ut sagittis viverra venenatis eget euismod faucibus odio ligula phasellus,',
                                            ).show();

                                            //
                                          });
                                        }),
                                  )
                                : emptyWidget(context),
                            flex: 1,
                          ),
                        ],
                      ),
              ));
        });
  }

  getRoWCell(BuildContext context, String s, String s1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: getCustomTextWidget(
              s,
              textColor,
              getScreenPercentSize(context, 2),
              FontWeight.w800,
              TextAlign.start,
              1),
        ),
        Expanded(
          flex: 1,
          child: getCustomTextWidget(
              s1,
              subTextColor,
              getScreenPercentSize(context, 2),
              FontWeight.w500,
              TextAlign.end,
              1),
        )
      ],
    );
  }

  emptyWidget(BuildContext context) {
    double height = getScreenPercentSize(context, 7);
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
            "Your Pets are Empty!",
            primaryColor,
            getScreenPercentSize(context, 2.5),
            FontWeight.w500,
            TextAlign.center,
            1),
        const SizedBox(
          height: 15,
        ),
        MaterialButton(
          onPressed: () {
            Get.toNamed(Routes.NEWPET);
          },
          minWidth: 100,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            height: getScreenPercentSize(context, 7),
            margin: EdgeInsets.only(
                top: getScreenPercentSize(context, 1.2),
                bottom: getHorizontalSpace(context),
                left: getHorizontalSpace(context) + 40,
                right: getHorizontalSpace(context) + 40),
            decoration: ShapeDecoration(
              // color: backgroundColor,
              shape: SmoothRectangleBorder(
                side: BorderSide(color: primaryColor, width: 1.5),
                borderRadius: SmoothBorderRadius(
                  cornerRadius: getPercentSize(height, 25),
                  cornerSmoothing: 0.8,
                ),
              ),
            ),
            child: Center(
                child: getDefaultTextWidget("Add New Pet", TextAlign.center,
                    FontWeight.w500, 20, primaryColor)),
          ),
        ),
      ],
    );
  }
}

class ListItem extends StatefulWidget {
  final AnimalModel subCategoryModel;
  final int index;
  final Function() onChanged;

  const ListItem(this.index, this.subCategoryModel, this.onChanged);

  @override
  RoomEditDeleteItemState createState() =>
      RoomEditDeleteItemState(subCategoryModel, onChanged);
}

class RoomEditDeleteItemState extends State<ListItem> {
  double imageSize = 0;
  void Function() onChanged;
  AnimalModel? model;

  RoomEditDeleteItemState(this.model, this.onChanged);

  @override
  Widget build(BuildContext context) {
    double height = getScreenPercentSize(context, 12);
    double imageSize = getPercentSize(height, 90);
    double margin = getScreenPercentSize(context, 1.5);
    double radius = getScreenPercentSize(context, 1.5);

    setThemePosition();
    return InkWell(
      onTap: onChanged,
      child: getMaterialCell(context,
          widget: Container(
            decoration: getDecoration(context, radius),
            margin: EdgeInsets.symmetric(
                vertical: getScreenPercentSize(context, 1),
                horizontal: getHorizontalSpace(context)),
            height: height,
            child: Row(
              children: [
                Container(
                  height: imageSize,
                  width: imageSize,
                  margin: EdgeInsets.only(
                      right: margin, left: getPercentSize(height, 5)),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(radius)),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      networkPath + model!.images![0],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCustomTextWithFontFamilyWidget(
                              model!.animalName!,
                              Theme.of(context).hintColor,
                              getPercentSize(height, 16),
                              FontWeight.w500,
                              TextAlign.start,
                              1),
                          SizedBox(
                            height: getPercentSize(height, 2),
                          ),
                          getCustomTextWidget(
                              model!.category!.enName.toString(),
                              Theme.of(context).hintColor,
                              getPercentSize(height, 12),
                              FontWeight.w400,
                              TextAlign.start,
                              1),
                          SizedBox(
                            height: getPercentSize(height, 10),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: getCustomTextWithFontFamilyWidget(
                                    model!.type.toString(),
                                    primaryColor,
                                    getPercentSize(height, 15),
                                    FontWeight.w400,
                                    TextAlign.start,
                                    1),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: margin),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    getCartButton(
                                        Icons.edit, cellColor, textColor, () {
                                      Get.toNamed(Routes.EDITPET, arguments:
                                          // {'serial': model!.serial!},
                                          {'model': model});
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            margin: EdgeInsets.all(getPercentSize(height, 12)),
                            child: Image.asset(
                              "${assetsPath}trash.png",
                              height: getPercentSize(height, 17),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  getCartButton(var icon, var color, var iconColor, Function function) {
    double height1 = getScreenPercentSize(context, 12);

    double height = getPercentSize(height1, 20);

    return InkWell(
      child: SizedBox(
        height: height,
        width: height,
        child: Icon(
          icon,
          size: height,
          color: primaryColor,
        ),
      ),
      onTap: () {
        function();
      },
    );
  }
}
