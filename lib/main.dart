// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/Home/IntroPage.dart';
import 'screens/Home/main_page.dart';
import 'generated/l10n.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SharedPreferences.getInstance().then((instance) async {
    setThemePosition();
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyApp createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  final ThemeData _darkTheme = ThemeData(
    scaffoldBackgroundColor: bgColor,
    appBarTheme: const AppBarTheme(
        color: secondaryColor,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
    hintColor: Colors.white,
    // highlightColor: Colors.white,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.amber,
      disabledColor: Colors.grey,
    ),
    cardColor: secondaryColor,
    // fixTextFieldOutlineLabel: backgroundColor
  );
  final ThemeData _lightTheme = ThemeData(
      scaffoldBackgroundColor: scaffoldBackground,
      appBarTheme: const AppBarTheme(
          color: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.black)),
      brightness: Brightness.light,
      primaryColor: primaryColor,
      hintColor: Colors.black,
      // highlightColor: Colors.black,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blue,
        disabledColor: Colors.grey,
      ),
      cardColor: Colors.white
      );

  @override
  void initState() {
    super.initState();
    var storage = LocalStorageService();

    if (storage.get(STORAGE_KEYS.theme) == null) {
      if (SchedulerBinding.instance.window.platformBrightness ==
          Brightness.dark) {
        storage.set(STORAGE_KEYS.theme, false);
      } else {
        storage.set(STORAGE_KEYS.theme, true);
      }
    }
    var isDarkTheme = storage.get(STORAGE_KEYS.theme);
    print("isDarkTheme = $isDarkTheme");

    if (isDarkTheme == true) {
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
    print("textColor = $textColor");
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // locale: const Locale('ar', 'AR'),
      // translations: LocaleString(),
      getPages: AppPages.pages,
      initialRoute: Routes.INITIAL,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: ThemeMode.dark,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  // bool _isFirstTime = false;
  var storage = getIt<ILocalStorageService>();

  @override
  void initState() {
    super.initState();

    var isIntro = storage.get(STORAGE_KEYS.intro) ?? true;
    print("intro = $isIntro");

    Timer(const Duration(seconds: 3), () {
      if (isIntro) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const IntroPage()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ));
      }
    });
  }

  // void signInValue() async {
  //   _isIntro = await PrefData.getIsIntro();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    // setThemePosition(context: context);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "${assetsPath}splash_icon.png",
              height: getScreenPercentSize(context, 12),
              color: Colors.white,
            ),
            SizedBox(
              height: getScreenPercentSize(context, 1.2),
            ),
            Center(
              child: getSplashTextWidget(
                  "Petshops",
                  Colors.white,
                  getScreenPercentSize(context, 4),
                  FontWeight.w500,
                  TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
