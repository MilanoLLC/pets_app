import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/controllers/shop_controller.dart';
import 'package:pets_app/model/OrderItemModel.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/empty_widget.dart';
import 'package:pets_app/widgets/order_item_widget.dart';

class MyOrderPage extends GetView<ShopController> {
  MyOrderPage({Key? key}) : super(key: key);

  bool isData = false;
  double defaultMargin = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    defaultMargin = getHorizontalSpace(context);

    return GetBuilder<ShopController>(
        init: ShopController(),
        builder: (controller) {
          return Scaffold(
            appBar: appBarBack(context, "My Orders", true),
            body: controller.orderItems.isEmpty
                ? Center(
                    child: emptyWidgetWithButton(
                        context,
                        "${assetsPath}no_orders.png",
                        "",
                        "No Orders Yet!",
                        "Explore more and shortlist some products & Pets.",
                        "Go to shop", () {
                      Get.toNamed(Routes.MAIN);
                    }),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getScreenPercentSize(context, 2),
                      ),
                      SizedBox(
                        height: getScreenPercentSize(context, 1),
                      ),
                      ListView.builder(
                        primary: true,
                        shrinkWrap: true,
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultMargin),
                        itemCount: controller.orderItems.length,
                        itemBuilder: (context, index) {
                          OrderItemModel model = controller.orderItems[index];
                          String status = "Delivered";
                          Color color = "#2BBB4D".toColor();

                          if (index % 4 == 0) {
                            status = "Pending";
                            color = "#DE9C2B".toColor();
                          } else if (index % 4 == 1) {
                            status = "Adopted";
                            color = "#2BBB4D".toColor();
                          } else if (index % 4 == 2) {
                            status = "Cancelled";
                            color = "#FA001D".toColor();
                          }

                          return getMaterialCell(context,
                              widget: orderItemWidget(
                                  context, model, status, color, () {}));
                        },
                      )
                    ],
                  ),
          );
        });
  }
}
