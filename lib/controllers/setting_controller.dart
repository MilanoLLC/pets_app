import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController with StateMixin<dynamic> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  var storage = getIt<ILocalStorageService>();

  @override
  Future<void> onInit() async {
    super.onInit();
    getThemeStatus();
  }

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
  RxBool isDarkTheme = false.obs;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool(STORAGE_KEYS.theme, isDarkTheme.value);
    if (isDarkTheme.value ==true) {
      textColor = Colors.white;
      subTextColor = Colors.white70;
      iconColor = Colors.grey.shade500;
      defBgColor =Colors.black87;

    } else {
      textColor = Colors.black;
      subTextColor = '#79757F'.toColor();
      iconColor = "#C4CDDE".toColor();
      defBgColor = "#F4F4F4".toColor();
    }
    update();
  }

  getThemeStatus() async {
    var isDark = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool(STORAGE_KEYS.theme) ?? true;
    }).obs;
    isDarkTheme.value = (await isDark.value);
    Get.changeThemeMode(isDarkTheme.value ? ThemeMode.dark : ThemeMode.light);

  }

  void logout(){
    storage.clearUserData();

    Get.toNamed(Routes.SIGNIN);

  }

  mode(){
    isDarkTheme.value=!isDarkTheme.value;
    if (isDarkTheme.value == true) {
      textColor = Colors.white;
      subTextColor = Colors.white70;
      iconColor = Colors.grey.shade500;
      defBgColor = Colors.black87;
    } else {
      textColor = Colors.black;
      subTextColor = '#79757F'.toColor();
      iconColor = "#C4CDDE".toColor();
      defBgColor = "#F4F4F4".toColor();
    }
    Get.changeThemeMode(
      isDarkTheme.value
          ? ThemeMode.dark
          : ThemeMode.light,
    );
    saveThemeStatus();
    update();
  }
}
