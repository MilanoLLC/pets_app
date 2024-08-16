import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/controllers/notification_controller.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/empty_widget.dart';
import '../../model/ModelNotification.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double totalHeight = SizeConfig.safeBlockHorizontal! * 100;
    double itemHeight = getPercentSize(totalHeight, 25);
    return GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (controller) {
          return WillPopScope(
              child: Scaffold(
                appBar: appBarBack(context, "Notifications", true),
                body: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: getScreenPercentSize(context, 1),
                      ),
                      Expanded(
                        flex: 1,
                        child: controller.notificationList.isNotEmpty
                            ? ListView.builder(
                                primary: true,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                    vertical: getPercentSize(itemHeight, 7)),
                                itemCount: controller.notificationList.length,
                                itemBuilder: (context, index) {
                                  ModelNotification notification =
                                      controller.notificationList[index];
                                  return getMaterialCell(
                                    context,
                                    widget: Container(
                                      decoration: getDecorationWithRadius(
                                          getScreenPercentSize(context, 1.5),
                                          primaryColor),
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                              getHorizontalSpace(context),
                                          vertical:
                                              getPercentSize(itemHeight, 10)),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              getPercentSize(itemHeight, 15),
                                          horizontal:
                                              getPercentSize(itemHeight, 10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          getMaterialWidget(
                                              context,
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: getWidthPercentSize(
                                                        context, 3)),
                                                height: getPercentSize(
                                                    itemHeight, 45),
                                                width: getPercentSize(
                                                    itemHeight, 45),
                                                decoration:
                                                    getDecorationWithColor(
                                                        getPercentSize(
                                                            itemHeight, 15),
                                                        primaryColor),
                                                child: Center(
                                                  child: Image.asset(
                                                    "${assetsPath}notifications.png",
                                                    height: getPercentSize(
                                                        itemHeight, 20),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              getPercentSize(itemHeight, 15),
                                              getPercentSize(itemHeight, 45)),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child:
                                                          getCustomTextWidget(
                                                              notification
                                                                  .title,
                                                              textColor,
                                                              getPercentSize(
                                                                  itemHeight,
                                                                  16),
                                                              FontWeight.w400,
                                                              TextAlign.start,
                                                              1,context),
                                                    ),
                                                    getCustomTextWidget(
                                                        '2 h ago',
                                                        subTextColor,
                                                        getPercentSize(
                                                            itemHeight, 12),
                                                        FontWeight.w400,
                                                        TextAlign.start,
                                                        2,context),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height: getPercentSize(
                                                        itemHeight, 7)),
                                                getCustomTextWidget(
                                                    notification.desc,
                                                    textColor,
                                                    getPercentSize(
                                                        itemHeight, 15),
                                                    FontWeight.w400,
                                                    TextAlign.start,
                                                    2,context),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : emptyWidgetWithSubtext(
                                context,
                                "No Notification Yet!",
                                "We'll notify you when something arrives.",
                                "",
                                Icons.notifications),
                      ),
                    ],
                  ),
                ),
              ),
              onWillPop: () async {
                // finish();
                Get.back();
                return false;
              });
        });
  }
}
