// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/screens/Home/home_page.dart';
import 'package:pets_app/screens/Auth/settings_page.dart';
import 'package:pets_app/screens/Animal/pets_page.dart';
import 'package:pets_app/screens/shop/shop_page.dart';
import 'package:pets_app/screens/community/community_page.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import '../../widgets/CustomAnimatedBottomBar.dart';

class MainPage extends StatefulWidget {
  final int? tabPosition;
  const MainPage({Key? key, this.tabPosition}) : super(key: key);

  @override
  _MainPage createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  int _currentIndex = 2;

  Future<bool> _requestPop() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex = 0;
      });
    } else {
      exitApp();
    }
    return Future.value(false);
  }

  Widget getBody() {
    List<Widget> pages = [
      const ShopPage(),
      PetsPage(),
      HomePage(() {
        _currentIndex = 3;
      }, functionViewAllCategories: () {
        Get.toNamed(Routes.CATEGORIES);
      }, functionViewAllAnimals: () {
        setState(() {
          _currentIndex = 1;
        });
      }),
      const CommunityPage(),
      SettingsPage(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.tabPosition != null) {
      setState(() {
        _currentIndex = widget.tabPosition!;
      });
    }
    Future.delayed(const Duration(seconds: 0), () {
      setThemePosition(context: context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            // backgroundColor: backgroundColor,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: backgroundColor,
              statusBarIconBrightness: Brightness.dark,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
          ),
          resizeToAvoidBottomInset: true,
          // backgroundColor: backgroundColor,
          bottomNavigationBar: _buildBottomBar(),
          body: SafeArea(
            child: Container(child: getBody()),
          ),
        ));
  }

  Widget _buildBottomBar() {
    final inactiveColor = iconColor;
    final activeColor = primaryColor;

    double height = getScreenPercentSize(context, 7.5);
    double iconHeight = getPercentSize(height, 28);
    return CustomAnimatedBottomBar(
      containerHeight: height,
      backgroundColor: Theme.of(context).cardColor,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          title: 'Categories',
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          icon: Icons.shopping_cart
          // imageName: "shopping-cart.png",
        ),
        BottomNavyBarItem(
          title: 'All Pets',
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          icon: Icons.pets_outlined
          // imageName: "pet.png",
        ),
        BottomNavyBarItem(
          title: 'Home',
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
          icon: Icons.home_filled
          // imageName: "home.png",
        ),
        BottomNavyBarItem(
          title: 'Community',
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          textAlign: TextAlign.center,
          iconSize: iconHeight,
            icon: Icons.people_alt

          // imageName: "public.png",
        ),
        BottomNavyBarItem(
            iconSize: iconHeight,
            title: 'Settings',
            activeColor: activeColor,
            // imageName: "user.png",
            icon: Icons.person,

            inactiveColor: inactiveColor,
            textAlign: TextAlign.center),
      ],
    );
  }
}
