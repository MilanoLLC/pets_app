import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pets_app/controllers/shop_controller.dart';
import 'package:pets_app/model/ServiceModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/cart_button.dart';
import 'package:pets_app/widgets/product_widget.dart';
import 'package:pets_app/widgets/search_widget.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with SingleTickerProviderStateMixin {

  final controller = Get.put(ShopController());
  late TabController tabController;

  int _selectedIndex = 0;
  double padding = 0;
  double defMargin = 0;
  double height = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        _selectedIndex = tabController.index;
      });
      if (tabController.index == 1) {
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
      } else if (tabController.index == 0) {
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

    return LoaderOverlay(
      child: GetBuilder<ShopController>(
        init: ShopController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                controller: tabController,
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
            body: TabBarView(
              controller: tabController,
              children: [
                Stack(
                  children: [
                    ListView(
                      children: [
                        SizedBox(
                          height: getScreenPercentSize(context, 1.5),
                        ),
                        searchWidget(
                          context,
                          (string) {
                            controller.filterSearchResultsByType(string);
                          },
                        ),
                        SizedBox(
                          height: (defMargin / 2),
                        ),
                        productsList(context)
                      ],
                    ),
                    cartButtonWidget(context, controller)
                  ],
                ),
                Stack(
                  children: [
                    ListView(
                      children: [
                        SizedBox(
                          height: getScreenPercentSize(context, 1.5),
                        ),
                        searchWidget(
                          context,
                          (string) {
                            controller.filterSearchResultsByType(string);
                          },
                        ),
                        SizedBox(
                          height: (defMargin / 2),
                        ),
                        productsList(context)
                      ],
                    ),
                    cartButtonWidget(context, controller)
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  productsList(BuildContext context) {
    double crossAxisSpacing = 0;
    var screenWidth = MediaQuery.of(context).size.width;
    var crossAxisCount = 2;
    var height = getScreenPercentSize(context, 37);
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
      children: List.generate(controller.services.length, (index) {
        ServiceModel model = controller.services[index];
        return productWidget(context, model, () {
          controller.addToCart(model, controller.quantity.value);
        });
      }),
    );
  }
}
