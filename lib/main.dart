import 'dart:async';

import 'package:charge_car/pages/home/home_controller.dart';
import 'package:charge_car/pages/home/home_page.dart';
import 'package:charge_car/pages/home/profile/info_account_page.dart';
import 'package:charge_car/pages/qr/qr_scanner_controller.dart';
import 'package:charge_car/pages/qr/qr_scanner_page.dart';
import 'package:charge_car/pages/sign_in/sign_in_controller.dart';
import 'package:charge_car/pages/sign_in/sign_in_page.dart';
import 'package:charge_car/pages/splash_screen/splashscreen_page.dart';
import 'package:charge_car/pages/translation/translations.dart';
import 'package:charge_car/utils/get_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

import 'pages/charging/charging_controller.dart';
import 'pages/charging/charging_page.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  ThemeMode getTheme() {
    var code = LocalDB.getLanguagCode;
    if (code == "light") {
      return ThemeMode.light;
    } else if (code == "dark") {
      return ThemeMode.dark;
    }
    return ThemeMode.system;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: getTheme(),
      theme: Style.light,
      darkTheme: Style.dark,
      translations: LanguageTranslations(),
      locale: Locale(LocalDB.getLanguagCode),
      builder: EasyLoading.init(),
      initialRoute: "/splash",
      getPages: [
        GetPage(name: "/splash", page: () => const SplashScreenPage()),
        GetPage(
          name: "/",
          page: () => const HomePage(),
          binding: HomeBinding(),
          opaque: false,
          showCupertinoParallax: true,
        ),
        GetPage(
          name: "/login",
          page: () => const SignInPage(),
          binding: SignInBinding(),
        ),
        GetPage(
          name: "/qr",
          page: () => const QRScannerPage(),
          binding: QRScannerPageBinding(),
        ),
        GetPage(
          name: "/charging",
          page: () => const ChargingPage(),
          binding: ChargingPageBinding(),
        ),
        GetPage(name: "/info_account", page: () => const InfoAccountPage()),
      ],
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      print(_connectionStatus);
    });
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true
    ..dismissOnTap = false;
}
