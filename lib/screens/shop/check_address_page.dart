import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/controllers/shop_controller.dart';
import 'package:pets_app/screens/EditAddressPage.dart';
import 'package:pets_app/screens/shop/check_out_page.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/DataFile.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import '../../widgets/ReviewSlider.dart';
import '../../model/AddressModel.dart';
import '../../model/PaymentCardModel.dart';

class CheckAddressPage extends GetView<ShopController> {
  CheckAddressPage({Key? key}) : super(key: key);

  List<AddressModel> addressList = DataFile.getAddressList();

  int currentStep = 0;
  int _selectedAddress = 0;
  List<PaymentCardModel> paymentModelList = DataFile.getPaymentCardList();

  getOption() {
    return ['Address', 'Payment', 'Confirmation'];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double leftMargin = getHorizontalSpace(context);
    double topMargin = getScreenPercentSize(context, 1);

    double cellHeight = MediaQuery.of(context).size.width * 0.2;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("CheckOut"),
        elevation: 0,
        centerTitle: true,
      ),

      body: Column(
        children: [
          SizedBox(
            height: getScreenPercentSize(context, 1.5),
          ),

          ReviewSlider(
              optionStyle: TextStyle(
                fontFamily: customFontFamily,
                fontSize: getScreenPercentSize(context, 1.7),
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
              onChange: (index) {},
              initialValue: 0,
              circleDiameter: getScreenPercentSize(context, 5.5),
              isCash: false,
              width: double.infinity,
              options: getOption()),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: (leftMargin)),
              padding: EdgeInsets.only(left: leftMargin, right: leftMargin),
              child: ListView(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: addressList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: getMaterialCell(context,
                              widget: Container(
                                margin: EdgeInsets.only(
                                    bottom:
                                        getWidthPercentSize(context, 3)),
                                padding: EdgeInsets.all(
                                    getPercentSize(cellHeight, 10)),
                                // decoration: getDecoration(getPercentSize(cellHeight,10 )),
                                decoration: getDecorationWithRadius(
                                    getPercentSize(cellHeight, 10),
                                    primaryColor),

                                height: 100,

                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      (index ==
                                                              _selectedAddress)
                                                          ? Icons
                                                              .radio_button_checked
                                                          : Icons
                                                              .radio_button_unchecked,
                                                      color: (index ==
                                                              _selectedAddress)
                                                          ? primaryColor
                                                          : subTextColor,
                                                      size: getPercentSize(
                                                          cellHeight, 25),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          getWidthPercentSize(
                                                              context, 2),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: getCustomTextWithoutAlignWithFontFamily(
                                                          "city : ${addressList[
                                                                      index]
                                                                  .city!}",
                                                          textColor,
                                                          FontWeight.w500,
                                                          getPercentSize(
                                                              cellHeight,
                                                              20)),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: (topMargin / 2),
                                                      left: (getWidthPercentSize(
                                                              context, 2) +
                                                          getPercentSize(
                                                              cellHeight,
                                                              25))),
                                                  child:
                                                      getCustomTextWidget(
                                                          addressList[index]
                                                              .street!,
                                                          textColor,
                                                          getPercentSize(
                                                              cellHeight,
                                                              15),
                                                          FontWeight.w400,
                                                          TextAlign.start,
                                                          2),
                                                )
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                 const EdgeInsets.only(right: 3),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const EditAddressPage(),
                                                      ));
                                                },
                                                child: Image.asset(
                                                  "${assetsPath}edit.png",
                                                  height: getPercentSize(
                                                      cellHeight, 20),
                                                  // (index ==
                                                  //     _selectedAddress)
                                                  //     ? Icons
                                                  //     .radio_button_checked
                                                  //     : Icons
                                                  //     .radio_button_unchecked,
                                                  // color: (index ==
                                                  //     _selectedAddress)
                                                  //     ? primaryColor
                                                  //     : subTextColor,
                                                  // size: getPercentSize(cellHeight,
                                                  //     25),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          onTap: () {
                            _selectedAddress = index;
                          },
                        );
                      }),
                ],
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: getScreenPercentSize(context, 0.5)),
            child: getButtonWidget(context, "Next", primaryColor, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckOutPage(),
                  ));
            }),
          )
        ],
      ),
    );
  }
}
