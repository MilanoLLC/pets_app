import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/model/IntroModel.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/screens/Auth/sign_in_page.dart';
import 'package:pets_app/screens/Auth/sign_up_page.dart';
import 'package:pets_app/screens/Home/main_page.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:pets_app/widgets/DataFile.dart';
import 'package:pets_app/widgets/PrefData.dart';
import 'package:pets_app/widgets/SizeConfig.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPage createState() {
    return _IntroPage();
  }
}

class _IntroPage extends State<IntroPage> {
  int _position = 0;

  Future<bool> _requestPop() {
    exitApp();

    return Future.value(false);
  }

  final controller = PageController();

  List<IntroModel> introModelList = [];

  void skip() {
    PrefData.setIsIntro(false);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    introModelList = DataFile.getIntroModel();
    Future.delayed(const Duration(seconds: 0), () {
      setThemePosition(context: context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double firstSize = getScreenPercentSize(context, 55);
    double remainSize = getScreenPercentSize(context, 100) - firstSize;
    double defMargin = getScreenPercentSize(context, 2);
    setState(() {});

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: introModelList[_position].color!,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: introModelList[_position].color!,
              statusBarIconBrightness: Brightness.dark,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
          ),
          backgroundColor: backgroundColor,
          body: Stack(
            children: [
              PageView.builder(
                controller: controller,
                itemBuilder: (context, position) {
                  return Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          introModelList[position].color!,
                          introModelList[position].color!,
                          introModelList[position].endColor!,
                          introModelList[position].endColor!
                        ])),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            // height: double.infinity,
                            // width: double.infinity,
                            margin: EdgeInsets.only(
                                bottom: getScreenPercentSize(context, 4)),
                            child: Image.asset(
                              assetsPath + introModelList[position].image!,
                              height: getScreenPercentSize(context, 85),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              horizontal: getHorizontalSpace(context)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: (defMargin * 2), bottom: (defMargin)),
                                child: getCustomTextWidget2(
                                    introModelList[position].name!,
                                    textColor,
                                    getPercentSize(remainSize, 8),
                                    FontWeight.w500,
                                    TextAlign.center,
                                    2),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: getCustomTextWidget2(
                                    introModelList[position].desc!,
                                    textColor,
                                    getScreenPercentSize(context, 2),
                                    FontWeight.w300,
                                    TextAlign.center,
                                    3),
                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: getHorizontalSpace(context),
                                  bottom: defMargin * 7),
                              child: AnimatedSmoothIndicator(
                                activeIndex: _position,
                                count: introModelList.length,
                                effect: WormEffect(
                                    dotColor: Colors.grey,
                                    activeDotColor: primaryColor,
                                    dotHeight:
                                        getScreenPercentSize(context, 1.2),
                                    dotWidth:
                                        getScreenPercentSize(context, 1.2)),
                              ),
                            ))
                      ],
                    ),
                  );
                },
                itemCount: introModelList.length,
                onPageChanged: _onPageViewChange,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: getHorizontalSpace(context),
                      vertical: getScreenPercentSize(context, 4)),
                  child: Row(
                    children: [
                      Visibility(
                        visible: (_position <= 2),
                        child: Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              skip();
                            },
                            child: getTextWidget(
                                "Skip",
                                textColor,
                                getScreenPercentSize(context, 2),
                                FontWeight.bold,
                                TextAlign.start),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: (_position == 3),
                        child: Expanded(
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => SignUpPage(),
                              //     ));
                              Get.toNamed(Routes.MAIN);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: getWidthPercentSize(context, 3)),
                              height: getScreenPercentSize(context, 7),
                              decoration: ShapeDecoration(
                                color: '#FFEDB4'.toColor(),
                                shadows: [
                                  BoxShadow(
                                      color: textColor.withOpacity(0.1),
                                      blurRadius: 2,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 4))
                                ],
                                shape: SmoothRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.white, width: 2),
                                  borderRadius: SmoothBorderRadius(
                                    cornerRadius:
                                        getScreenPercentSize(context, 1.8),
                                    cornerSmoothing: 0.8,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: getTextWidget(
                                    'Home',
                                    textColor,
                                    getScreenPercentSize(context, 2),
                                    FontWeight.bold,
                                    TextAlign.center),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (_position == 3) {
                              Get.toNamed(Routes.MAIN);
                            } else {
                              if (_position < (introModelList.length - 1)) {
                                setState(() {
                                  _position = _position + 1;
                                  controller.jumpToPage(_position);
                                });
                              } else {
                                skip();
                              }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: getWidthPercentSize(context, 3)),
                            height: getScreenPercentSize(context, 7),
                            decoration: ShapeDecoration(
                              color: primaryColor,
                              shadows: [
                                BoxShadow(
                                    color: textColor.withOpacity(0.1),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 4))
                              ],
                              shape: SmoothRectangleBorder(
                                borderRadius: SmoothBorderRadius(
                                  cornerRadius:
                                      getScreenPercentSize(context, 1.8),
                                  cornerSmoothing: 0.8,
                                ),
                              ),
                            ),
                            child: Center(
                              child: getTextWidget(
                                  "Next",
                                  Theme.of(context).hintColor,
                                  getScreenPercentSize(context, 2),
                                  FontWeight.bold,
                                  TextAlign.center),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  _onPageViewChange(int page) {
    _position = page;
    setState(() {});
  }
}
