import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';

Widget cartWidget(BuildContext context, model,controller,index) {
  double height = getScreenPercentSize(context, 11);
  double margin = getScreenPercentSize(context, 2);

  double imageSize = getPercentSize(height, 80);
  double radius = getPercentSize(height, 15);

  return

    Container(
      decoration: getDecorationWithRadius(
          radius, Theme.of(context).cardColor),
      margin: EdgeInsets.symmetric(
          vertical: getPercentSize(height, 10)),
      width: double.infinity,
      padding: EdgeInsets.all(
        getPercentSize(height, 6),
      ),
      // height: itemHeight,
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => TrackOrderPage()));
        },
        child: Row(
          children: [
            Container(
              height: imageSize,
              width: imageSize,
              margin: EdgeInsets.only(
                  right: (margin / 2)),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadiusDirectional
                        .circular(radius)),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  networkPath +
                      model.item!.images![0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Column(
                        children: [
                          getCustomTextWidget2(
                              model.item!.enName!,
                              Theme.of(context)
                                  .hintColor,
                              getPercentSize(
                                  height, 18),
                              FontWeight.w500,
                              TextAlign.start,
                              1),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              getCustomTextWidget2(
                                  model.item!.price!
                                      .toString(),
                                  primaryColor,
                                  getPercentSize(
                                      height, 20),
                                  FontWeight.w600,
                                  TextAlign.start,
                                  1),
                              Text(
                                  "   X   ${model.quantity}")
                            ],
                          )
                        ],
                      ),
                      Padding(
                          padding:
                          const EdgeInsets.all(
                              8.0),
                          child: IconButton(
                              onPressed: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType:
                                  DialogType
                                      .warning,
                                  headerAnimationLoop:
                                  true,
                                  animType: AnimType
                                      .bottomSlide,
                                  title:
                                  'Are you sure?',
                                  // reverseBtnOrder: true,
                                  btnOkOnPress: () {
                                    controller
                                        .removeItem(
                                        index);
                                  },
                                  btnOkText: "ok",
                                  btnCancelOnPress:
                                      () {},
                                ).show();
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}
