// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pets_app/controllers/home_controller.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:get/get.dart';

class CategoriesPage extends GetView<HomeController> {
  CategoriesPage({Key? key}) : super(key: key);

  double padding = 0;
  double defMargin = 0;
  double height = 0;
  bool isAutoFocus = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    padding = getScreenPercentSize(context, 2);
    defMargin = getHorizontalSpace(context);
    height = getScreenPercentSize(context, 5.5);

    double radius = getScreenPercentSize(context, 1.5);

    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Categories"),
              elevation: 0,
              centerTitle: true,
            ),
            body: SizedBox(
              width: double.infinity,
              // color: backgroundColor,
              child: Column(
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
                          child: Container(
                        decoration: getDecorationWithBorder(
                          radius,
                          Theme.of(context).cardColor,
                        ),
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: defMargin),
                            hintText: 'Search by category name..',
                            // prefixIcon: Icon(Icons.search),
                            suffixIcon: Icon(
                              Icons.search,
                              color: subTextColor,
                            ),
                            hintStyle: TextStyle(
                              color: subTextColor,
                              fontFamily: fontFamily,
                              fontSize: getScreenPercentSize(context, 1.7),
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
                            controller.filterSearchResults(string);
                            controller.update();
                          },
                        ),
                      )),
                      SizedBox(width: defMargin),
                    ],
                  ),
                  SizedBox(
                    height: (defMargin),
                  ),
                  Expanded(
                      child: controller.categories.isNotEmpty
                          ? categoryList(context)
                          : Center(
                              child: emptyWidget(context),
                            )),
                ],
              ),
            ),
          );
        });
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

  int selectedCategory = 0;

  categoryList(BuildContext context) {
    defMargin = getScreenPercentSize(context, 1.5);
    var height = getScreenPercentSize(context, 25);
    double crossAxisSpacing = 0;
    var screenWidth = MediaQuery.of(context).size.width;
    var crossAxisCount = 2;
    var width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    var aspectRatio = width / height;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: (defMargin * 1.2)),
      scrollDirection: Axis.vertical,
      primary: false,
      crossAxisSpacing: (defMargin * 2),
      mainAxisSpacing: 0,
      childAspectRatio: aspectRatio,
      children: List.generate(controller.categories.length, (index) {
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
            margin: EdgeInsets.only(top: defMargin, bottom: (defMargin)),
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 90,
                  child: Center(
                    child: Image.network(
                      networkPath + controller.categories[index].imagePath!,
                      height: getPercentSize(height, 60),
                    ),
                  ),
                ),
                //
                Expanded(
                    child: Text(
                  controller.categories[index].enName!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
              ],
            ),
          ),
          onTap: () async {
            showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                });

            // showDialog(
            //   context: context,
            //   barrierDismissible: false,
            //   builder: (BuildContext context) {
            //     return WillPopScope(
            //       onWillPop: () async {
            //         return false;
            //       },
            //       child: SpinKitCircle(
            //         color: Colors.purple,
            //         size: 50.0,
            //       ),
            //     );
            //   },
            // );

            //Close the Loader Dialog after 3 seconds (it doesn't close)
            await controller
                .getProductsByCategory(controller.categories[index].enName!)
                .then((value) => Navigator.pop(context));

            selectedCategory = index;

            Get.toNamed(Routes.PETSBYCATEGORY,
                arguments: {'products': controller.productsByCategory});
            // Navigator.of(context).pop();
          },
        );
      }),
    );
  }
}
